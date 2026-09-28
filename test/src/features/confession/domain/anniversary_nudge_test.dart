import 'package:confessionapp/src/features/confession/domain/anniversary_nudge.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  AnniversaryNudge? nudge({
    required int totalConfessions,
    required double? averageDaysBetween,
    required int daysSinceLastConfession,
    int? daysSinceDismissal,
  }) {
    return evaluateAnniversaryNudge(
      totalConfessions: totalConfessions,
      averageDaysBetween: averageDaysBetween,
      daysSinceLastConfession: daysSinceLastConfession,
      daysSinceDismissal: daysSinceDismissal,
    );
  }

  group('not enough history', () {
    test('says nothing after a single confession', () {
      expect(
        nudge(
          totalConfessions: 1,
          averageDaysBetween: null,
          daysSinceLastConfession: 400,
        ),
        isNull,
      );
    });

    test('says nothing after two, however long the gap', () {
      // Two confessions make an average, not a habit; the app refuses to invent
      // a cadence from them.
      expect(
        nudge(
          totalConfessions: 2,
          averageDaysBetween: 30,
          daysSinceLastConfession: 365,
        ),
        isNull,
      );
    });

    test('says nothing when there is no average at all', () {
      expect(
        nudge(
          totalConfessions: 5,
          averageDaysBetween: null,
          daysSinceLastConfession: 90,
        ),
        isNull,
      );
    });
  });

  group('against the user\'s own cadence', () {
    test('a gap below the average says nothing', () {
      expect(
        nudge(
          totalConfessions: 6,
          averageDaysBetween: 30,
          daysSinceLastConfession: 20,
        ),
        isNull,
      );
    });

    test('a gap merely at the average says nothing', () {
      expect(
        nudge(
          totalConfessions: 6,
          averageDaysBetween: 30,
          daysSinceLastConfession: 30,
        ),
        isNull,
      );
    });

    test('a gap just past the average is not yet "meaningful"', () {
      // Threshold for a 30-day cadence is 37.5 days.
      expect(
        nudge(
          totalConfessions: 6,
          averageDaysBetween: 30,
          daysSinceLastConfession: 37,
        ),
        isNull,
      );
    });

    test('a gap well past the average invites', () {
      final result = nudge(
        totalConfessions: 6,
        averageDaysBetween: 30,
        daysSinceLastConfession: 45,
      );

      expect(result, isNotNull);
      expect(result!.daysSinceLastConfession, 45);
      expect(result.weeksSinceLastConfession, 6);
    });

    test('a tight cadence is not nagged after a couple of days', () {
      // Someone who confesses weekly is not "overdue" nine days later: the
      // seven-day floor and the fortnight floor both protect them.
      expect(
        nudge(
          totalConfessions: 10,
          averageDaysBetween: 7,
          daysSinceLastConfession: 9,
        ),
        isNull,
      );
      expect(
        nudge(
          totalConfessions: 10,
          averageDaysBetween: 7,
          daysSinceLastConfession: 14,
        ),
        isNull,
      );
    });

    test('but a weekly cadence gone quiet for a fortnight does invite', () {
      final result = nudge(
        totalConfessions: 10,
        averageDaysBetween: 7,
        daysSinceLastConfession: 15,
      );

      expect(result, isNotNull);
      expect(result!.weeksSinceLastConfession, 2);
    });

    test('a yearly cadence is judged against a year, not a month', () {
      expect(
        nudge(
          totalConfessions: 4,
          averageDaysBetween: 365,
          daysSinceLastConfession: 400,
        ),
        isNull,
      );
      expect(
        nudge(
          totalConfessions: 4,
          averageDaysBetween: 365,
          daysSinceLastConfession: 460,
        ),
        isNotNull,
      );
    });
  });

  group('dismissal', () {
    test('stays quiet for a fortnight after being dismissed', () {
      expect(
        nudge(
          totalConfessions: 6,
          averageDaysBetween: 30,
          daysSinceLastConfession: 45,
          daysSinceDismissal: 0,
        ),
        isNull,
      );
      expect(
        nudge(
          totalConfessions: 6,
          averageDaysBetween: 30,
          daysSinceLastConfession: 58,
          daysSinceDismissal: 13,
        ),
        isNull,
      );
    });

    test('may speak again once the fortnight is up', () {
      expect(
        nudge(
          totalConfessions: 6,
          averageDaysBetween: 30,
          daysSinceLastConfession: 59,
          daysSinceDismissal: 14,
        ),
        isNotNull,
      );
    });
  });

  test('weeks are whole weeks, rounded down', () {
    const nudge = AnniversaryNudge(
      daysSinceLastConfession: 20,
      averageDaysBetween: 10,
    );
    expect(nudge.weeksSinceLastConfession, 2);
  });
}
