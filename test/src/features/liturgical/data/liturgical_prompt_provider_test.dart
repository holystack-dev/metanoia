import 'package:confessionapp/src/core/preferences/preferences_provider.dart';
import 'package:confessionapp/src/core/utils/clock_provider.dart';
import 'package:confessionapp/src/features/liturgical/data/liturgical_prompt_provider.dart';
import 'package:confessionapp/src/features/liturgical/domain/liturgical_calendar.dart';
import 'package:confessionapp/src/features/liturgical/domain/liturgical_prompt.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const dismissedKey = 'liturgical_prompts_dismissed';

  Future<(ProviderContainer, SharedPreferences)> containerOn(
    DateTime today, {
    Map<String, Object> values = const {},
  }) async {
    SharedPreferences.setMockInitialValues(values);
    final prefs = await SharedPreferences.getInstance();

    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        todayProvider.overrideWithValue(today),
      ],
    );
    addTearDown(container.dispose);
    return (container, prefs);
  }

  test('shows the season prompt on the first day of Lent', () async {
    // Ash Wednesday 2026.
    final (container, _) = await containerOn(DateTime(2026, 2, 18));

    expect(
      container.read(liturgicalPromptProvider),
      const SeasonPrompt(season: LiturgicalSeason.lent, year: 2026),
    );
  });

  test('shows nothing on an ordinary day', () async {
    final (container, _) = await containerOn(DateTime(2026, 7, 1));

    expect(container.read(liturgicalPromptProvider), isNull);
  });

  test('a stored dismissal is honoured on the very first read', () async {
    // Read synchronously from the preloaded preferences: the card must not
    // flash before an async load corrects it.
    final (container, _) = await containerOn(
      DateTime(2026, 2, 18),
      values: {
        dismissedKey: ['season:lent:2026'],
      },
    );

    expect(container.read(liturgicalPromptProvider), isNull);
  });

  test('dismissing hides the prompt and persists the choice', () async {
    final (container, prefs) = await containerOn(DateTime(2026, 2, 18));

    final prompt = container.read(liturgicalPromptProvider)!;
    await container
        .read(liturgicalDismissalsProvider.notifier)
        .dismiss(prompt.dismissalKey);

    expect(container.read(liturgicalPromptProvider), isNull);
    expect(prefs.getStringList(dismissedKey), ['season:lent:2026']);
  });

  test('dismissals from seasons long past are pruned, not hoarded', () async {
    final (container, prefs) = await containerOn(
      DateTime(2026, 2, 18),
      values: {
        dismissedKey: [
          'season:lent:2019',
          'feast:christmas:2024',
          'season:advent:2025', // last year: kept, Advent 2025 runs into 2026
        ],
      },
    );

    await container
        .read(liturgicalDismissalsProvider.notifier)
        .dismiss('season:lent:2026');

    expect(
      prefs.getStringList(dismissedKey),
      unorderedEquals([
        'season:advent:2025',
        'season:lent:2026',
      ]),
    );
  });
}
