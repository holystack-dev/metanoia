import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/theme/app_radius.dart';
import 'package:confessionapp/src/features/journal/data/journal_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The number of consecutive days of reflection, e.g. "7 days".
///
/// Styled without streak-fire iconography so it does not read as a score to
/// protect. Renders nothing when the count is zero.
class StreakBadge extends ConsumerWidget {
  const StreakBadge({super.key, this.compact = false});

  /// Icon-and-number only, for tight spaces like the home card header.
  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streak = ref.watch(journalStreakProvider).valueOrNull ?? 0;
    if (streak == 0) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Semantics(
      // Announce the count, not just "days of reflection in a row": the number
      // is the whole point of the badge, and a screen reader should hear it.
      label: '${l10n.journalStreakDays(streak)}, ${l10n.journalStreakLabel}',
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 8 : 12,
          vertical: compact ? 4 : 6,
        ),
        decoration: BoxDecoration(
          color: scheme.secondaryContainer,
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              // A warm heart, not a streak-fire: faithfulness, not a score.
              Icons.favorite,
              size: compact ? 14 : 16,
              color: scheme.onSecondaryContainer,
            ),
            const SizedBox(width: 4),
            Text(
              l10n.journalStreakDays(streak),
              style: (compact
                      ? theme.textTheme.labelSmall
                      : theme.textTheme.labelMedium)
                  ?.copyWith(
                    color: scheme.onSecondaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
