import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/widgets/empty_state.dart';
import 'package:confessionapp/src/features/confession/data/confession_analytics_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final analyticsAsync = ref.watch(confessionAnalyticsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.confessionInsights,
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: analyticsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('${l10n.error}: $error')),
        data: (analytics) {
          if (!analytics.hasData) {
            return _buildEmptyState(context, l10n);
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stats Grid
                _buildStatsGrid(context, l10n, analytics),
                const SizedBox(height: 24),

                // Monthly Activity Chart
                _buildMonthlyChart(context, l10n, analytics),
                const SizedBox(height: 24),

                // Journey Info
                _buildJourneyCard(context, l10n, analytics),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations l10n) {
    return EmptyState(
      icon: Icons.insights,
      title: l10n.noInsightsYet,
      subtitle: l10n.noInsightsYetDesc,
    ).animate().fadeIn().scale();
  }

  Widget _buildStatsGrid(
    BuildContext context,
    AppLocalizations l10n,
    ConfessionAnalytics analytics,
  ) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.3,
      children: [
        _StatCard(
          icon: Icons.church,
          label: l10n.totalConfessions,
          value: analytics.totalConfessions.toString(),
          color: Theme.of(context).colorScheme.primary,
        ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1),
        _StatCard(
          icon: Icons.calendar_today,
          label: l10n.daysSinceLastConfession,
          value: analytics.daysSinceLastConfession.toString(),
          color: Theme.of(context).colorScheme.secondary,
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),
        _StatCard(
          icon: Icons.repeat,
          label: l10n.averageFrequency,
          value: analytics.averageDaysBetween != null
              ? '${analytics.averageDaysBetween!.round()} days'
              : '-',
          color: Theme.of(context).colorScheme.tertiary,
        ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
        _StatCard(
          icon: Icons.local_fire_department,
          label: l10n.currentStreak,
          value: '${analytics.currentStreakWeeks} ${analytics.currentStreakWeeks == 1 ? 'wk' : 'wks'}',
          color: Colors.orange,
        ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
      ],
    );
  }

  Widget _buildMonthlyChart(
    BuildContext context,
    AppLocalizations l10n,
    ConfessionAnalytics analytics,
  ) {
    final theme = Theme.of(context);

    if (analytics.monthlyFrequency.isEmpty) {
      return const SizedBox.shrink();
    }

    final maxCount = analytics.monthlyFrequency
        .map((e) => e.count)
        .reduce((a, b) => a > b ? a : b);
    final chartMax = maxCount > 0 ? maxCount : 1;

    return Card(
      elevation: 0,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.bar_chart,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.monthlyActivity,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 140,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: analytics.monthlyFrequency.asMap().entries.map((entry) {
                  final index = entry.key;
                  final data = entry.value;
                  final barHeight = chartMax > 0
                      ? (data.count / chartMax) * 80
                      : 0.0;

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (data.count > 0)
                            Text(
                              data.count.toString(),
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          const SizedBox(height: 4),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300 + (index * 50)),
                            curve: Curves.easeOutCubic,
                            height: barHeight.toDouble(),
                            decoration: BoxDecoration(
                              color: data.count > 0
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.outlineVariant,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            data.monthLabel,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1);
  }

  Widget _buildJourneyCard(
    BuildContext context,
    AppLocalizations l10n,
    ConfessionAnalytics analytics,
  ) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Card(
      elevation: 0,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.timeline,
                  color: theme.colorScheme.secondary,
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.spiritualJourney,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _JourneyRow(
              icon: Icons.flag,
              label: l10n.firstConfession,
              value: analytics.firstConfessionDate != null
                  ? dateFormat.format(analytics.firstConfessionDate!)
                  : '-',
            ),
            const SizedBox(height: 12),
            _JourneyRow(
              icon: Icons.checklist,
              label: l10n.totalItemsConfessed,
              value: analytics.totalItemsConfessed.toString(),
            ),
            const SizedBox(height: 12),
            _JourneyRow(
              icon: Icons.update,
              label: l10n.lastConfession,
              value: analytics.lastConfessionDate != null
                  ? dateFormat.format(analytics.lastConfessionDate!)
                  : '-',
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1);
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const Spacer(),
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _JourneyRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _JourneyRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
