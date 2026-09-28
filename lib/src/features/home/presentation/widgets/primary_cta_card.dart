import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/theme/app_radius.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/features/home/domain/home_cta.dart';
import 'package:confessionapp/src/features/home/presentation/providers/home_cta_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// The home screen's answer to "what should I do now?".
///
/// Not wrapped in `.animate()`: it rebuilds whenever the draft or penance
/// stream emits, which would replay the entrance animation as a flicker.
class PrimaryCtaCard extends ConsumerWidget {
  const PrimaryCtaCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final cta = ref.watch(homeCtaProvider);

    final (IconData icon, String title, String subtitle) = switch (cta.kind) {
      HomeCtaKind.completePenance => (
        Icons.task_alt_rounded,
        l10n.homeCtaPenanceTitle,
        l10n.homeCtaPenanceSubtitle(cta.count),
      ),
      HomeCtaKind.readyToConfess => (
        Icons.church_outlined,
        l10n.homeCtaReadyTitle,
        l10n.homeCtaReadySubtitle(cta.count),
      ),
      HomeCtaKind.continueExamination => (
        Icons.edit_note_rounded,
        l10n.homeCtaContinueTitle(cta.count),
        l10n.homeCtaContinueSubtitle,
      ),
      HomeCtaKind.beginExamination => (
        Icons.assignment_outlined,
        l10n.homeCtaBeginTitle,
        l10n.homeCtaBeginSubtitle,
      ),
    };

    void onTap() {
      HapticUtils.lightImpact();
      switch (cta.kind) {
        // Pushed on the root navigator, like every other `/confess` child.
        case HomeCtaKind.completePenance:
          context.push('/confess/penance');
        case HomeCtaKind.readyToConfess:
          context.go('/confess');
        case HomeCtaKind.continueExamination:
        case HomeCtaKind.beginExamination:
          context.go('/examine');
      }
    }

    return Material(
      color: scheme.primaryContainer,
      borderRadius: BorderRadius.circular(AppRadius.sheet),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: scheme.onPrimaryContainer.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 28, color: scheme.onPrimaryContainer),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: scheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: scheme.onPrimaryContainer.withValues(
                          alpha: 0.85,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_rounded,
                color: scheme.onPrimaryContainer,
                semanticLabel: l10n.navigate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
