import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/services/in_app_review_service.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:flutter/material.dart';

/// Shows the in-app rating gate and routes the outcome.
///
/// Asks in-app first with a star selector. Only 4–5 stars are sent on to the
/// store; 1–3 stars are thanked privately and go no further.
///
/// Returns the number of stars the user chose, or `null` if they dismissed the
/// gate without choosing. The caller decides what to record (opt out, snooze,
/// mark handled).
Future<int?> showRatingGate(BuildContext context) async {
  final stars = await showDialog<int>(
    context: context,
    builder: (_) => const _RatingGateDialog(),
  );

  if (stars == null) return null;

  if (stars >= 4) {
    // Happy: send them to the listing to post it.
    await InAppReviewService().openStoreListing();
  } else if (context.mounted) {
    // Unhappy: thank them and stop; never route to the store.
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(l10n.rateGateThanks)));
  }

  return stars;
}

/// The star selector. Two-step (select, then confirm) so a stray tap cannot
/// route to the wrong place.
class _RatingGateDialog extends StatefulWidget {
  const _RatingGateDialog();

  @override
  State<_RatingGateDialog> createState() => _RatingGateDialogState();
}

class _RatingGateDialogState extends State<_RatingGateDialog> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return AlertDialog(
      icon: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: scheme.primaryContainer,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.favorite, color: scheme.primary, size: 32),
      ),
      title: Text(l10n.rateDialogTitle, textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l10n.rateGateHint,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (i) {
              final value = i + 1;
              final filled = value <= _selected;
              return IconButton(
                onPressed: () {
                  HapticUtils.selectionClick();
                  setState(() => _selected = value);
                },
                iconSize: 36,
                // The gold accent is the app's rating colour.
                color: filled ? scheme.secondary : scheme.onSurfaceVariant,
                icon: Icon(filled ? Icons.star_rounded : Icons.star_border_rounded),
                tooltip: '$value',
              );
            }),
          ),
          const SizedBox(height: 4),
          // Low/high labels under the outer stars.
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '1 · ${l10n.rateGateLowest}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  '5 · ${l10n.rateGateHighest}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilledButton(
              onPressed: _selected == 0
                  ? null
                  : () {
                      HapticUtils.lightImpact();
                      Navigator.pop(context, _selected);
                    },
              child: Text(l10n.continueButton),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                l10n.notNow,
                style: TextStyle(color: scheme.onSurfaceVariant),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
