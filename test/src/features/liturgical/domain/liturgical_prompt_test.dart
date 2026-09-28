import 'package:confessionapp/src/features/liturgical/domain/liturgical_calendar.dart';
import 'package:confessionapp/src/features/liturgical/domain/liturgical_prompt.dart';
import 'package:flutter_test/flutter_test.dart';

/// The rule under test is "do not nag": at most one prompt, only when the
/// calendar has something timely to say, and never again once dismissed.
void main() {
  DateTime date(int y, int m, int d) => DateTime(y, m, d);

  // 2026: Ash Wednesday 18 Feb, Palm Sunday 29 Mar, Easter 5 Apr,
  // Immaculate Conception 8 Dec, Advent 29 Nov, Christmas 25 Dec.

  group('season prompts', () {
    test('Lent speaks on the day it begins', () {
      expect(
        liturgicalPromptOn(date(2026, 2, 18)),
        const SeasonPrompt(season: LiturgicalSeason.lent, year: 2026),
      );
    });

    test('and for the first week only — not for forty days', () {
      // Day 6 of Lent: still worth saying.
      expect(
        liturgicalPromptOn(date(2026, 2, 24)),
        const SeasonPrompt(season: LiturgicalSeason.lent, year: 2026),
      );
      // Day 7 and after: silence.
      expect(liturgicalPromptOn(date(2026, 2, 25)), isNull);
      expect(liturgicalPromptOn(date(2026, 3, 20)), isNull);
    });

    test('Holy Week speaks, and outranks nothing else that week', () {
      expect(
        liturgicalPromptOn(date(2026, 3, 29)),
        const SeasonPrompt(season: LiturgicalSeason.holyWeek, year: 2026),
      );
      // Easter itself raises no feast prompt: the season says it better.
      expect(
        liturgicalPromptOn(date(2026, 4, 1)),
        const SeasonPrompt(season: LiturgicalSeason.holyWeek, year: 2026),
      );
    });

    test('Advent speaks on the day it begins', () {
      expect(
        liturgicalPromptOn(date(2026, 11, 29)),
        const SeasonPrompt(season: LiturgicalSeason.advent, year: 2026),
      );
    });

    test('Easter, Christmas and Ordinary Time are silent', () {
      expect(liturgicalPromptOn(date(2026, 4, 6)), isNull); // Easter Monday
      expect(liturgicalPromptOn(date(2026, 12, 26)), isNull); // Christmas
      expect(liturgicalPromptOn(date(2026, 7, 1)), isNull); // Ordinary Time
    });
  });

  group('feast prompts', () {
    test('Christmas speaks from nine days out', () {
      expect(
        liturgicalPromptOn(date(2026, 12, 16)),
        FeastPrompt(
          feast: Feast(FeastId.christmas, date(2026, 12, 25)),
          daysUntil: 9,
        ),
      );
    });

    test('but not from ten', () {
      // Advent began on 29 November, so its own week is long past: silence.
      expect(liturgicalPromptOn(date(2026, 12, 15)), isNull);
    });

    test('and not on the day itself — an invitation needs time to act on', () {
      expect(liturgicalPromptOn(date(2026, 12, 25)), isNull);
    });

    test('a nearing feast outranks the season it falls in', () {
      // 4 December 2026 is day 5 of Advent (which would prompt on its own) and
      // four days before the Immaculate Conception. The feast wins.
      expect(
        liturgicalPromptOn(date(2026, 12, 4)),
        FeastPrompt(
          feast: Feast(FeastId.immaculateConception, date(2026, 12, 8)),
          daysUntil: 4,
        ),
      );
    });

    test('only one prompt is ever live', () {
      // Christmas (9 days) and nothing else: the tracked feasts do not stack.
      final prompt = liturgicalPromptOn(date(2026, 12, 16));
      expect(prompt, isA<FeastPrompt>());
    });

    test('feasts that merely open a season raise no prompt of their own', () {
      // Two days before Ash Wednesday 2026: Lent's own prompt will do the
      // talking, on the day.
      expect(liturgicalPromptOn(date(2026, 2, 16)), isNull);
      // Two days before the First Sunday of Advent.
      expect(liturgicalPromptOn(date(2026, 11, 27)), isNull);
    });
  });

  group('dismissal', () {
    test('a dismissed season stays quiet for the rest of that season', () {
      const lent2026 = SeasonPrompt(season: LiturgicalSeason.lent, year: 2026);
      expect(lent2026.dismissalKey, 'season:lent:2026');

      expect(
        liturgicalPromptOn(
          date(2026, 2, 20),
          dismissed: {lent2026.dismissalKey},
        ),
        isNull,
      );
    });

    test('but says nothing about next year', () {
      const lent2026 = SeasonPrompt(season: LiturgicalSeason.lent, year: 2026);
      // Ash Wednesday 2027 is 10 February.
      expect(
        liturgicalPromptOn(
          date(2027, 2, 10),
          dismissed: {lent2026.dismissalKey},
        ),
        const SeasonPrompt(season: LiturgicalSeason.lent, year: 2027),
      );
    });

    test('a dismissed feast is not replaced by a lesser prompt', () {
      final christmas = FeastPrompt(
        feast: Feast(FeastId.christmas, date(2026, 12, 25)),
        daysUntil: 9,
      );
      expect(christmas.dismissalKey, 'feast:christmas:2026');

      expect(
        liturgicalPromptOn(
          date(2026, 12, 16),
          dismissed: {christmas.dismissalKey},
        ),
        isNull,
      );
    });

    test('dismissing one feast does not silence the next', () {
      // The Immaculate Conception dismissed; Christmas still gets its turn.
      expect(
        liturgicalPromptOn(
          date(2026, 12, 16),
          dismissed: {'feast:immaculateConception:2026'},
        ),
        isA<FeastPrompt>().having(
          (p) => p.feast.id,
          'feast',
          FeastId.christmas,
        ),
      );
    });
  });

  test('the time of day never changes the prompt', () {
    expect(
      liturgicalPromptOn(DateTime(2026, 2, 18, 23, 30)),
      const SeasonPrompt(season: LiturgicalSeason.lent, year: 2026),
    );
  });
}
