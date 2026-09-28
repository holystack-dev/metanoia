import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:confessionapp/src/features/journal/domain/models/journal_models.dart';
import 'package:confessionapp/src/features/journal/presentation/widgets/month_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/test_app.dart';

void main() {
  setUpAll(setupTestEnvironment);

  late TestAppDatabase db;

  setUp(() {
    db = TestAppDatabase();
  });

  tearDown(() async {
    await db.close();
  });

  /// July 2026: starts on a Wednesday, 31 days.
  final month = DateTime(2026, 7, 1);
  final today = DateTime(2026, 7, 12);

  JournalDay dayWith({required int day}) {
    return JournalDay(
      entry: JournalEntry(
        id: day,
        entryDate: DateTime(2026, 7, day),
        gratitude: 'A grace',
        reflection: null,
        resolution: null,
        mood: null,
        createdAt: DateTime(2026, 7, day),
        updatedAt: DateTime(2026, 7, day),
      ),
      marks: const [],
    );
  }

  Widget calendarUnder(ThemeData theme) {
    return createTestApp(
      database: db,
      theme: theme,
      child: Scaffold(
        // Scrollable, exactly as on the journal screen: the calendar is as tall
        // as its rows need, not as tall as the viewport.
        body: SingleChildScrollView(
          child: MonthCalendar(
            month: month,
            today: today,
            days: {
              DateTime(2026, 7, 3): dayWith(day: 3),
              DateTime(2026, 7, 9): dayWith(day: 9),
              DateTime(2026, 7, 11): dayWith(day: 11),
            },
            onDaySelected: (_) {},
          ),
        ),
      ),
    );
  }

  for (final entry in {
    'light': AppTheme.lightTheme,
    'dark': AppTheme.darkTheme,
  }.entries) {
    testWidgets('renders the month in the ${entry.key} theme', (tester) async {
      await tester.pumpWidget(calendarUnder(entry.value));
      await tester.pump();

      // Every day of July is present, and no day of the next month.
      expect(find.text('1'), findsOneWidget);
      expect(find.text('31'), findsOneWidget);
      expect(find.text('32'), findsNothing);

      // One gentle dot is drawn for each day with an entry (the 3rd, 9th and
      // 11th), all in the same primary colour from the scheme — a warm record
      // of the days prayed, not a mood to score. The today circle uses
      // primaryContainer and is not one of these dots.
      final scheme = entry.value.colorScheme;
      final dotColors = tester
          .widgetList<DecoratedBox>(find.byType(DecoratedBox))
          .map((box) => (box.decoration as BoxDecoration).color)
          .whereType<Color>()
          .where((color) => color != scheme.primaryContainer)
          .toList();

      expect(dotColors, everyElement(scheme.primary));
      expect(dotColors, hasLength(3));

      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('taps report the day that was tapped, and future days do not', (
    tester,
  ) async {
    final tapped = <DateTime>[];

    await tester.pumpWidget(
      createTestApp(
        database: db,
        theme: AppTheme.lightTheme,
        child: Scaffold(
          body: SingleChildScrollView(
            child: MonthCalendar(
              month: month,
              today: today,
              days: const {},
              onDaySelected: tapped.add,
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    await tester.tap(find.text('10'));
    await tester.pump();
    expect(tapped, [DateTime(2026, 7, 10)]);

    // The 20th is still to come: there is nothing to reflect on yet.
    await tester.tap(find.text('20'));
    await tester.pump();
    expect(tapped, [DateTime(2026, 7, 10)]);
  });
}
