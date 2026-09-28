import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/widgets/gentle_prompt_card.dart';
import 'package:confessionapp/src/features/confession/data/anniversary_nudge_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// "It has been 9 weeks since your last confession."
///
/// Measured against the user's own cadence, never a schedule the app picked for
/// them, and silent until there is enough history for that cadence to mean
/// anything (see `evaluateAnniversaryNudge`). Dismissing it buys a fortnight of
/// quiet.
class AnniversaryCard extends ConsumerWidget {
  const AnniversaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nudge = ref.watch(anniversaryNudgeProvider);
    if (nudge == null) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context)!;

    // The gap lives with the card, so a silent day collapses to nothing at all
    // rather than leaving a hole in the home column.
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GentlePromptCard(
        icon: Icons.favorite_outline,
        title: l10n.anniversaryTitle(nudge.weeksSinceLastConfession),
        body: l10n.anniversaryBody,
        onPrepare: () => context.go('/examine'),
        onDismiss: () =>
            ref.read(anniversaryDismissalProvider.notifier).dismissToday(),
      ),
    );
  }
}
