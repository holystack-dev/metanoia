import 'dart:math' as math;

/// A gentle "it has been a while" invitation, measured against the user's own
/// cadence rather than any prescribed schedule.
class AnniversaryNudge {
  const AnniversaryNudge({
    required this.daysSinceLastConfession,
    required this.averageDaysBetween,
  });

  final int daysSinceLastConfession;

  /// The user's own average interval, in days.
  final double averageDaysBetween;

  /// Whole weeks since the last confession — the unit the prompt speaks in.
  ///
  /// Always >= 2: [minimumNudgeDays] guarantees it.
  int get weeksSinceLastConfession => daysSinceLastConfession ~/ 7;

  @override
  bool operator ==(Object other) =>
      other is AnniversaryNudge &&
      other.daysSinceLastConfession == daysSinceLastConfession &&
      other.averageDaysBetween == averageDaysBetween;

  @override
  int get hashCode => Object.hash(daysSinceLastConfession, averageDaysBetween);
}

/// Fewer than this many confessions and there is no "own cadence" to speak of —
/// two data points make an average, not a habit. Below it the app says nothing
/// rather than inventing a schedule for someone.
const int minimumConfessionsForCadence = 3;

/// A gap has to exceed the user's average by a quarter and by a week before
/// it means anything. Someone who confesses weekly is not "overdue" two days
/// late.
const double cadenceOvershootFactor = 1.25;
const int cadenceOvershootDays = 7;

/// The app never raises this prompt inside a fortnight, whatever the cadence.
const int minimumNudgeDays = 14;

/// Once dismissed, the prompt stays away for this long — dismissing it must not
/// be undone by tomorrow's rebuild.
const int nudgeDismissalCooldownDays = 14;

/// Whether to invite the user to prepare, and with what numbers.
///
/// Returns `null` — say nothing — when:
/// * there is not enough history for an average to mean anything
///   ([minimumConfessionsForCadence]),
/// * the gap has not meaningfully outrun the user's own average, or
/// * the prompt was dismissed inside the last [nudgeDismissalCooldownDays].
///
/// [daysSinceDismissal] is `null` when the prompt has never been dismissed.
AnniversaryNudge? evaluateAnniversaryNudge({
  required int totalConfessions,
  required double? averageDaysBetween,
  required int daysSinceLastConfession,
  int? daysSinceDismissal,
}) {
  if (totalConfessions < minimumConfessionsForCadence) return null;

  final average = averageDaysBetween;
  if (average == null || average <= 0) return null;

  if (daysSinceDismissal != null &&
      daysSinceDismissal >= 0 &&
      daysSinceDismissal < nudgeDismissalCooldownDays) {
    return null;
  }

  final threshold = math.max(
    math.max(average * cadenceOvershootFactor, average + cadenceOvershootDays),
    minimumNudgeDays.toDouble(),
  );
  if (daysSinceLastConfession <= threshold) return null;

  return AnniversaryNudge(
    daysSinceLastConfession: daysSinceLastConfession,
    averageDaysBetween: average,
  );
}
