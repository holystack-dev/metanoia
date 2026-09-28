import 'package:confessionapp/src/core/utils/date_utils.dart';
import 'package:flutter_test/flutter_test.dart';

/// A journal entry belongs to a calendar date, not an instant. Storing local
/// midnight as a timestamp lets the entry drift onto the previous/next day once
/// the user crosses a timezone. [journalDateKey] encodes the date as UTC
/// midnight so the stored instant is zone-independent, and [journalDayOf]
/// recovers the calendar date however the database layer hands the value back.
void main() {
  test('journalDateKey ignores the time of day', () {
    final morning = journalDateKey(DateTime(2026, 7, 16, 7, 30));
    final night = journalDateKey(DateTime(2026, 7, 16, 23, 59));
    expect(morning, night);
    expect(morning, DateTime.utc(2026, 7, 16));
  });

  test('journalDateKey encodes the date as UTC midnight, not a local instant',
      () {
    final key = journalDateKey(DateTime(2026, 7, 16, 14, 0));
    expect(key.isUtc, isTrue);
    expect(key.hour, 0);
    expect(key, DateTime.utc(2026, 7, 16));
  });

  test('journalDayOf recovers the calendar date after a local read-back', () {
    // The database returns a DateTime column as a *local* wall-clock time of the
    // stored instant. Simulate that round trip: store the key, hand it back as
    // local time, and confirm the calendar date is unchanged. In a negative-UTC
    // machine zone the local time lands on the previous evening, which is
    // exactly the case a naive startOfDay would get wrong.
    final stored = journalDateKey(DateTime(2026, 7, 16, 20, 0));
    final asDatabaseReturnsIt = stored.toLocal();

    expect(journalDayOf(asDatabaseReturnsIt), DateTime(2026, 7, 16));
  });

  test('journalDayOf is stable across every day of a month', () {
    for (var day = 1; day <= 31; day++) {
      final stored = journalDateKey(DateTime(2026, 1, day, 23, 30));
      expect(journalDayOf(stored.toLocal()), DateTime(2026, 1, day));
    }
  });
}
