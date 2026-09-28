import 'package:confessionapp/src/core/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A snapshot of everything [resolveSpreadTheWord] needs, read from
/// [SharedPreferences] in one pass.
class SpreadState {
  const SpreadState({
    required this.appOpenCount,
    required this.completedConfessions,
    required this.ratingHandled,
    required this.snoozed,
  });

  final int appOpenCount;
  final int completedConfessions;
  final bool ratingHandled;

  /// Whether the invitation is currently snoozed (dismissed or acted on within
  /// the last [SpreadConfig.snoozeDays]).
  final bool snoozed;
}

/// Persists the small amount of state behind the home-screen "spread the word"
/// invitation.
///
/// Reads the `confession_count` key that [InAppReviewService] maintains, so
/// both rating paths share one counter.
class SpreadTheWordService {
  static const String _openCountKey = 'app_open_count';

  /// Shared with `InAppReviewService` — do not rename without updating both.
  static const String _confessionCountKey = 'confession_count';

  static const String _ratingHandledKey = 'spread_rating_handled';
  static const String _snoozedUntilKey = 'spread_snoozed_until';

  /// Count one cold app open. Called once per home mount, which is once per
  /// launch (the home tab is the shell's landing branch and its state is not
  /// rebuilt while the app stays alive).
  Future<void> recordAppOpen() async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt(_openCountKey) ?? 0;
    await prefs.setInt(_openCountKey, current + 1);
  }

  /// Read everything the resolver needs in one shot.
  Future<SpreadState> load() async {
    final prefs = await SharedPreferences.getInstance();

    return SpreadState(
      appOpenCount: prefs.getInt(_openCountKey) ?? 0,
      completedConfessions: prefs.getInt(_confessionCountKey) ?? 0,
      ratingHandled: prefs.getBool(_ratingHandledKey) ?? false,
      snoozed: _isSnoozed(prefs),
    );
  }

  bool _isSnoozed(SharedPreferences prefs) {
    final until = prefs.getString(_snoozedUntilKey);
    if (until == null) return false;
    final parsed = DateTime.tryParse(until);
    return parsed != null && parsed.isAfter(DateTime.now());
  }

  /// Hide the invitation for [SpreadConfig.snoozeDays]. Used after a share, or
  /// when the user taps "Not now".
  Future<void> snooze() async {
    final prefs = await SharedPreferences.getInstance();
    final until = DateTime.now().add(
      const Duration(days: SpreadConfig.snoozeDays),
    );
    await prefs.setString(_snoozedUntilKey, until.toIso8601String());
  }

  /// Record that the user has been through the rating gate (whichever way it
  /// went), so the "rate" ask never returns; only the "share" one can.
  Future<void> markRatingHandled() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_ratingHandledKey, true);
  }
}
