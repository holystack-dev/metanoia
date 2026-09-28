import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:confessionapp/src/core/utils/date_utils.dart';
import 'package:drift/drift.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'confession_analytics_repository.g.dart';

@riverpod
ConfessionAnalyticsRepository confessionAnalyticsRepository(Ref ref) {
  return ConfessionAnalyticsRepository(ref.watch(appDatabaseProvider));
}

/// Provider for confession analytics data.
///
/// A Drift stream: it recomputes whenever a confession or one of its items
/// changes, so Insights and the home stats can never drift out of sync with
/// the history screen.
@riverpod
Stream<ConfessionAnalytics> confessionAnalytics(Ref ref) {
  return ref.watch(confessionAnalyticsRepositoryProvider).watchAnalytics();
}

class ConfessionAnalyticsRepository {
  final AppDatabase _db;

  ConfessionAnalyticsRepository(this._db);

  /// Built once so the same instance is used to select and to read the column.
  late final Expression<int> _itemCount = _db.confessionItems.id.count();

  /// Every finished confession with the number of items it holds.
  ///
  /// A single grouped join rather than a query per confession.
  JoinedSelectStatement _analyticsQuery() {
    return _db.select(_db.confessions).join([
      leftOuterJoin(
        _db.confessionItems,
        _db.confessionItems.confessionId.equalsExp(_db.confessions.id),
      ),
    ])
      ..addColumns([_itemCount])
      ..where(_db.confessions.isFinished.equals(true))
      ..groupBy([_db.confessions.id])
      ..orderBy([OrderingTerm.asc(_db.confessions.date)]);
  }

  /// Get comprehensive analytics data
  Future<ConfessionAnalytics> getAnalytics() async {
    return _buildAnalytics(await _analyticsQuery().get());
  }

  /// Watch comprehensive analytics data
  Stream<ConfessionAnalytics> watchAnalytics() {
    return _analyticsQuery().watch().map(_buildAnalytics);
  }

  ConfessionAnalytics _buildAnalytics(List<TypedResult> rows) {
    if (rows.isEmpty) {
      return ConfessionAnalytics.empty();
    }

    // Ordered by date ascending by the query above.
    final confessions = [
      for (final row in rows) row.readTable(_db.confessions),
    ];
    final totalItemsConfessed = rows.fold<int>(
      0,
      (sum, row) => sum + (row.read(_itemCount) ?? 0),
    );

    // Calculate statistics
    final totalConfessions = confessions.length;
    final firstConfession = confessions.first.date;
    final lastConfession = confessions.last.date;

    // Calculate average days between confessions
    double? averageDaysBetween;
    if (confessions.length > 1) {
      final totalDays = lastConfession.difference(firstConfession).inDays;
      averageDaysBetween = totalDays / (confessions.length - 1);
    }

    // Counted in calendar days: elapsed hours would report yesterday evening
    // as "today".
    final daysSinceLastConfession = calendarDaysSince(lastConfession);

    // Monthly frequency for the last 12 months
    final monthlyData = _calculateMonthlyFrequency(confessions);

    // Streak calculation (consecutive weeks/months with confession)
    final currentStreak = _calculateCurrentStreak(confessions);

    return ConfessionAnalytics(
      totalConfessions: totalConfessions,
      firstConfessionDate: firstConfession,
      lastConfessionDate: lastConfession,
      averageDaysBetween: averageDaysBetween,
      daysSinceLastConfession: daysSinceLastConfession,
      monthlyFrequency: monthlyData,
      currentStreakWeeks: currentStreak,
      totalItemsConfessed: totalItemsConfessed,
    );
  }

  /// Calculate monthly confession frequency for the last 12 months
  List<MonthlyConfessionData> _calculateMonthlyFrequency(
      List<Confession> confessions) {
    final now = DateTime.now();
    final result = <MonthlyConfessionData>[];

    for (int i = 11; i >= 0; i--) {
      final month = DateTime(now.year, now.month - i, 1);
      final nextMonth = DateTime(now.year, now.month - i + 1, 1);

      // Half-open [month, nextMonth), so each confession lands in exactly one
      // bucket.
      final count = confessions.where((c) {
        return !c.date.isBefore(month) && c.date.isBefore(nextMonth);
      }).length;

      result.add(MonthlyConfessionData(
        month: month,
        count: count,
      ));
    }

    return result;
  }

  /// Calculate current streak (consecutive weeks with at least one confession)
  int _calculateCurrentStreak(List<Confession> confessions) {
    if (confessions.isEmpty) return 0;

    final now = DateTime.now();
    int streak = 0;

    // Get start of current week (Monday at 00:00:00)
    final today = DateTime(now.year, now.month, now.day);
    // DateTime.weekday: Monday = 1, Sunday = 7
    final currentWeekStart = today.subtract(Duration(days: today.weekday - 1));

    // Check each week going backwards
    for (int weeksAgo = 0; weeksAgo < 52; weeksAgo++) {
      final weekStart = currentWeekStart.subtract(Duration(days: weeksAgo * 7));
      final weekEnd = weekStart.add(const Duration(days: 7));

      final hasConfessionInWeek = confessions.any((c) {
        final confessionDate = DateTime(c.date.year, c.date.month, c.date.day);
        return !confessionDate.isBefore(weekStart) &&
            confessionDate.isBefore(weekEnd);
      });

      if (hasConfessionInWeek) {
        streak++;
      } else if (weeksAgo > 0) {
        // Streak broken (allow current week to be empty)
        break;
      }
    }

    return streak;
  }
}

class ConfessionAnalytics {
  final int totalConfessions;
  final DateTime? firstConfessionDate;
  final DateTime? lastConfessionDate;
  final double? averageDaysBetween;
  final int daysSinceLastConfession;
  final List<MonthlyConfessionData> monthlyFrequency;
  final int currentStreakWeeks;
  final int totalItemsConfessed;

  ConfessionAnalytics({
    required this.totalConfessions,
    this.firstConfessionDate,
    this.lastConfessionDate,
    this.averageDaysBetween,
    required this.daysSinceLastConfession,
    required this.monthlyFrequency,
    required this.currentStreakWeeks,
    required this.totalItemsConfessed,
  });

  factory ConfessionAnalytics.empty() {
    return ConfessionAnalytics(
      totalConfessions: 0,
      daysSinceLastConfession: 0,
      monthlyFrequency: [],
      currentStreakWeeks: 0,
      totalItemsConfessed: 0,
    );
  }

  bool get hasData => totalConfessions > 0;
}

class MonthlyConfessionData {
  final DateTime month;
  final int count;

  MonthlyConfessionData({required this.month, required this.count});

  /// Abbreviated month name in [locale].
  String monthLabel(String locale) {
    try {
      return DateFormat.MMM(locale).format(month);
    } catch (_) {
      // The locale's date symbols are missing or it is not one intl knows.
      // A chart axis label is not worth throwing over.
      return DateFormat.MMM().format(month);
    }
  }
}
