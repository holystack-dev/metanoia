import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/features/onboarding/presentation/widgets/mystical_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// A single feature page for onboarding with mystical theme
class FeaturePage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onNext;
  final String buttonText;

  const FeaturePage({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onNext,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MysticalBackground(
      showStars: true,
      starDensity: 0.6,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 32.0,
            vertical: 24.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // Icon container with glowing effect
              Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: isDark ? 0.2 : 0.12),
                      borderRadius: BorderRadius.circular(35),
                      border: Border.all(
                        color: color.withValues(alpha: 0.3),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha: 0.35),
                          blurRadius: 40,
                          spreadRadius: 0,
                          offset: const Offset(0, 8),
                        ),
                        BoxShadow(
                          color: color.withValues(alpha: 0.15),
                          blurRadius: 80,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: Icon(icon, size: 64, color: color),
                  )
                  .animate()
                  .fadeIn(duration: 400.ms, curve: Curves.easeOut)
                  .slideY(
                    begin: 0.2,
                    end: 0,
                    duration: 400.ms,
                    curve: Curves.easeOut,
                  )
                  .scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1, 1),
                    duration: 400.ms,
                    curve: Curves.easeOutBack,
                  ),

              const SizedBox(height: 48),

              // Title with elegant typography
              Text(
                    title,
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamilyEBGaramond,
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.primary,
                      letterSpacing: 0.3,
                    ),
                    textAlign: TextAlign.center,
                  )
                  .animate(delay: 150.ms)
                  .fadeIn(duration: 350.ms, curve: Curves.easeOut)
                  .slideY(
                    begin: 0.1,
                    end: 0,
                    duration: 350.ms,
                    curve: Curves.easeOut,
                  ),

              const SizedBox(height: 20),

              // Description
              Container(
                    constraints: const BoxConstraints(maxWidth: 340),
                    child: Text(
                      description,
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamilyLato,
                        fontSize: 17,
                        color: theme.colorScheme.onSurfaceVariant.withValues(
                          alpha: 0.9,
                        ),
                        height: 1.6,
                        letterSpacing: 0.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                  .animate(delay: 250.ms)
                  .fadeIn(duration: 350.ms, curve: Curves.easeOut)
                  .slideY(
                    begin: 0.1,
                    end: 0,
                    duration: 350.ms,
                    curve: Curves.easeOut,
                  ),

              const Spacer(flex: 3),

              // Next Button with purple glow
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
                          const Icon(Icons.arrow_forward_rounded, size: 20),
                        ],
                      ),
                    ),
                  )
                  .animate(delay: 350.ms)
                  .fadeIn(duration: 350.ms, curve: Curves.easeOut)
                  .slideY(
                    begin: 0.1,
                    end: 0,
                    duration: 350.ms,
                    curve: Curves.easeOut,
                  ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
