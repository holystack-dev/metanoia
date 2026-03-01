import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/features/onboarding/presentation/widgets/mystical_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';

/// Final onboarding screen with disclaimer and ready to begin message
class ReadyToBeginPage extends StatelessWidget {
  final VoidCallback onComplete;

  const ReadyToBeginPage({super.key, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final isDark = theme.brightness == Brightness.dark;

    return MysticalBackground(
      showStars: true,
      starDensity: 0.3,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Spacer(flex: 2),

                    // Icon with glowing effect
                    Center(
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(
                            alpha: isDark ? 0.2 : 0.12,
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.colorScheme.primary.withValues(
                              alpha: 0.3,
                            ),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.primary.withValues(
                                alpha: 0.4,
                              ),
                              blurRadius: 50,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.favorite_rounded,
                          size: 56,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ).animate().fadeIn(
                      duration: 400.ms,
                      curve: Curves.easeOut,
                    ),

                    const SizedBox(height: 48),

                    // Title
                    Text(
                          l10n.readyToBegin,
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamilyEBGaramond,
                            fontSize: 36,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.primary,
                            letterSpacing: 0.3,
                          ),
                          textAlign: TextAlign.center,
                        )
                        .animate(delay: 150.ms)
                        .fadeIn(duration: 350.ms, curve: Curves.easeOut),

                    const SizedBox(height: 16),

                    // Subtitle
                    Text(
                          l10n.readyToBeginSubtitle,
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamilyLato,
                            fontSize: 17,
                            color: theme.colorScheme.onSurfaceVariant
                                .withValues(alpha: 0.9),
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        )
                        .animate(delay: 250.ms)
                        .fadeIn(duration: 350.ms, curve: Curves.easeOut),

                    const SizedBox(height: 48),

                    // Disclaimer card
                    Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 20,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withValues(
                              alpha: isDark ? 0.15 : 0.1,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: theme.colorScheme.primary.withValues(
                                alpha: isDark ? 0.4 : 0.35,
                              ),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.primary.withValues(
                                  alpha: isDark ? 0.2 : 0.15,
                                ),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.info_rounded,
                                size: 32,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(height: 14),
                              Text(
                                l10n.onboardingDisclaimer,
                                style: TextStyle(
                                  fontFamily: AppTheme.fontFamilyLato,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.italic,
                                  color: isDark
                                      ? theme.colorScheme.onSurface
                                      : theme.colorScheme.onSurface
                                          .withValues(alpha: 0.9),
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                        .animate(delay: 350.ms)
                        .fadeIn(duration: 350.ms, curve: Curves.easeOut),

                    const Spacer(flex: 3),

                    // Begin Button with glow
                    Center(
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 280),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              boxShadow: [
                                BoxShadow(
                                  color: theme.colorScheme.primary.withValues(
                                    alpha: 0.4,
                                  ),
                                  blurRadius: 24,
                                  spreadRadius: 0,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: FilledButton(
                              onPressed: () {
                                HapticUtils.mediumImpact();
                                onComplete();
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                foregroundColor: theme.colorScheme.onPrimary,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 18,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                elevation: 0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    l10n.getStarted,
                                    style: const TextStyle(
                                      fontFamily: AppTheme.fontFamilyLato,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.4,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 22,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .animate(delay: 450.ms)
                        .fadeIn(duration: 350.ms, curve: Curves.easeOut),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
