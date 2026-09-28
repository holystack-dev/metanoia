import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/theme/app_radius.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:flutter/material.dart';

/// How the examination is presented.
enum ExaminationMode {
  quickReview,
  deepReflection,
}

/// Inline examination mode toggle. The mode is a preference, not a gate: it
/// can be changed at any time or ignored.
class ExaminationModeToggle extends StatelessWidget {
  const ExaminationModeToggle({
    super.key,
    required this.mode,
    required this.onChanged,
  });

  final ExaminationMode mode;
  final ValueChanged<ExaminationMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(AppRadius.tile),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        children: [
          Expanded(
            child: _ModeSegment(
              icon: Icons.list_alt_rounded,
              label: l10n.quickReviewMode,
              isSelected: mode == ExaminationMode.quickReview,
              onTap: () => onChanged(ExaminationMode.quickReview),
            ),
          ),
          Expanded(
            child: _ModeSegment(
              icon: Icons.center_focus_strong_rounded,
              label: l10n.deepReflectionMode,
              isSelected: mode == ExaminationMode.deepReflection,
              onTap: () => onChanged(ExaminationMode.deepReflection),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModeSegment extends StatelessWidget {
  const _ModeSegment({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final foreground =
        isSelected ? scheme.onPrimaryContainer : scheme.onSurfaceVariant;

    return Semantics(
      selected: isSelected,
      button: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (isSelected) return;
            HapticUtils.selectionClick();
            onTap();
          },
          borderRadius: BorderRadius.circular(AppRadius.chip),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? scheme.primaryContainer
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(AppRadius.chip),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 18, color: foreground),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: foreground,
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
