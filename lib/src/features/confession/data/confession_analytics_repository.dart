import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'confession_analytics_repository.g.dart';

@riverpod
ConfessionAnalyticsRepository confessionAnalyticsRepository(Ref ref) {
  return ConfessionAnalyticsRepository(ref.watch(appDatabaseProvider));
}

/// Provider for confession analytics data
@riverpod
Future<ConfessionAnalytics> confessionAnalytics(Ref ref) async {
  final repo = ref.watch(confessionAnalyticsRepositoryProvider);
  return repo.getAnalytics();
}

class ConfessionAnalyticsRepository {
  final AppDatabase _db;

  ConfessionAnalyticsRepository(this._db);

  /// Get comprehensive analytics data
  Future<ConfessionAnalytics> getAnalytics() async {
    final confessions = await (_db.select(_db.confessions)
          ..where((t) => t.isFinished.equals(true))
          ..orderBy([(t) => OrderingTerm.asc(t.date)]))
        .get();

    if (confessions.isEmpty) {
      return ConfessionAnalytics.empty();
    }

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

    // Days since last confession
    final daysSinceLastConfession =
        DateTime.now().difference(lastConfession).inDays;

    // Monthly frequency for the last 12 months
    final monthlyData = _calculateMonthlyFrequency(confessions);

    // Streak calculation (consecutive weeks/months with confession)
    final currentStreak = _calculateCurrentStreak(confessions);

    // Get total items confessed
    int totalItemsConfessed = 0;
    for (final confession in confessions) {
      final items = await (_db.select(_db.confessionItems)
            ..where((t) => t.confessionId.equals(confession.id)))
          .get();
      totalItemsConfessed += items.length;
    }

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

      final count = confessions.where((c) {
        return c.date.isAfter(month.subtract(const Duration(days: 1))) &&
            c.date.isBefore(nextMonth);
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

  String get monthLabel {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month.month - 1];
  }
}
