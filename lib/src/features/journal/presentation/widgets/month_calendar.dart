import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/theme/app_radius.dart';
import 'package:confessionapp/src/core/utils/date_utils.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/features/journal/domain/models/journal_models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A month of journal days, with a dot under every day that has an entry.
class MonthCalendar extends StatelessWidget {
  const MonthCalendar({
    super.key,
    required this.month,
    required this.days,
    required this.onDaySelected,
    this.onPreviousMonth,
    this.onNextMonth,
    this.today,
  });

  /// Any date within the month being shown.
  final DateTime month;

  /// Entries of this month, keyed by local midnight.
  final Map<DateTime, JournalDay> days;

  final ValueChanged<DateTime> onDaySelected;
  final VoidCallback? onPreviousMonth;
  final VoidCallback? onNextMonth;

  /// Injectable for tests; defaults to the real today.
  final DateTime? today;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final materialL10n = MaterialLocalizations.of(context);
    final localeName = Localizations.localeOf(context).toLanguageTag();

    final now = startOfDay(today ?? DateTime.now());
    final firstOfMonth = DateTime(month.year, month.month, 1);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;

    // The week starts where the user's locale says it does.
    final firstDayOfWeek = materialL10n.firstDayOfWeekIndex;
    final leading = (firstOfMonth.weekday % 7 - firstDayOfWeek + 7) % 7;
    final cellCount = leading + daysInMonth;
    final rowCount = (cellCount / 7).ceil();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: onPreviousMonth == null
                  ? null
                  : () {
                      HapticUtils.lightImpact();
                      onPreviousMonth!();
                    },
              icon: const Icon(Icons.chevron_left),
              tooltip: l10n.journalPreviousMonth,
            ),
            Expanded(
              child: Text(
                DateFormat.yMMMM(localeName).format(firstOfMonth),
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: scheme.onSurface,
                ),
              ),
            ),
            IconButton(
              onPressed: onNextMonth == null
                  ? null
                  : () {
                      HapticUtils.lightImpact();
                      onNextMonth!();
                    },
              icon: const Icon(Icons.chevron_right),
              tooltip: l10n.journalNextMonth,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            for (var i = 0; i < 7; i++)
              Expanded(
                child: Text(
                  materialL10n.narrowWeekdays[(firstDayOfWeek + i) % 7],
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: scheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        for (var row = 0; row < rowCount; row++)
          Row(
            children: [
              for (var column = 0; column < 7; column++)
                Expanded(
                  child: Builder(
                    builder: (context) {
                      final dayNumber = row * 7 + column - leading + 1;
                      if (dayNumber < 1 || dayNumber > daysInMonth) {
                        return const AspectRatio(
                          aspectRatio: 1,
                          child: SizedBox.shrink(),
                        );
                      }

                      final date = DateTime(month.year, month.month, dayNumber);
                      final entry = days[date];

                      return _DayCell(
                        date: date,
                        entry: entry,
                        isToday: date == now,
                        isFuture: date.isAfter(now),
                        onTap: () {
                          HapticUtils.lightImpact();
                          onDaySelected(date);
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.date,
    required this.entry,
    required this.isToday,
    required this.isFuture,
    required this.onTap,
  });

  final DateTime date;
  final JournalDay? entry;
  final bool isToday;
  final bool isFuture;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final hasEntry = entry?.isNotEmpty ?? false;
    final dotColor = scheme.primary;

    final textColor = isFuture
        ? scheme.onSurfaceVariant.withValues(alpha: 0.4)
        : isToday
        ? scheme.primary
        : scheme.onSurface;

    return AspectRatio(
      aspectRatio: 1,
      child: InkWell(
        // Future days cannot be journalled: there is nothing to reflect on yet.
        onTap: isFuture ? null : onTap,
        borderRadius: BorderRadius.circular(AppRadius.card),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isToday ? scheme.primaryContainer : null,
              ),
              child: Text(
                '${date.day}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isToday ? scheme.onPrimaryContainer : textColor,
                  fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 3),
            SizedBox(
              width: 6,
              height: 6,
              child: hasEntry
                  ? DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: dotColor,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
