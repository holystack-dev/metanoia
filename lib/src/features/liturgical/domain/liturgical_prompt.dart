import 'package:confessionapp/src/features/liturgical/domain/liturgical_calendar.dart';

/// A single, gentle invitation to prepare for confession, chosen from the
/// liturgical calendar.
///
/// Rules:
///
/// * At most one prompt is live; a nearing feast outranks a season.
/// * A season prompt appears only in the first week of the season.
/// * A feast prompt appears only inside its lead window ([feastLeadDays]), and
///   never on the feast day itself.
/// * [dismissalKey] is year-scoped, so dismissing "Lent 2026" does not affect
///   2027.
sealed class LiturgicalPrompt {
  const LiturgicalPrompt();

  /// Stable, year-scoped identity used to persist a dismissal.
  String get dismissalKey;
}

/// "Lent has begun." — the opening days of a penitential/preparatory season.
class SeasonPrompt extends LiturgicalPrompt {
  const SeasonPrompt({required this.season, required this.year});

  final LiturgicalSeason season;

  /// The calendar year the season started in (Advent 2026 spills into 2027, but
  /// is still Advent 2026).
  final int year;

  @override
  String get dismissalKey => 'season:${season.name}:$year';

  @override
  bool operator ==(Object other) =>
      other is SeasonPrompt && other.season == season && other.year == year;

  @override
  int get hashCode => Object.hash(season, year);
}

/// "Christmas is near — prepare your heart."
class FeastPrompt extends LiturgicalPrompt {
  const FeastPrompt({required this.feast, required this.daysUntil});

  final Feast feast;

  /// Whole calendar days until the feast; always >= 1.
  final int daysUntil;

  @override
  String get dismissalKey => 'feast:${feast.id.name}:${feast.date.year}';

  @override
  bool operator ==(Object other) =>
      other is FeastPrompt &&
      other.feast == feast &&
      other.daysUntil == daysUntil;

  @override
  int get hashCode => Object.hash(feast, daysUntil);
}

/// How many days ahead of each feast the app may speak.
///
/// A feast absent from this map (or mapped to 0) never raises a prompt of its
/// own: Ash Wednesday, Palm Sunday, Easter and the First Sunday of Advent open
/// a season, which is covered by the season prompt.
const Map<FeastId, int> feastLeadDays = {
  FeastId.christmas: 9,
  FeastId.immaculateConception: 5,
  FeastId.assumption: 5,
  FeastId.allSaints: 5,
  FeastId.pentecost: 5,
};

/// Seasons worth an invitation, and how long the invitation stays up.
const Map<LiturgicalSeason, int> _seasonPromptWindowDays = {
  LiturgicalSeason.lent: 7,
  LiturgicalSeason.holyWeek: 7,
  LiturgicalSeason.advent: 7,
};

/// The one prompt to show on [date], or `null` for silence.
///
/// [dismissed] holds the [LiturgicalPrompt.dismissalKey]s the user has already
/// waved away; a dismissed prompt is not replaced by a lesser one, it simply
/// yields to whatever comes next in the calendar.
LiturgicalPrompt? liturgicalPromptOn(
  DateTime date, {
  Set<String> dismissed = const {},
  LiturgicalCalendar calendar = const LiturgicalCalendar(),
}) {
  final today = startOfDay(date);

  // 1. A feast inside its lead window wins: it is the more specific, more
  //    time-bound thing to say.
  final maxLead = feastLeadDays.values.fold(0, (a, b) => a > b ? a : b);
  for (final feast in calendar.upcomingFeasts(today, withinDays: maxLead)) {
    final lead = feastLeadDays[feast.id] ?? 0;
    final days = calendar.daysUntil(feast, today);
    if (days < 1 || days > lead) continue;

    final prompt = FeastPrompt(feast: feast, daysUntil: days);
    if (dismissed.contains(prompt.dismissalKey)) continue;
    return prompt;
  }

  // 2. Otherwise, the opening week of a penitential or preparatory season.
  final season = calendar.seasonOn(today);
  final window = _seasonPromptWindowDays[season];
  if (window == null) return null;

  final start = _seasonStart(season, today, calendar);
  if (start == null) return null;

  final elapsed = daysBetweenDates(start, today);
  if (elapsed < 0 || elapsed >= window) return null;

  final prompt = SeasonPrompt(season: season, year: start.year);
  return dismissed.contains(prompt.dismissalKey) ? null : prompt;
}

/// The day [season] began, given that [date] falls inside it.
DateTime? _seasonStart(
  LiturgicalSeason season,
  DateTime date,
  LiturgicalCalendar calendar,
) {
  switch (season) {
    case LiturgicalSeason.lent:
      return LiturgicalCalendar.ashWednesday(date.year);
    case LiturgicalSeason.holyWeek:
      return LiturgicalCalendar.palmSunday(date.year);
    case LiturgicalSeason.advent:
      // Advent runs into late December but never past it, so the season that
      // contains `date` always started in `date`'s own year.
      return LiturgicalCalendar.firstSundayOfAdvent(date.year);
    case LiturgicalSeason.christmas:
    case LiturgicalSeason.easter:
    case LiturgicalSeason.ordinaryTime:
      return null;
  }
}
