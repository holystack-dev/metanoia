import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:confessionapp/src/features/confession/data/confession_analytics_repository.dart';
import 'package:confessionapp/src/features/confession/data/confession_repository.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../../../../helpers/test_app.dart';

void main() {
  late AppDatabase db;
  late ProviderContainer container;

  setUp(() {
    db = TestAppDatabase(NativeDatabase.memory());
    container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
  });

  tearDown(() async {
    await db.close();
    container.dispose();
  });

  Future<int> createConfession({
    required DateTime date,
    bool isFinished = true,
    int itemCount = 0,
  }) async {
    final confessionId = await db.into(db.confessions).insert(
      ConfessionsCompanion.insert(
        date: Value(date),
        isFinished: Value(isFinished),
        finishedAt: isFinished ? Value(date) : const Value.absent(),
      ),
    );

    // Add confession items if requested
    for (int i = 0; i < itemCount; i++) {
      await db.into(db.confessionItems).insert(
        ConfessionItemsCompanion.insert(
          confessionId: confessionId,
          content: 'Test item $i',
        ),
      );
    }

    return confessionId;
  }

  group('ConfessionAnalyticsRepository', () {
    test('getAnalytics returns empty analytics when no confessions exist', () async {
      final repository = container.read(confessionAnalyticsRepositoryProvider);

      final analytics = await repository.getAnalytics();

      expect(analytics.hasData, false);
      expect(analytics.totalConfessions, 0);
      expect(analytics.firstConfessionDate, isNull);
      expect(analytics.lastConfessionDate, isNull);
      expect(analytics.averageDaysBetween, isNull);
      expect(analytics.monthlyFrequency, isEmpty);
      expect(analytics.currentStreakWeeks, 0);
      expect(analytics.totalItemsConfessed, 0);
    });

    test('getAnalytics only counts finished confessions', () async {
      final repository = container.read(confessionAnalyticsRepositoryProvider);

      // Create one finished and one unfinished confession
      await createConfession(
        date: DateTime.now().subtract(const Duration(days: 7)),
        isFinished: true,
      );
      await createConfession(
        date: DateTime.now(),
        isFinished: false, // Draft
      );

      final analytics = await repository.getAnalytics();

      expect(analytics.totalConfessions, 1);
    });

    test('getAnalytics calculates total confessions correctly', () async {
      final repository = container.read(confessionAnalyticsRepositoryProvider);

      await createConfession(
        date: DateTime.now().subtract(const Duration(days: 21)),
      );
      await createConfession(
        date: DateTime.now().subtract(const Duration(days: 14)),
      );
      await createConfession(
        date: DateTime.now().subtract(const Duration(days: 7)),
      );

      final analytics = await repository.getAnalytics();

      expect(analytics.totalConfessions, 3);
      expect(analytics.hasData, true);
    });

    test('getAnalytics calculates average days between confessions', () async {
      final repository = container.read(confessionAnalyticsRepositoryProvider);

      // Create confessions 7 days apart
      final firstDate = DateTime.now().subtract(const Duration(days: 14));
      final secondDate = DateTime.now().subtract(const Duration(days: 7));
      final thirdDate = DateTime.now();

      await createConfession(date: firstDate);
      await createConfession(date: secondDate);
      await createConfession(date: thirdDate);

      final analytics = await repository.getAnalytics();

      // 14 days total, 2 intervals = 7 days average
      expect(analytics.averageDaysBetween, closeTo(7.0, 0.5));
    });

    test('getAnalytics calculates days since last confession', () async {
      final repository = container.read(confessionAnalyticsRepositoryProvider);

      final lastConfessionDate = DateTime.now().subtract(const Duration(days: 5));
      await createConfession(date: lastConfessionDate);

      final analytics = await repository.getAnalytics();

      expect(analytics.daysSinceLastConfession, 5);
    });

    test('getAnalytics counts total items confessed', () async {
      final repository = container.read(confessionAnalyticsRepositoryProvider);

      await createConfession(
        date: DateTime.now().subtract(const Duration(days: 14)),
        itemCount: 3,
      );
      await createConfession(
        date: DateTime.now().subtract(const Duration(days: 7)),
        itemCount: 5,
      );

      final analytics = await repository.getAnalytics();

      expect(analytics.totalItemsConfessed, 8);
    });

    test('getAnalytics tracks first and last confession dates', () async {
      final repository = container.read(confessionAnalyticsRepositoryProvider);

      final firstDate = DateTime(2024, 1, 1);
      final lastDate = DateTime(2024, 12, 1);

      await createConfession(date: firstDate);
      await createConfession(date: DateTime(2024, 6, 1));
      await createConfession(date: lastDate);

      final analytics = await repository.getAnalytics();

      expect(analytics.firstConfessionDate?.year, 2024);
      expect(analytics.firstConfessionDate?.month, 1);
      expect(analytics.lastConfessionDate?.month, 12);
    });

    test('getAnalytics calculates monthly frequency', () async {
      final repository = container.read(confessionAnalyticsRepositoryProvider);

      final now = DateTime.now();
      // Create confessions in current month
      await createConfession(date: DateTime(now.year, now.month, 1));
      await createConfession(date: DateTime(now.year, now.month, 15));

      final analytics = await repository.getAnalytics();

      expect(analytics.monthlyFrequency, isNotEmpty);
      // The last entry should be current month with 2 confessions
      final currentMonthData = analytics.monthlyFrequency.lastWhere(
        (m) => m.month.month == now.month && m.month.year == now.year,
      );
      expect(currentMonthData.count, 2);
    });

    test('MonthlyConfessionData labels the month in the given locale', () async {
      // In the app the localization delegates load these; a bare test does not.
      await initializeDateFormatting('en');
      await initializeDateFormatting('es');

      final data = MonthlyConfessionData(
        month: DateTime(2024, 3, 1),
        count: 2,
      );

      expect(data.monthLabel('en'), 'Mar');
      // The month label is localized, not a hardcoded English abbreviation.
      expect(data.monthLabel('es'), 'mar');
    });

    test('monthLabel falls back instead of throwing on an unknown locale', () {
      final data = MonthlyConfessionData(
        month: DateTime(2024, 3, 1),
        count: 2,
      );

      expect(() => data.monthLabel('zz'), returnsNormally);
    });
  });

  group('Confession Analytics Providers', () {
    test('confessionAnalyticsProvider returns analytics', () async {
      await createConfession(
        date: DateTime.now().subtract(const Duration(days: 7)),
        itemCount: 2,
      );

      final analytics = await container.read(confessionAnalyticsProvider.future);

      expect(analytics.totalConfessions, 1);
      expect(analytics.totalItemsConfessed, 2);
    });

    /// Analytics is a Drift stream, read by the Insights screen and the home
    /// stats. Nothing below invalidates it: it must re-emit on its own.
    test('confessionAnalyticsProvider re-emits when a confession is added',
        () async {
      final sub = container.listen(confessionAnalyticsProvider, (_, __) {});
      addTearDown(sub.close);

      final initial = await container.read(confessionAnalyticsProvider.future);
      expect(initial.hasData, false);

      await createConfession(date: DateTime.now(), itemCount: 3);

      // The items are inserted after the confession, so wait for the emission
      // that carries all of them, not just the first one.
      await waitUntil(
        () =>
            container
                .read(confessionAnalyticsProvider)
                .valueOrNull
                ?.totalItemsConfessed ==
            3,
        reason: 'the new confession never reached the analytics stream',
      );
      expect(
        container.read(confessionAnalyticsProvider).requireValue
            .totalConfessions,
        1,
      );
    });

    test('confessionAnalyticsProvider re-emits when a confession is deleted',
        () async {
      final id = await createConfession(date: DateTime.now(), itemCount: 2);

      final sub = container.listen(confessionAnalyticsProvider, (_, __) {});
      addTearDown(sub.close);

      final initial = await container.read(confessionAnalyticsProvider.future);
      expect(initial.totalConfessions, 1);

      await container.read(confessionRepositoryProvider).deleteConfession(id);

      await waitUntil(
        () =>
            container.read(confessionAnalyticsProvider).valueOrNull?.hasData ==
            false,
        reason: 'the deleted confession never left the analytics stream',
      );
    });
  });
}
