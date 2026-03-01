import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Enum representing the examination mode
enum ExaminationMode {
  quickReview,
  deepReflection,
}

/// A bottom sheet widget that allows users to select their examination mode
class ExaminationModeSelector extends StatelessWidget {
  final Function(ExaminationMode) onModeSelected;

  const ExaminationModeSelector({
    super.key,
    required this.onModeSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            Text(
              l10n.examinationModeTitle,
              style: TextStyle(
                fontFamily: AppTheme.fontFamilyLato,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
              ),
            ).animate().fadeIn(duration: 300.ms),

            const SizedBox(height: 20),

            _ModeCard(
              icon: Icons.list_alt_rounded,
              title: l10n.quickReviewMode,
              description: l10n.quickReviewDescription,
              onTap: () {
                HapticUtils.mediumImpact();
                Navigator.of(context).pop();
                onModeSelected(ExaminationMode.quickReview);
              },
              colorScheme: colorScheme,
            ).animate().fadeIn(delay: 100.ms, duration: 300.ms).slideX(
                  begin: -0.05,
                  end: 0,
                  duration: 300.ms,
                  curve: Curves.easeOut,
                ),

            const SizedBox(height: 12),

            _ModeCard(
              icon: Icons.center_focus_strong_rounded,
              title: l10n.deepReflectionMode,
              description: l10n.deepReflectionDescription,
              isHighlighted: true,
              onTap: () {
                HapticUtils.mediumImpact();
                Navigator.of(context).pop();
                onModeSelected(ExaminationMode.deepReflection);
              },
              colorScheme: colorScheme,
            ).animate().fadeIn(delay: 200.ms, duration: 300.ms).slideX(
                  begin: -0.05,
                  end: 0,
                  duration: 300.ms,
                  curve: Curves.easeOut,
                ),
          ],
        ),
      ),
    );
  }

  /// Shows the mode selector as a bottom sheet
  static Future<void> show(
    BuildContext context, {
    required Function(ExaminationMode) onModeSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => ExaminationModeSelector(
        onModeSelected: onModeSelected,
      ),
    );
  }
}

class _ModeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;
  final ColorScheme colorScheme;
  final bool isHighlighted;

  const _ModeCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
    required this.colorScheme,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isHighlighted
          ? colorScheme.primaryContainer.withValues(alpha: 0.5)
          : colorScheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isHighlighted
                  ? colorScheme.primary.withValues(alpha: 0.3)
                  : colorScheme.outlineVariant.withValues(alpha: 0.5),
              width: isHighlighted ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isHighlighted
                      ? colorScheme.primary.withValues(alpha: 0.15)
                      : colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 24,
                  color: isHighlighted
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamilyLato,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamilyLato,
                        fontSize: 13,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right_rounded,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
