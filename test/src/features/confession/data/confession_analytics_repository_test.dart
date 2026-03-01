import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:confessionapp/src/features/confession/data/confession_analytics_repository.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

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

    test('MonthlyConfessionData has correct month label', () {
      final data = MonthlyConfessionData(
        month: DateTime(2024, 3, 1),
        count: 2,
      );

      expect(data.monthLabel, 'Mar');
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
  });
}

class TestAppDatabase extends AppDatabase {
  TestAppDatabase(super.e);

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      // Skip syncContent()
    },
  );
}
