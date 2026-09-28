/// The liturgical year, computed offline.
///
/// Pure calendar arithmetic with no per-year tables. Movable feasts are derived
/// from Easter via the Gregorian Computus (Meeus/Jones/Butcher).
///
/// Day offsets use `DateTime(y, m, d + n)`, never `Duration`: adding
/// `Duration(days: 1)` adds 24 hours, which shifts the date across a DST
/// transition.
library;

/// A season of the liturgical year.
///
/// [holyWeek] is technically the last week of [lent]; it is reported separately
/// because it is the week the app most wants to speak differently about.
enum LiturgicalSeason {
  advent,
  christmas,
  lent,
  holyWeek,
  easter,
  ordinaryTime,
}

/// A major celebration the app may gently point at.
///
/// A small, closed set of the feasts most associated with confession. Names
/// are localized via `AppLocalizations`; the enum carries no user-facing text.
enum FeastId {
  ashWednesday,
  palmSunday,
  easter,
  pentecost,
  assumption,
  allSaints,
  immaculateConception,
  firstSundayOfAdvent,
  christmas,
}

/// A [FeastId] fixed to a calendar date.
class Feast {
  const Feast(this.id, this.date);

  final FeastId id;

  /// Local midnight on the day the feast falls.
  final DateTime date;

  @override
  bool operator ==(Object other) =>
      other is Feast && other.id == id && other.date == date;

  @override
  int get hashCode => Object.hash(id, date);

  @override
  String toString() =>
      'Feast(${id.name}, ${date.year}-${date.month}-${date.day})';
}

/// Offline liturgical calendar.
///
/// Stateless and const-constructible; all methods are pure functions of their
/// arguments.
class LiturgicalCalendar {
  const LiturgicalCalendar();

  // ---------------------------------------------------------------------------
  // Movable feasts
  // ---------------------------------------------------------------------------

  /// Easter Sunday in [year], by the Gregorian Computus.
  ///
  /// The Meeus/Jones/Butcher algorithm: it locates the paschal full moon, then
  /// the Sunday that follows it. Valid for any Gregorian year.
  static DateTime easterSunday(int year) {
    final a = year % 19;
    final b = year ~/ 100;
    final c = year % 100;
    final d = b ~/ 4;
    final e = b % 4;
    final f = (b + 8) ~/ 25;
    final g = (b - f + 1) ~/ 3;
    final h = (19 * a + b - d - g + 15) % 30;
    final i = c ~/ 4;
    final k = c % 4;
    final l = (32 + 2 * e + 2 * i - h - k) % 7;
    final m = (a + 11 * h + 22 * l) ~/ 451;
    final month = (h + l - 7 * m + 114) ~/ 31;
    final day = ((h + l - 7 * m + 114) % 31) + 1;
    return DateTime(year, month, day);
  }

  /// Ash Wednesday: 46 days before Easter (40 days of Lent plus its 6 Sundays).
  static DateTime ashWednesday(int year) => addDays(easterSunday(year), -46);

  /// Palm Sunday, the start of Holy Week: the Sunday before Easter.
  static DateTime palmSunday(int year) => addDays(easterSunday(year), -7);

  /// Pentecost: 49 days after Easter, closing the Easter season.
  static DateTime pentecost(int year) => addDays(easterSunday(year), 49);

  // ---------------------------------------------------------------------------
  // Fixed feasts
  // ---------------------------------------------------------------------------

  static DateTime assumption(int year) => DateTime(year, 8, 15);
  static DateTime allSaints(int year) => DateTime(year, 11, 1);
  static DateTime immaculateConception(int year) => DateTime(year, 12, 8);
  static DateTime christmas(int year) => DateTime(year, 12, 25);

  /// The First Sunday of Advent: the fourth Sunday before Christmas.
  ///
  /// Found by stepping back from Christmas to the Sunday that precedes it
  /// (Christmas itself does not count, even when it falls on a Sunday), then
  /// back three further Sundays.
  static DateTime firstSundayOfAdvent(int year) {
    final xmas = christmas(year);
    // DateTime.weekday: Monday = 1 ... Sunday = 7.
    final daysBackToSunday = xmas.weekday == DateTime.sunday ? 7 : xmas.weekday;
    final fourthSundayBefore = addDays(xmas, -daysBackToSunday - 21);
    return fourthSundayBefore;
  }

  /// Epiphany, taken here as the traditional 6 January — the app uses it only
  /// as the far edge of the Christmas season.
  static DateTime epiphany(int year) => DateTime(year, 1, 6);

  // ---------------------------------------------------------------------------
  // Seasons
  // ---------------------------------------------------------------------------

