import 'package:confessionapp/src/core/preferences/preferences_provider.dart';
import 'package:confessionapp/src/core/utils/clock_provider.dart';
import 'package:confessionapp/src/core/utils/date_utils.dart';
import 'package:confessionapp/src/features/confession/data/confession_analytics_repository.dart';
import 'package:confessionapp/src/features/confession/domain/anniversary_nudge.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'anniversary_nudge_provider.g.dart';

/// Days since the Unix epoch — a stable, timezone-proof way to store "the day
/// this was dismissed" in a single int.
int _epochDay(DateTime date) =>
    calendarDaysBetween(DateTime.utc(1970, 1, 1), date);

/// The day the anniversary prompt was last dismissed, if ever.
@riverpod
class AnniversaryDismissal extends _$AnniversaryDismissal {
  static const _key = 'anniversary_nudge_dismissed_epoch_day';

  @override
  int? build() => ref.watch(sharedPreferencesProvider).getInt(_key);

  Future<void> dismissToday() async {
    final day = _epochDay(ref.read(todayProvider));
    state = day;
    await ref.read(sharedPreferencesProvider).setInt(_key, day);
  }
}

/// The anniversary invitation to show, or `null` for silence.
///
/// Derived from the user's own confession history: see
/// [evaluateAnniversaryNudge] for the rules.
@riverpod
AnniversaryNudge? anniversaryNudge(Ref ref) {
  final analytics = ref.watch(confessionAnalyticsProvider).valueOrNull;
  if (analytics == null) return null;

  final dismissedOn = ref.watch(anniversaryDismissalProvider);
  final daysSinceDismissal = dismissedOn == null
      ? null
      : _epochDay(ref.watch(todayProvider)) - dismissedOn;

  return evaluateAnniversaryNudge(
    totalConfessions: analytics.totalConfessions,
    averageDaysBetween: analytics.averageDaysBetween,
    daysSinceLastConfession: analytics.daysSinceLastConfession,
    daysSinceDismissal: daysSinceDismissal,
  );
}
