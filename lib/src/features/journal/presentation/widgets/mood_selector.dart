import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/theme/app_radius.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/features/journal/domain/models/journal_models.dart';
import 'package:flutter/material.dart';

/// The colour a mood is drawn in, always from the active scheme so both themes
/// stay legible.
Color moodColor(ColorScheme scheme, Mood mood) {
  return switch (mood) {
    Mood.desolate => scheme.error,
    Mood.struggling => scheme.tertiary,
    Mood.steady => scheme.outline,
    Mood.grateful => scheme.secondary,
    Mood.consoled => scheme.primary,
  };
}

IconData moodIcon(Mood mood) {
  return switch (mood) {
    Mood.desolate => Icons.sentiment_very_dissatisfied_outlined,
    Mood.struggling => Icons.sentiment_dissatisfied_outlined,
    Mood.steady => Icons.sentiment_neutral_outlined,
    Mood.grateful => Icons.sentiment_satisfied_outlined,
    Mood.consoled => Icons.sentiment_very_satisfied_outlined,
  };
}

String moodLabel(AppLocalizations l10n, Mood mood) {
  return switch (mood) {
    Mood.desolate => l10n.journalMoodDesolate,
    Mood.struggling => l10n.journalMoodStruggling,
    Mood.steady => l10n.journalMoodSteady,
    Mood.grateful => l10n.journalMoodGrateful,
    Mood.consoled => l10n.journalMoodConsoled,
  };
}

/// The five spiritual states, as a row of tappable faces.
///
/// Tapping the selected mood again clears it — the mood is optional.
class MoodSelector extends StatelessWidget {
  const MoodSelector({super.key, required this.value, required this.onChanged});

  final Mood? value;
  final ValueChanged<Mood?> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    // A Wrap of content-sized options, not a Row of equal Expanded cells: long
    // single words (Italian "Consolazione", Filipino "Nakikipagpunyagi") would
    // otherwise be broken mid-word.
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 4,
      runSpacing: 4,
      children: [
        for (final mood in Mood.values)
          _MoodOption(
            mood: mood,
            label: moodLabel(l10n, mood),
            color: moodColor(scheme, mood),
            isSelected: value == mood,
            onTap: () {
              HapticUtils.selectionClick();
              onChanged(value == mood ? null : mood);
            },
          ),
      ],
    );
  }
}

class _MoodOption extends StatelessWidget {
  const _MoodOption({
    required this.mood,
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  final Mood mood;
  final String label;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
          child: ConstrainedBox(
            // minWidth keeps a common rhythm yet fits all five on one row of a
            // narrow phone (the moods read as a scale). maxWidth fits the
            // longest single word across the 14 languages.
            constraints: const BoxConstraints(minWidth: 56, maxWidth: 140),
            child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ? color.withValues(alpha: 0.18)
                      : scheme.surfaceContainerHighest.withValues(alpha: 0.5),
                  border: Border.all(
                    color: isSelected ? color : scheme.outlineVariant,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Icon(
                  moodIcon(mood),
                  size: 26,
                  color: isSelected ? color : scheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: isSelected ? color : scheme.onSurfaceVariant,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
