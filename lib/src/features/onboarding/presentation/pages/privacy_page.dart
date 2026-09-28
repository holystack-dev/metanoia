import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/theme/app_radius.dart';
import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:confessionapp/src/features/onboarding/presentation/widgets/mystical_background.dart';
import 'package:confessionapp/src/features/onboarding/presentation/widgets/onboarding_cta_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// "Private by design".
///
/// Explains where data is stored before the user writes any, and warns that a
/// PIN will be requested. The PIN is created lazily on the first sensitive
/// route, so users who only browse never see a keypad.
class PrivacyPage extends StatelessWidget {
  final VoidCallback onNext;

  const PrivacyPage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final isDark = theme.brightness == Brightness.dark;

    return MysticalBackground(
      showStars: true,
      starDensity: 0.4,
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

                    Center(
                      child: Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(
                            alpha: isDark ? 0.2 : 0.12,
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.colorScheme.primary.withValues(
                              alpha: 0.3,
                            ),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.primary.withValues(
                                alpha: 0.35,
                              ),
                              blurRadius: 40,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.lock_outline_rounded,
                          size: 44,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    Text(
                      l10n.onboardingPrivacyTitle,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontFamily: AppTheme.fontFamilyEBGaramond,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.primary,
                        letterSpacing: 0.3,
                        height: 1.15,
                      ),
                    ),

                    const SizedBox(height: 36),

                    _PrivacyLine(
                      icon: Icons.phone_iphone_rounded,
                      text: l10n.onboardingPrivacyLocal,
                    ),
                    const SizedBox(height: 20),
                    _PrivacyLine(
                      icon: Icons.shield_outlined,
                      text: l10n.onboardingPrivacyEncrypted,
                    ),
                    const SizedBox(height: 20),
                    _PrivacyLine(
                      icon: Icons.pin_outlined,
                      text: l10n.onboardingPrivacyPin,
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

class _PrivacyLine extends StatelessWidget {
  final IconData icon;
  final String text;

  const _PrivacyLine({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          // Optically centres the icon on the first line of text.
          padding: const EdgeInsets.only(top: 2),
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppRadius.chip),
            ),
            child: Icon(icon, size: 18, color: theme.colorScheme.secondary),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontFamily: AppTheme.fontFamilyLato,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.9),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
