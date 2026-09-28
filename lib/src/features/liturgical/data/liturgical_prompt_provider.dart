import 'package:confessionapp/src/core/preferences/preferences_provider.dart';
import 'package:confessionapp/src/core/utils/clock_provider.dart';
import 'package:confessionapp/src/features/liturgical/domain/liturgical_prompt.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'liturgical_prompt_provider.g.dart';

/// The liturgical prompts the user has waved away.
///
/// Persisted as year-scoped keys ("season:lent:2026"), so a dismissal is
/// permanent for that season or feast and silent about the next one.
@riverpod
class LiturgicalDismissals extends _$LiturgicalDismissals {
  static const _key = 'liturgical_prompts_dismissed';

  /// Read synchronously from the preferences preloaded in `main`, so the home
  /// screen never flashes a card the user already dismissed.
  @override
  Set<String> build() {
    final stored = ref.watch(sharedPreferencesProvider).getStringList(_key);
    return stored == null ? const {} : Set.unmodifiable(stored);
  }

  Future<void> dismiss(String dismissalKey) async {
    if (state.contains(dismissalKey)) return;

    final year = ref.read(todayProvider).year;
    final kept = {...state, dismissalKey}.where(_isStillRelevant(year)).toList();

    state = Set.unmodifiable(kept);
    await ref.read(sharedPreferencesProvider).setStringList(_key, kept);
  }

  /// Drops keys from seasons and feasts that are safely in the past, so the
  /// stored list cannot grow without bound over the life of an install.
  bool Function(String) _isStillRelevant(int currentYear) {
    return (key) {
      final year = int.tryParse(key.split(':').last);
      // An unparseable key is not ours; leave it alone rather than lose data.
      return year == null || year >= currentYear - 1;
    };
  }
}

/// The one liturgical invitation to show today, or `null` for silence.
@riverpod
LiturgicalPrompt? liturgicalPrompt(Ref ref) {
  return liturgicalPromptOn(
    ref.watch(todayProvider),
    dismissed: ref.watch(liturgicalDismissalsProvider),
  );
}
