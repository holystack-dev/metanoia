import 'package:confessionapp/src/core/constants/app_constants.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/services/spread_the_word_service.dart';
import 'package:confessionapp/src/core/theme/app_radius.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/core/widgets/rating_gate.dart';
import 'package:confessionapp/src/features/home/domain/spread_the_word.dart';
import 'package:confessionapp/src/features/home/presentation/providers/spread_the_word_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

/// The share/rate invitation at the bottom of the home screen. Renders nothing
/// until earned or while snoozed; see [resolveSpreadTheWord].
///
/// Not wrapped in `.animate()`: it rebuilds when the provider re-emits after
/// an action, which would replay the entrance animation as a flicker.
class SpreadTheWordCard extends ConsumerWidget {
  const SpreadTheWordCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kind =
        ref.watch(spreadTheWordProvider).valueOrNull ?? SpreadTheWordKind.none;
    if (kind == SpreadTheWordKind.none) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final isShare = kind == SpreadTheWordKind.share;
    final icon = isShare ? Icons.volunteer_activism_outlined : Icons.star_outline;
    final title = isShare ? l10n.spreadShareTitle : l10n.rateDialogTitle;
    final subtitle =
        isShare ? l10n.spreadShareSubtitle : l10n.spreadRateSubtitle;
    final actionLabel =
        isShare ? l10n.spreadShareAction : l10n.spreadRateAction;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: scheme.primary.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: scheme.primary, size: 22),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: scheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => _dismiss(ref),
                  child: Text(
                    l10n.notNow,
                    style: TextStyle(color: scheme.onSurfaceVariant),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () =>
                      isShare ? _share(ref) : _rate(context, ref),
                  child: Text(actionLabel),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _share(WidgetRef ref) async {
    HapticUtils.lightImpact();
    await Share.share(AppUrls.shareMessage);
    // Snooze after a share before offering again.
    await SpreadTheWordService().snooze();
    ref.invalidate(spreadTheWordProvider);
  }

  Future<void> _rate(BuildContext context, WidgetRef ref) async {
    HapticUtils.lightImpact();
    final stars = await showRatingGate(context);
    final service = SpreadTheWordService();
    if (stars == null) {
      // Gate dismissed: ask again after the snooze.
      await service.snooze();
    } else {
      // Rated: the "rate" ask retires; "share" remains.
      await service.markRatingHandled();
    }
    ref.invalidate(spreadTheWordProvider);
  }

  Future<void> _dismiss(WidgetRef ref) async {
    HapticUtils.lightImpact();
    await SpreadTheWordService().snooze();
    ref.invalidate(spreadTheWordProvider);
  }
}
