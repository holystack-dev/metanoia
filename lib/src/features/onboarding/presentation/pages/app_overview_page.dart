import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/theme/app_radius.dart';
import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:confessionapp/src/features/onboarding/presentation/widgets/mystical_background.dart';
import 'package:confessionapp/src/features/onboarding/presentation/widgets/onboarding_cta_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// "What this app does".
///
/// The three lines follow the order of the sacrament: examine, confess, and
/// keep growing afterwards.
class AppOverviewPage extends StatelessWidget {
  final VoidCallback onNext;

  const AppOverviewPage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return MysticalBackground(
      showStars: true,
      starDensity: 0.5,
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Spacer(flex: 2),

                    Text(
                      l10n.onboardingOverviewTitle,
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontFamily: AppTheme.fontFamilyEBGaramond,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.primary,
                        letterSpacing: 0.3,
                        height: 1.15,
                      ),
                    ),

                    const SizedBox(height: 40),

                    _OverviewLine(
                      icon: Icons.assignment_outlined,
                      label: l10n.examineTitle,
                      description: l10n.onboardingOverviewExamine,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(height: 28),
                    _OverviewLine(
                      icon: Icons.church_outlined,
                      label: l10n.confessTitle,
                      description: l10n.onboardingOverviewConfess,
                      color: theme.colorScheme.secondary,
                    ),
                    const SizedBox(height: 28),
                    _OverviewLine(
                      icon: Icons.nightlight_outlined,
                      label: l10n.journalTitle,
                      description: l10n.onboardingOverviewJournal,
                      color: theme.colorScheme.tertiary,
                    ),

                    const SizedBox(height: 32),

                    Text(
                      l10n.onboardingOverviewFootnote,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontFamily: AppTheme.fontFamilyLato,
                        fontStyle: FontStyle.italic,
                        color: theme.colorScheme.onSurfaceVariant.withValues(
                          alpha: 0.7,
                        ),
                        height: 1.5,
                      ),
                    ),

                    const Spacer(flex: 3),

                    OnboardingCtaButton(
                      label: l10n.continueButton,
                      onPressed: onNext,
                    ).animate().fadeIn(duration: 150.ms, curve: Curves.easeOut),

                    const SizedBox(height: 32),
                  ],
                ).animate().fadeIn(duration: 300.ms, curve: Curves.easeOut),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// One quiet line: a tab, and what it is for.
class _OverviewLine extends StatelessWidget {
  final IconData icon;
  final String label;
  final String description;
  final Color color;

  const _OverviewLine({
    required this.icon,
    required this.label,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: isDark ? 0.2 : 0.12),
            borderRadius: BorderRadius.circular(AppRadius.tile),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Icon(icon, size: 22, color: color),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontFamily: AppTheme.fontFamilyEBGaramond,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontFamily: AppTheme.fontFamilyLato,
                  color: theme.colorScheme.onSurfaceVariant.withValues(
                    alpha: 0.9,
                  ),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
