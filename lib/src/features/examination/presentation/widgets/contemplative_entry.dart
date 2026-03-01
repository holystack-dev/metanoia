import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// A contemplative entry screen shown before Deep Reflection mode
/// Features a Holy Spirit prayer with breathing animation
class ContemplativeEntry extends StatefulWidget {
  final VoidCallback onReady;
  final VoidCallback onSkip;

  const ContemplativeEntry({
    super.key,
    required this.onReady,
    required this.onSkip,
  });

  @override
  State<ContemplativeEntry> createState() => _ContemplativeEntryState();
}

class _ContemplativeEntryState extends State<ContemplativeEntry>
    with SingleTickerProviderStateMixin {
  late AnimationController _breathingController;

  @override
  void initState() {
    super.initState();
    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _breathingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 2),

              AnimatedBuilder(
                animation: _breathingController,
                builder: (context, child) {
                  final scale = 1.0 + (_breathingController.value * 0.08);
                  final opacity = 0.6 + (_breathingController.value * 0.4);

                  return Transform.scale(
                    scale: scale,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorScheme.primaryContainer.withValues(alpha: 0.3),
                        boxShadow: [
                          BoxShadow(
                            color: colorScheme.primary.withValues(alpha: opacity * 0.3),
                            blurRadius: 40,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.local_fire_department_rounded,
                        size: 56,
                        color: colorScheme.primary.withValues(alpha: opacity),
                      ),
                    ),
                  );
                },
              ).animate().fadeIn(duration: 800.ms).scale(
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1.0, 1.0),
                    duration: 800.ms,
                    curve: Curves.easeOutBack,
                  ),

              const SizedBox(height: 48),

              Text(
                l10n.contemplativePrayerTitle,
                style: TextStyle(
                  fontFamily: AppTheme.fontFamilyEBGaramond,
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(delay: 300.ms, duration: 600.ms)
                  .slideY(begin: 0.1, end: 0, duration: 600.ms),

              const SizedBox(height: 24),

              Text(
                l10n.contemplativePrayerText,
                style: TextStyle(
                  fontFamily: AppTheme.fontFamilyEBGaramond,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: colorScheme.onSurfaceVariant,
                  height: 1.6,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(delay: 600.ms, duration: 600.ms)
                  .slideY(begin: 0.1, end: 0, duration: 600.ms),

              const Spacer(flex: 2),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return AnimatedBuilder(
                    animation: _breathingController,
                    builder: (context, child) {
                      // Stagger the animation for each dot
                      final delay = index * 0.15;
                      final adjustedValue =
                          ((_breathingController.value + delay) % 1.0);
                      final opacity = 0.3 + (adjustedValue * 0.7);

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorScheme.primary.withValues(alpha: opacity),
                        ),
                      );
                    },
                  );
                }),
              ).animate().fadeIn(delay: 900.ms, duration: 400.ms),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    HapticUtils.mediumImpact();
                    widget.onReady();
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    l10n.imReady,
                    style: const TextStyle(
                      fontFamily: AppTheme.fontFamilyLato,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
                  .animate()
                  .fadeIn(delay: 1200.ms, duration: 400.ms)
                  .slideY(begin: 0.2, end: 0, duration: 400.ms),

              const SizedBox(height: 12),

              TextButton(
                onPressed: () {
                  HapticUtils.lightImpact();
                  widget.onSkip();
                },
                child: Text(
                  l10n.skipPrayer,
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamilyLato,
                    fontSize: 14,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ).animate().fadeIn(delay: 1400.ms, duration: 400.ms),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
