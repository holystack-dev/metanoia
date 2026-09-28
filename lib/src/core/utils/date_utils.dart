/// Calendar-aware date helpers.
///
/// `DateTime.difference(...).inDays` truncates elapsed time: yesterday at 8 PM
/// is 0 days before 7 AM today. These helpers count calendar days.
library;

/// The date part of [dateTime], with the time zeroed.
DateTime startOfDay(DateTime dateTime) =>
    DateTime(dateTime.year, dateTime.month, dateTime.day);

/// The stable, timezone-independent storage key for a journal day.
///
/// A journal entry belongs to a calendar date, not an instant. It is stored as
/// UTC midnight of the local calendar day, so the entry does not move to
/// another day when the device changes timezone.
DateTime journalDateKey(DateTime dateTime) =>
    DateTime.utc(dateTime.year, dateTime.month, dateTime.day);

/// The calendar day a stored [entryDate] belongs to, as a local-midnight
/// `DateTime` for the calendar and streak.
///
/// Drift returns `DateTime` columns in local time, so a UTC-midnight key
/// ([journalDateKey]) must go through `toUtc()` or it lands on the previous
/// day in negative-offset zones.
DateTime journalDayOf(DateTime entryDate) {
  final utc = entryDate.toUtc();
  return DateTime(utc.year, utc.month, utc.day);
}

/// Whole calendar days between [from] and [to], ignoring the time of day.
///
/// Yesterday is always 1, whatever the clock says.
int calendarDaysBetween(DateTime from, DateTime to) {
  // UTC avoids 23/25-hour days across a DST boundary.
  final fromDay = DateTime.utc(from.year, from.month, from.day);
  final toDay = DateTime.utc(to.year, to.month, to.day);
  return toDay.difference(fromDay).inDays;
}

/// Calendar days from [date] until now.
int calendarDaysSince(DateTime date, {DateTime? now}) =>
    calendarDaysBetween(date, now ?? DateTime.now());

/// The exact `yyyy-MM-dd` shape the `/journal/:date` route is built with.
final _isoDay = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$');

/// The journal day the `/journal/:date` path segment [raw] refers to, clamped
/// to today. Anything unusable falls back to today.
///
/// Dart rolls over out-of-range components (`2026-99-99`), so the parsed date
/// is round-tripped. Future days are rejected, as the calendar disables them.
DateTime journalDayFromPath(String? raw, {DateTime? now}) {
  final today = startOfDay(now ?? DateTime.now());
  if (raw == null) return today;

  final match = _isoDay.firstMatch(raw);
  if (match == null) return today;

  final year = int.parse(match.group(1)!);
  final month = int.parse(match.group(2)!);
  final day = int.parse(match.group(3)!);

  final parsed = DateTime(year, month, day);
  // Rolled-over components (month 99, day 99) do not survive the round trip.
  if (parsed.year != year || parsed.month != month || parsed.day != day) {
    return today;
  }

  return parsed.isAfter(today) ? today : parsed;
}
