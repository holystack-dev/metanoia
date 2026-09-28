import 'package:confessionapp/src/core/utils/date_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('calendarDaysBetween', () {
    test('same calendar day is 0 regardless of time', () {
      expect(
        calendarDaysBetween(
          DateTime(2026, 7, 12, 0, 1),
          DateTime(2026, 7, 12, 23, 59),
        ),
        0,
      );
    });

    test('yesterday evening to this morning is 1, not 0', () {
      // Only 11 elapsed hours: `inDays` would truncate to 0 and say "Today"
      // for yesterday's confession.
      expect(
        calendarDaysBetween(
          DateTime(2026, 7, 11, 20, 0),
          DateTime(2026, 7, 12, 7, 0),
        ),
        1,
      );
    });

    test('counts whole calendar days across a month boundary', () {
      expect(
        calendarDaysBetween(DateTime(2026, 1, 31), DateTime(2026, 2, 2)),
        2,
      );
    });

    test('is exact across a DST transition', () {
      // Local midnight-to-midnight is 23 or 25 hours on these days, which
      // `inDays` would truncate.
      expect(
        calendarDaysBetween(DateTime(2026, 3, 8, 12), DateTime(2026, 3, 9, 12)),
        1,
      );
      expect(
        calendarDaysBetween(
          DateTime(2026, 11, 1, 12),
          DateTime(2026, 11, 2, 12),
        ),
        1,
      );
    });

    test('is negative for a future date', () {
      expect(
        calendarDaysBetween(DateTime(2026, 7, 12), DateTime(2026, 7, 10)),
        -2,
      );
    });
  });

  group('calendarDaysSince', () {
    test('uses the injected now', () {
      expect(
        calendarDaysSince(
          DateTime(2026, 7, 5, 23, 30),
          now: DateTime(2026, 7, 12, 0, 15),
        ),
        7,
      );
    });
  });

  group('journalDayFromPath', () {
    final now = DateTime(2026, 7, 12, 9, 30);
    final today = DateTime(2026, 7, 12);

    DateTime dayFor(String? raw) => journalDayFromPath(raw, now: now);

    test('accepts a past day', () {
      expect(dayFor('2026-07-01'), DateTime(2026, 7, 1));
    });

    test('accepts today', () {
      expect(dayFor('2026-07-12'), today);
    });

    test('clamps a future day to today', () {
      // The month calendar disables future days; the route must not be a way
      // around that, or the user creates a future-dated entry that shows as a
      // dot in a future month and distorts the streak.
      expect(dayFor('2030-01-01'), today);
      expect(dayFor('2026-07-13'), today);
    });

    test('clamps a rolled-over date to today', () {
      // `DateTime.tryParse` accepts this and rolls the components over into a
      // valid date several years in the future.
      expect(dayFor('2026-99-99'), today);
      expect(dayFor('2026-13-01'), today);
      expect(dayFor('2026-02-30'), today);
    });

    test('falls back to today for anything unparseable or missing', () {
      for (final raw in [
        null,
        '',
        'tomorrow',
        '2026-7-1',
        '2026-07-01T10:00',
      ]) {
        expect(dayFor(raw), today, reason: 'raw: $raw');
      }
    });

    test('strips the time of day', () {
      expect(journalDayFromPath('2026-07-12', now: now).hour, 0);
    });
  });
}
