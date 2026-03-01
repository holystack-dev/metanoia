import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// A card widget that displays a single examination question
/// Used in the focused/deep reflection examination mode
class QuestionCard extends StatelessWidget {
  final String questionText;
  final String? commandmentLabel;
  final bool isSelected;

  const QuestionCard({
    super.key,
    required this.questionText,
    this.commandmentLabel,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: isSelected
            ? colorScheme.primaryContainer.withValues(alpha: 0.3)
            : colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected
              ? colorScheme.primary
              : colorScheme.outlineVariant.withValues(alpha: 0.5),
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isSelected) ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_rounded,
                size: 20,
                color: colorScheme.onPrimary,
              ),
            ),
            const SizedBox(height: 16),
          ],
          if (commandmentLabel != null && !isSelected) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                commandmentLabel!,
                style: TextStyle(
                  fontFamily: AppTheme.fontFamilyLato,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.primary,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
          Text(
            questionText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppTheme.fontFamilyEBGaramond,
              fontSize: 22,
              fontWeight: FontWeight.w400,
              color: colorScheme.onSurface,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
