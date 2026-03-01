import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/features/confession/data/confession_repository.dart';
import 'package:confessionapp/src/features/settings/presentation/settings_screen.dart'
    show ReminderFrequency, reminderSettingsProvider;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// A unified card showing key stats: Last Confession and Next Reminder
class StatsCard extends ConsumerWidget {
  const StatsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final lastConfessionAsync = ref.watch(lastFinishedConfessionProvider);
    final reminderSettings = ref.watch(reminderSettingsProvider);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Last Confession
          Expanded(
            child: _StatItem(
              icon: Icons.history_rounded,
              iconColor: theme.colorScheme.primary,
              label: l10n.lastConfession,
              value: lastConfessionAsync.when(
                data: (confession) {
                  if (confession == null) return l10n.noneYet;
                  final daysAgo = DateTime.now().difference(confession.date).inDays;
                  if (daysAgo == 0) return l10n.today;
                  if (daysAgo == 1) return l10n.yesterday;
                  return l10n.daysAgo(daysAgo);
                },
                loading: () => '...',
                error: (_, __) => l10n.error,
              ),
              valueColor: lastConfessionAsync.whenOrNull(
                data: (c) => c == null ? theme.colorScheme.outline : null,
              ),
              onTap: () {
                HapticUtils.lightImpact();
                context.push('/confess/history');
              },
            ),
          ),
          // Vertical divider
          Container(
            width: 1,
            height: 60,
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
          // Next Reminder
          Expanded(
            child: _StatItem(
              icon: Icons.notifications_outlined,
              iconColor: theme.colorScheme.secondary,
              label: l10n.nextReminder,
              value: reminderSettings.when(
                data: (config) {
                  if (config.frequency == ReminderFrequency.none) {
                    return l10n.off;
                  }
                  String text = '';
                  switch (config.frequency) {
                    case ReminderFrequency.weekly:
                      text = l10n.weekly;
                      break;
                    case ReminderFrequency.biweekly:
                      text = l10n.biweekly;
                      break;
                    case ReminderFrequency.monthly:
                      text = l10n.monthly;
                      break;
                    case ReminderFrequency.quarterly:
                      text = l10n.quarterly;
                      break;
                    case ReminderFrequency.none:
                      text = l10n.off;
                      break;
                  }
                  return text;
                },
                loading: () => '...',
                error: (_, __) => l10n.error,
              ),
              valueColor: reminderSettings.whenOrNull(
                data: (c) => c.frequency == ReminderFrequency.none
                    ? theme.colorScheme.outline
                    : null,
              ),
              onTap: () {
                HapticUtils.lightImpact();
                context.push(
                  Uri(
                    path: '/settings',
                    queryParameters: {'scrollTo': 'reminders'},
                  ).toString(),
                );
              },
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 250.ms).slideY(begin: 0.1, end: 0);
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    this.valueColor,
    required this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final Color? valueColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(19),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 22,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  letterSpacing: 0.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: valueColor ?? theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
