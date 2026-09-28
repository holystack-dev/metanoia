import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/theme/app_radius.dart';
import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:confessionapp/src/core/utils/date_utils.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/features/journal/data/journal_repository.dart';
import 'package:confessionapp/src/features/journal/domain/models/journal_models.dart';
import 'package:confessionapp/src/features/journal/presentation/widgets/month_calendar.dart';
import 'package:confessionapp/src/features/journal/presentation/widgets/streak_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

/// Formats a day for the `/journal/:date` route (ISO `yyyy-MM-dd`).
String journalDatePath(DateTime day) =>
    DateFormat('yyyy-MM-dd').format(startOfDay(day));

/// The month calendar, with today's call to action on top.
class JournalScreen extends ConsumerStatefulWidget {
  const JournalScreen({super.key});

  @override
  ConsumerState<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends ConsumerState<JournalScreen> {
  late DateTime _month;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _month = DateTime(now.year, now.month, 1);
  }

  void _openDay(DateTime day) {
    context.push('/journal/${journalDatePath(day)}');
  }

  void _shiftMonth(int months) {
    setState(() {
      _month = DateTime(_month.year, _month.month + months, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final today = startOfDay(DateTime.now());
    final days = ref.watch(journalMonthProvider(_month)).valueOrNull ?? const {};
    final todayEntry = ref.watch(journalDayProvider(today)).valueOrNull;
    final isNextMonthInFuture = !DateTime(
      _month.year,
      _month.month + 1,
      1,
    ).isBefore(DateTime(today.year, today.month + 1, 1));

    return Scaffold(
      appBar: AppBar(
        // No back button: the journal is the root of its own shell branch.
        title: Text(l10n.journalTitle),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(child: StreakBadge()),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          children: [
            _TodayCard(
              entry: todayEntry,
              onTap: () {
                HapticUtils.lightImpact();
                _openDay(today);
              },
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              color: scheme.surfaceContainerHighest.withValues(alpha: 0.35),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.card),
                side: BorderSide(color: scheme.outlineVariant),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
                child: MonthCalendar(
                  month: _month,
                  days: days,
                  today: today,
                  onDaySelected: _openDay,
                  onPreviousMonth: () => _shiftMonth(-1),
                  onNextMonth: isNextMonthInFuture
                      ? null
                      : () => _shiftMonth(1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// "Evening reflection — how was today?", or a nudge to finish it.
class _TodayCard extends StatelessWidget {
  const _TodayCard({required this.entry, required this.onTap});

  final JournalDay? entry;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final hasEntry = entry?.isNotEmpty ?? false;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: scheme.primaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(
                Icons.nightlight_round,
                color: scheme.onPrimaryContainer,
                size: 28,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.journalHomeCardTitle,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: scheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      hasEntry
                          ? l10n.journalContinueToday
                          : l10n.journalHomeCardSubtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontFamily: AppTheme.fontFamilyEBGaramond,
                        color: scheme.onPrimaryContainer.withValues(
                          alpha: 0.85,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: scheme.onPrimaryContainer,
                semanticLabel: l10n.navigate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
