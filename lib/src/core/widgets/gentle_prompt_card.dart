import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/theme/app_radius.dart';
import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:flutter/material.dart';

/// A quiet invitation on the home screen: an icon, a line, and two ways out.
///
/// Shared by the liturgical-season and anniversary cards. "Not Now" has equal
/// weight to accepting.
///
/// Not animated: both callers rebuild on every provider emission, which would
/// replay an entrance animation.
class GentlePromptCard extends StatelessWidget {
  const GentlePromptCard({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    required this.onPrepare,
    required this.onDismiss,
    this.prepareLabel,
  });

  final IconData icon;
  final String title;
  final String body;
  final VoidCallback onPrepare;
  final VoidCallback onDismiss;

  /// Label of the accepting action. Defaults to the shared "Prepare" wording;
  /// callers whose offer is not a preparation (e.g. the examination's offer of
  /// encouragement) pass their own.
  final String? prepareLabel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: scheme.outlineVariant),
      ),
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
                  color: scheme.secondary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: scheme.secondary, size: 22),
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
                    const SizedBox(height: 6),
                    Text(
                      body,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontFamily: AppTheme.fontFamilyEBGaramond,
                        color: scheme.onSurfaceVariant,
                        height: 1.35,
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
                onPressed: () {
                  HapticUtils.lightImpact();
                  onDismiss();
                },
                child: Text(l10n.notNow),
              ),
              const SizedBox(width: 8),
              FilledButton.tonal(
                onPressed: () {
                  HapticUtils.lightImpact();
                  onPrepare();
                },
                child: Text(prepareLabel ?? l10n.promptPrepare),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