  /// The season [date] falls in.
  ///
  /// Boundaries (all inclusive):
  /// * Advent — First Sunday of Advent .. 24 December
  /// * Christmas — 25 December .. 6 January (Epiphany)
  /// * Lent — Ash Wednesday .. the Saturday before Palm Sunday
  /// * Holy Week — Palm Sunday .. Holy Saturday
  /// * Easter — Easter Sunday .. Pentecost
  /// * Ordinary Time — everything else
  LiturgicalSeason seasonOn(DateTime date) {
    final year = date.year;

    // Christmas season straddles New Year, so the tail of last year's
    // Christmas is checked before anything belonging to this year.
    if (!_isAfter(date, epiphany(year))) {
      // On or before 6 January: still Christmas (25 Dec of the previous year
      // through Epiphany).
      return LiturgicalSeason.christmas;
    }

    final easter = easterSunday(year);
    final palm = addDays(easter, -7);

    if (_inRange(date, ashWednesday(year), addDays(palm, -1))) {
      return LiturgicalSeason.lent;
    }
    if (_inRange(date, palm, addDays(easter, -1))) {
      return LiturgicalSeason.holyWeek;
    }
    if (_inRange(date, easter, pentecost(year))) {
      return LiturgicalSeason.easter;
    }
    if (_inRange(date, firstSundayOfAdvent(year), DateTime(year, 12, 24))) {
      return LiturgicalSeason.advent;
    }
    if (!_isBefore(date, christmas(year))) {
      // 25–31 December.
      return LiturgicalSeason.christmas;
    }
    return LiturgicalSeason.ordinaryTime;
  }

  // ---------------------------------------------------------------------------
  // Feasts
  // ---------------------------------------------------------------------------

  /// Every tracked feast in [year], in calendar order.
  List<Feast> feastsIn(int year) {
    final feasts = <Feast>[
      Feast(FeastId.ashWednesday, ashWednesday(year)),
      Feast(FeastId.palmSunday, palmSunday(year)),
      Feast(FeastId.easter, easterSunday(year)),
      Feast(FeastId.pentecost, pentecost(year)),
      Feast(FeastId.assumption, assumption(year)),
      Feast(FeastId.allSaints, allSaints(year)),
      Feast(FeastId.immaculateConception, immaculateConception(year)),
      Feast(FeastId.firstSundayOfAdvent, firstSundayOfAdvent(year)),
      Feast(FeastId.christmas, christmas(year)),
    ]..sort((a, b) => _compareDate(a.date, b.date));
    return feasts;
  }

  /// Tracked feasts falling in `[from, from + withinDays]`, nearest first.
  ///
  /// A feast *on* [from] is included (0 days away). Both [from]'s year and the
  /// next are considered, so a window opened in late December still sees
  /// January's calendar.
  List<Feast> upcomingFeasts(DateTime from, {int withinDays = 30}) {
    assert(withinDays >= 0);
    final start = startOfDay(from);
    final end = addDays(start, withinDays);

    return [
      ...feastsIn(start.year),
      ...feastsIn(start.year + 1),
    ].where((feast) => _inRange(feast.date, start, end)).toList()
      ..sort((a, b) => _compareDate(a.date, b.date));
  }

  /// Whole calendar days from [from] until [feast]; 0 when it is today.
  int daysUntil(Feast feast, DateTime from) =>
      daysBetweenDates(from, feast.date);
}

// -----------------------------------------------------------------------------
// Date helpers — calendar arithmetic only, never `Duration`.
// -----------------------------------------------------------------------------

/// [date] with the time of day stripped.
DateTime startOfDay(DateTime date) =>
    DateTime(date.year, date.month, date.day);

/// [date] shifted by [days] calendar days.
///
/// The `DateTime` constructor normalises out-of-range components (day 0 is the
/// last day of the previous month, day 32 rolls into the next), which makes
/// this exact across month, year and DST boundaries, unlike
/// `date.add(Duration(days: days))`, which adds 24-hour blocks.
DateTime addDays(DateTime date, int days) =>
    DateTime(date.year, date.month, date.day + days);

/// Whole calendar days between the date parts of [from] and [to].
///
/// Computed in UTC so no local day is ever 23 or 25 hours long.
int daysBetweenDates(DateTime from, DateTime to) {
  final a = DateTime.utc(from.year, from.month, from.day);
  final b = DateTime.utc(to.year, to.month, to.day);
  return b.difference(a).inDays;
}

int _compareDate(DateTime a, DateTime b) {
  if (a.year != b.year) return a.year.compareTo(b.year);
  if (a.month != b.month) return a.month.compareTo(b.month);
  return a.day.compareTo(b.day);
}

bool _isBefore(DateTime a, DateTime b) => _compareDate(a, b) < 0;
bool _isAfter(DateTime a, DateTime b) => _compareDate(a, b) > 0;

/// Whether [date] falls in `[start, end]`, comparing dates only.
bool _inRange(DateTime date, DateTime start, DateTime end) =>
    !_isBefore(date, start) && !_isAfter(date, end);
