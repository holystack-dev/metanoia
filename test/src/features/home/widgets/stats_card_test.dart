import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:confessionapp/src/features/home/presentation/widgets/stats_card.dart';
import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_app.dart';

/// The "Today"/"Yesterday" label counts calendar days. `difference().inDays`
/// truncates elapsed time, so a confession yesterday at 8 PM would read
/// "Today" at 7 AM.
void main() {
  late AppDatabase db;

  setUp(() async {
    await setupTestEnvironment();
    db = TestAppDatabase(NativeDatabase.memory());
  });

  tearDown(() => db.close());

  Future<void> insertFinishedConfession(DateTime date) async {
    await db
        .into(db.confessions)
        .insert(
          ConfessionsCompanion.insert(
            date: Value(date),
            isFinished: const Value(true),
            finishedAt: Value(date),
          ),
        );
  }

  Future<void> pumpCard(WidgetTester tester, {ThemeData? theme}) async {
    await tester.pumpWidget(
      createTestApp(
        database: db,
        theme: theme,
        child: const Scaffold(body: StatsCard()),
      ),
    );
    // Let the Drift stream deliver.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
  }

  /// Tears the tree down inside the test and drains the cleanup timer drift
  /// schedules when its stream subscriptions are cancelled — otherwise the test
  /// framework fails on a pending timer at teardown.
  Future<void> disposeTree(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    // A real duration, not pump() — drift schedules a zero-duration cleanup
    // timer when its stream subscriptions are cancelled, and the fake clock has
    // to actually advance for it to fire.
    await tester.pump(const Duration(milliseconds: 10));
  }

  testWidgets('reads "Today" for a confession made earlier today', (
    tester,
  ) async {
    final now = DateTime.now();
    await insertFinishedConfession(DateTime(now.year, now.month, now.day, 1));

    await pumpCard(tester);

    expect(find.text('Today'), findsOneWidget);
    await disposeTree(tester);
  });

  testWidgets('reads "Yesterday" for one made yesterday evening', (
    tester,
  ) async {
    // Only a few hours have elapsed, but it is a different calendar day.
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1, 20);
    await insertFinishedConfession(yesterday);

    await pumpCard(tester);

    expect(find.text('Yesterday'), findsOneWidget);
    expect(find.text('Today'), findsNothing);
    await disposeTree(tester);
  });

  testWidgets('shows the empty state when there are no confessions', (
    tester,
  ) async {
    await pumpCard(tester);

    expect(find.text('None yet'), findsOneWidget);
    await disposeTree(tester);
  });

  testWidgets('renders in both light and dark themes', (tester) async {
    await insertFinishedConfession(DateTime.now());

    for (final theme in [AppTheme.lightTheme, AppTheme.darkTheme]) {
      await pumpCard(tester, theme: theme);

      expect(tester.takeException(), isNull);
      expect(find.byType(StatsCard), findsOneWidget);
    }

    await disposeTree(tester);
  });
}
