import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/features/onboarding/presentation/widgets/mystical_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// A spiritual-themed onboarding page featuring the app logo
/// and a welcoming message for the user.
class SpiritualJourneyPage extends StatelessWidget {
  final VoidCallback onNext;
  final String headline;
  final String subtitle;
  final String buttonText;

  const SpiritualJourneyPage({
    super.key,
    required this.onNext,
    required this.headline,
    required this.subtitle,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),

                    // App Logo with glow effect
                    Container(
                          width: 220,
                          height: 220,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withValues(
                              alpha:
                                  theme.brightness == Brightness.dark
                                      ? 0.08
                                      : 0.12,
                            ),
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: theme.colorScheme.primary.withValues(
                                alpha:
                                    theme.brightness == Brightness.dark
                                        ? 0.15
                                        : 0.3,
                              ),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.primary.withValues(
                                  alpha:
                                      theme.brightness == Brightness.dark
                                          ? 0.1
                                          : 0.3,
                                ),
                                blurRadius: 40,
                                spreadRadius: 5,
                              ),
                              BoxShadow(
                                color: theme.colorScheme.secondary.withValues(
                                  alpha:
                                      theme.brightness == Brightness.dark
                                          ? 0.05
                                          : 0.2,
                                ),
                                blurRadius: 60,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: Image.asset(
                            'assets/images/applogo.png',
                            fit: BoxFit.contain,
                            color: theme.brightness == Brightness.dark
                                ? Colors.white.withValues(alpha: 0.95)
                                : null,
                            colorBlendMode: theme.brightness == Brightness.dark
                                ? BlendMode.srcIn
                                : null,
                          ),
                        )
                        .animate()
                        .fadeIn(duration: 500.ms, curve: Curves.easeOut)
                        .scale(
                          begin: const Offset(0.8, 0.8),
                          end: const Offset(1, 1),
                          duration: 500.ms,
                          curve: Curves.easeOutBack,
                        ),

                    const SizedBox(height: 60),

                    // Headline
                    Text(
                          headline,
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamilyEBGaramond,
                            fontSize: 38,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.primary,
                            letterSpacing: 0.5,
                            height: 1.15,
                          ),
                          textAlign: TextAlign.center,
                        )
                        .animate(delay: 200.ms)
                        .fadeIn(duration: 400.ms, curve: Curves.easeOut)
                        .slideY(
                          begin: 0.1,
                          end: 0,
                          duration: 400.ms,
                          curve: Curves.easeOut,
                        ),

                    const SizedBox(height: 16),

                    // Subtitle
                    Text(
                          subtitle,
                          style: TextStyle(
                            fontFamily: AppTheme.fontFamilyLato,
                            fontSize: 17,
                            color: theme.colorScheme.onSurfaceVariant
                                .withValues(alpha: 0.85),
                            height: 1.5,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        )
                        .animate(delay: 350.ms)
                        .fadeIn(duration: 400.ms, curve: Curves.easeOut),

                    const Spacer(flex: 3),

                    // Button with glow effect
                    Container(
                          width: double.infinity,
                          constraints: const BoxConstraints(maxWidth: 280),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.primary.withValues(
                                  alpha: 0.35,
                                ),
                                blurRadius: 20,
                                spreadRadius: 0,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: FilledButton(
                            onPressed: () {
                              HapticUtils.mediumImpact();
                              onNext();
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
                                  buttonText,
                                  style: const TextStyle(
                                    fontFamily: AppTheme.fontFamilyLato,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.4,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        )
                        .animate(delay: 500.ms)
                        .fadeIn(duration: 400.ms, curve: Curves.easeOut)
                        .slideY(
                          begin: 0.1,
                          end: 0,
                          duration: 400.ms,
                          curve: Curves.easeOut,
                        ),

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
