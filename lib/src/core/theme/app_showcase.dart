import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class AppShowcase extends StatelessWidget {
  const AppShowcase({
    super.key,
    required this.showcaseKey,
    required this.title,
    required this.description,
    required this.child,
    this.shapeBorder,
    this.currentStep,
    this.totalSteps,
  });

  final GlobalKey showcaseKey;
  final String title;
  final String description;
  final Widget child;
  final ShapeBorder? shapeBorder;
  final int? currentStep;
  final int? totalSteps;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Showcase.withWidget(
      key: showcaseKey,
      targetShapeBorder: shapeBorder ?? const CircleBorder(),
      overlayOpacity: isDark ? 0.85 : 0.75,
      overlayColor: isDark ? const Color(0xFF121019) : Colors.black,
      targetPadding: const EdgeInsets.all(8),
      enableAutoScroll: true,
      container: _buildTooltip(context, theme, isDark),
      child: child,
    );
  }

  Widget _buildTooltip(BuildContext context, ThemeData theme, bool isDark) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.85,
      ),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark
            ? theme.colorScheme.surfaceContainerHigh
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        // Layered shadows for depth
        boxShadow: [
          // Primary glow
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: isDark ? 0.25 : 0.15),
            blurRadius: 32,
            offset: const Offset(0, 12),
            spreadRadius: -4,
          ),
          // Tight shadow for depth
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.1),
            blurRadius: 16,
            offset: const Offset(0, 6),
            spreadRadius: -4,
          ),
        ],
        // Subtle border
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: isDark ? 0.15 : 0.1),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon and title
          Row(
            children: [
              // Icon container
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.auto_awesome_rounded,
                  color: theme.colorScheme.onPrimary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamilyEBGaramond,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                        letterSpacing: 0.2,
                        height: 1.2,
                      ),
                    ),
                    if (currentStep != null && totalSteps != null) ...[
                      const SizedBox(height: 6),
                      // Step indicator
                      Text(
                        'Step $currentStep of $totalSteps',
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamilyLato,
                          fontSize: 12,
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Description
          Text(
            description,
            style: TextStyle(
              fontFamily: AppTheme.fontFamilyLato,
              fontSize: 15,
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.6,
              letterSpacing: 0.2,
            ),
          ),

          const SizedBox(height: 20),

          // Footer with progress and navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Progress indicator
              if (currentStep != null && totalSteps != null)
                Flexible(
                  child: _buildProgressIndicator(theme),
                )
              else
                const SizedBox.shrink(),

              const SizedBox(width: 12),

              // Navigation buttons
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Previous button
                  if (currentStep != null && currentStep! > 1)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: _buildSecondaryButton(
                        context: context,
                        theme: theme,
                        isDark: isDark,
                        label: 'Back',
                        icon: Icons.arrow_back_rounded,
                        iconFirst: true,
                        onTap: () {
                          // ignore: deprecated_member_use
                          ShowCaseWidget.of(context).previous();
                        },
                      ),
                    ),

                  // Continue button
                  _buildPrimaryButton(
                    context: context,
                    theme: theme,
                    label: currentStep == totalSteps ? 'Done' : 'Next',
                    icon: currentStep == totalSteps
                        ? Icons.check_rounded
                        : Icons.arrow_forward_rounded,
                    onTap: () {
                      // ignore: deprecated_member_use
                      ShowCaseWidget.of(context).next();
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(ThemeData theme) {
    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: List.generate(
        totalSteps!,
        (index) {
          final isCompleted = index < currentStep!;
          final isCurrent = index == currentStep! - 1;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isCurrent ? 20 : 6,
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: isCompleted
                  ? theme.colorScheme.primary
                  : theme.colorScheme.primary.withValues(alpha: 0.2),
              boxShadow: isCurrent
                  ? [
                      BoxShadow(
                        color: theme.colorScheme.primary.withValues(alpha: 0.4),
                        blurRadius: 6,
                        spreadRadius: 0,
                      ),
                    ]
                  : null,
            ),
          );
        },
      ),
    );
  }

  Widget _buildPrimaryButton({
    required BuildContext context,
    required ThemeData theme,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.primary,
                theme.colorScheme.primary.withValues(alpha: 0.85),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: 0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
                spreadRadius: -2,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: AppTheme.fontFamilyLato,
                  fontSize: 15,
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                icon,
                size: 18,
                color: theme.colorScheme.onPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton({
    required BuildContext context,
    required ThemeData theme,
    required bool isDark,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    bool iconFirst = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withValues(
              alpha: isDark ? 0.8 : 1.0,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (iconFirst) ...[
                Icon(
                  icon,
                  size: 16,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                ),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: TextStyle(
                  fontFamily: AppTheme.fontFamilyLato,
                  fontSize: 14,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
              if (!iconFirst) ...[
                const SizedBox(width: 6),
                Icon(
                  icon,
                  size: 16,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
