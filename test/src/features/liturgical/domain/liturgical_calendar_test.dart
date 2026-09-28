import 'package:confessionapp/src/features/liturgical/domain/liturgical_calendar.dart';
import 'package:flutter_test/flutter_test.dart';

/// Everything here is pure computation, so it can be checked exhaustively
/// against the actual calendar rather than sampled.
void main() {
  const calendar = LiturgicalCalendar();

  DateTime date(int y, int m, int d) => DateTime(y, m, d);

  group('easterSunday (Gregorian Computus)', () {
    // Dates from the Roman calendar; the four the app was specified against
    // (2024-2027) plus a decade around them.
    const known = {
      2020: [4, 12],
      2021: [4, 4],
      2022: [4, 17],
      2023: [4, 9],
      2024: [3, 31],
      2025: [4, 20],
      2026: [4, 5],
      2027: [3, 28],
      2028: [4, 16],
      2029: [4, 1],
      2030: [4, 21],
    };

    known.forEach((year, md) {
      test('Easter $year falls on ${md[0]}/${md[1]}', () {
        expect(
          LiturgicalCalendar.easterSunday(year),
          date(year, md[0], md[1]),
        );
      });
    });

    test('is always a Sunday, and always between 22 March and 25 April', () {
      // The bounds the Computus guarantees. Three centuries of them: a
      // regression in the algorithm cannot hide in a year nobody tested.
      for (var year = 1900; year <= 2200; year++) {
        final easter = LiturgicalCalendar.easterSunday(year);
        expect(easter.weekday, DateTime.sunday, reason: 'Easter $year');
        expect(
          easter.isBefore(date(year, 3, 22)) || easter.isAfter(date(year, 4, 25)),
          isFalse,
          reason: 'Easter $year out of bounds: $easter',
        );
      }
    });
  });

  group('Ash Wednesday', () {
    const known = {
      2024: [2, 14],
      2025: [3, 5],
      2026: [2, 18],
      2027: [2, 10],
    };

    known.forEach((year, md) {
      test('$year falls on ${md[0]}/${md[1]}', () {
        expect(
          LiturgicalCalendar.ashWednesday(year),
          date(year, md[0], md[1]),
        );
      });
    });

    test('is always a Wednesday, 46 days before Easter', () {
      for (var year = 2000; year <= 2100; year++) {
        final ash = LiturgicalCalendar.ashWednesday(year);
        expect(ash.weekday, DateTime.wednesday, reason: 'Ash Wednesday $year');
        expect(
          daysBetweenDates(ash, LiturgicalCalendar.easterSunday(year)),
          46,
          reason: 'Ash Wednesday $year',
        );
      }
    });
  });

  group('Pentecost', () {
    const known = {
      2024: [5, 19],
      2025: [6, 8],
      2026: [5, 24],
      2027: [5, 16],
    };

    known.forEach((year, md) {
      test('$year falls on ${md[0]}/${md[1]}', () {
        expect(LiturgicalCalendar.pentecost(year), date(year, md[0], md[1]));
      });
    });

    test('is always a Sunday, 49 days after Easter', () {
      for (var year = 2000; year <= 2100; year++) {
        final pentecost = LiturgicalCalendar.pentecost(year);
        expect(pentecost.weekday, DateTime.sunday, reason: 'Pentecost $year');
        expect(
          daysBetweenDates(LiturgicalCalendar.easterSunday(year), pentecost),
          49,
        );
      }
    });
  });

  group('Palm Sunday', () {
    test('2026 falls on 29 March, a week before Easter', () {
      expect(LiturgicalCalendar.palmSunday(2026), date(2026, 3, 29));
    });
  });

  group('First Sunday of Advent', () {
    const known = {
      2024: [12, 1],
      2025: [11, 30],
      2026: [11, 29],
      2027: [11, 28],
    };

    known.forEach((year, md) {
      test('$year falls on ${md[0]}/${md[1]}', () {
        expect(
          LiturgicalCalendar.firstSundayOfAdvent(year),
          date(year, md[0], md[1]),
        );
      });
    });

    test('when Christmas is itself a Sunday, Advent still starts four Sundays '
        'earlier (2022)', () {
      // The edge case the naive "step back to the previous Sunday" gets wrong:
      // 25 December 2022 was a Sunday, and Advent began on 27 November.
      expect(date(2022, 12, 25).weekday, DateTime.sunday);
      expect(LiturgicalCalendar.firstSundayOfAdvent(2022), date(2022, 11, 27));
    });

    test('is always a Sunday, 22-28 days before Christmas', () {
      for (var year = 2000; year <= 2100; year++) {
        final advent = LiturgicalCalendar.firstSundayOfAdvent(year);
        expect(advent.weekday, DateTime.sunday, reason: 'Advent $year');
        final gap = daysBetweenDates(advent, date(year, 12, 25));
        expect(gap, inInclusiveRange(22, 28), reason: 'Advent $year');
      }
    });
  });

  group('fixed feasts', () {
    test('are on their fixed dates', () {
      expect(LiturgicalCalendar.assumption(2026), date(2026, 8, 15));
      expect(LiturgicalCalendar.allSaints(2026), date(2026, 11, 1));
      expect(LiturgicalCalendar.immaculateConception(2026), date(2026, 12, 8));
      expect(LiturgicalCalendar.christmas(2026), date(2026, 12, 25));
    });
  });

  group('seasonOn', () {
    // 2026: Ash Wednesday 18 Feb, Palm Sunday 29 Mar, Easter 5 Apr,
    // Pentecost 24 May, Advent 29 Nov.
    void expectSeason(DateTime day, LiturgicalSeason season) {
      expect(calendar.seasonOn(day), season, reason: '$day');
    }

    test('Shrove Tuesday is still Ordinary Time', () {
      expectSeason(date(2026, 2, 17), LiturgicalSeason.ordinaryTime);
    });

    test('Lent runs from Ash Wednesday to the eve of Palm Sunday', () {
      expectSeason(date(2026, 2, 18), LiturgicalSeason.lent);
      expectSeason(date(2026, 3, 20), LiturgicalSeason.lent);
      expectSeason(date(2026, 3, 28), LiturgicalSeason.lent);
    });

    test('Holy Week runs from Palm Sunday to Holy Saturday', () {
      expectSeason(date(2026, 3, 29), LiturgicalSeason.holyWeek);
      expectSeason(date(2026, 4, 2), LiturgicalSeason.holyWeek);
      expectSeason(date(2026, 4, 4), LiturgicalSeason.holyWeek);
    });

    test('Easter runs from Easter Sunday to Pentecost inclusive', () {
      expectSeason(date(2026, 4, 5), LiturgicalSeason.easter);
      expectSeason(date(2026, 5, 1), LiturgicalSeason.easter);
      expectSeason(date(2026, 5, 24), LiturgicalSeason.easter);
      expectSeason(date(2026, 5, 25), LiturgicalSeason.ordinaryTime);
    });

    test('Advent runs from its first Sunday to Christmas Eve', () {
      expectSeason(date(2026, 11, 28), LiturgicalSeason.ordinaryTime);
      expectSeason(date(2026, 11, 29), LiturgicalSeason.advent);
      expectSeason(date(2026, 12, 24), LiturgicalSeason.advent);
    });

    test('Christmas runs from 25 December through Epiphany, across the year '
        'boundary', () {
      expectSeason(date(2026, 12, 25), LiturgicalSeason.christmas);
      expectSeason(date(2026, 12, 31), LiturgicalSeason.christmas);
      expectSeason(date(2027, 1, 1), LiturgicalSeason.christmas);
      expectSeason(date(2027, 1, 6), LiturgicalSeason.christmas);
      expectSeason(date(2027, 1, 7), LiturgicalSeason.ordinaryTime);
    });

    test('the time of day is irrelevant', () {
      expect(
        calendar.seasonOn(DateTime(2026, 2, 18, 23, 59, 59)),
        LiturgicalSeason.lent,
      );
    });
  });

  group('DST boundaries', () {
    // A day is 23 or 25 hours long across a DST transition, so anything built
    // on `Duration(days: n)` drifts by a day here. These dates are transition
    // days in the northern hemisphere (US spring-forward, EU spring-forward /
    // Palm Sunday 2026, US fall-back / All Saints 2026).

    test('addDays crosses a spring-forward day exactly', () {
      expect(addDays(date(2026, 3, 7), 2), date(2026, 3, 9));
      expect(addDays(date(2026, 3, 9), -2), date(2026, 3, 7));
    });

    test('addDays crosses a fall-back day exactly', () {
      expect(addDays(date(2026, 10, 31), 2), date(2026, 11, 2));
      expect(addDays(date(2026, 11, 2), -2), date(2026, 10, 31));
    });

    test('a season boundary that lands on a DST transition is still exact', () {
      // Palm Sunday 2026 is 29 March — the EU spring-forward day.
      expect(calendar.seasonOn(date(2026, 3, 29)), LiturgicalSeason.holyWeek);
      expect(calendar.seasonOn(date(2026, 3, 28)), LiturgicalSeason.lent);
    });

    test('a feast that lands on a DST transition keeps its date', () {
      // All Saints 2026 is 1 November — the US fall-back day.
      final allSaints = LiturgicalCalendar.allSaints(2026);
      expect(allSaints, date(2026, 11, 1));
      expect(
        calendar.daysUntil(Feast(FeastId.allSaints, allSaints), date(2026, 10, 30)),
        2,
      );
    });

    test('feasts derived across a DST transition land on the right day', () {
      // Easter 2026 (5 April) is 46 days after Ash Wednesday (18 February),
      // and the US DST transition (8 March) sits between them.
      expect(addDays(LiturgicalCalendar.ashWednesday(2026), 46),
          LiturgicalCalendar.easterSunday(2026));
    });
  });

  group('upcomingFeasts', () {
    test('includes a feast that falls today', () {
      final feasts = calendar.upcomingFeasts(date(2026, 12, 25), withinDays: 0);
      expect(feasts.map((f) => f.id), [FeastId.christmas]);
    });

    test('returns the window in calendar order', () {
      final feasts = calendar.upcomingFeasts(date(2026, 12, 1), withinDays: 30);
      expect(
        feasts.map((f) => f.id),
        [FeastId.immaculateConception, FeastId.christmas],
      );
      expect(feasts.first.date, date(2026, 12, 8));
    });

    test('crosses the year boundary', () {
      // From 20 December 2026, a 60-day window reaches Ash Wednesday 2027
      // (10 February) — which lives in the *next* year's calendar.
      final feasts = calendar.upcomingFeasts(date(2026, 12, 20), withinDays: 60);
      expect(
        feasts.map((f) => f.id),
        [FeastId.christmas, FeastId.ashWednesday],
      );
      expect(feasts.last.date, date(2027, 2, 10));
    });

    test('excludes feasts that have already passed', () {
      final feasts = calendar.upcomingFeasts(date(2026, 12, 9), withinDays: 30);
      expect(feasts.map((f) => f.id), isNot(contains(FeastId.immaculateConception)));
    });

    test('daysUntil counts calendar days', () {
      final christmas = Feast(FeastId.christmas, date(2026, 12, 25));
      expect(calendar.daysUntil(christmas, date(2026, 12, 25)), 0);
      expect(calendar.daysUntil(christmas, DateTime(2026, 12, 24, 23, 59)), 1);
      expect(calendar.daysUntil(christmas, date(2026, 12, 16)), 9);
    });
  });
}
