import 'package:confessionapp/src/core/constants/app_constants.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing in-app reviews
///
/// Follows best practices from Flutter in Production guide:
/// - Ask after "happy moments" (confession completion, penance completion)
/// - Don't ask immediately on app launch
/// - Let the OS handle frequency limits
/// - Provide manual rate option in settings
class InAppReviewService {
  static const String _dontAskKey = 'rate_app_dont_ask';
  static const String _confessionCountKey = 'confession_count';
  static const String _penanceCountKey = 'penance_count';
  static const String _lastPromptDateKey = 'rate_app_last_prompt_date';

  final InAppReview _inAppReview = InAppReview.instance;

  /// Check if user has opted out of review prompts
  Future<bool> hasOptedOut() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_dontAskKey) ?? false;
  }

  /// Set user's opt-out preference
  Future<void> setOptOut(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_dontAskKey, value);
  }

  /// Reset counters (for "remind me later" option)
  Future<void> resetCounters() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_confessionCountKey, 0);
    await prefs.setInt(_penanceCountKey, 0);
  }

  /// Record last prompt date
  Future<void> _recordPromptDate() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastPromptDateKey, DateTime.now().toIso8601String());
  }

  /// Check if enough time has passed since last prompt
  Future<bool> _hasEnoughTimePassed() async {
    final prefs = await SharedPreferences.getInstance();
    final lastPromptStr = prefs.getString(_lastPromptDateKey);

    if (lastPromptStr == null) return true;

    final lastPrompt = DateTime.tryParse(lastPromptStr);
    if (lastPrompt == null) return true;

    final daysSinceLastPrompt = DateTime.now().difference(lastPrompt).inDays;
    return daysSinceLastPrompt >= ReviewConfig.minDaysBetweenPrompts;
  }

  /// Track confession completion and check if review should be requested
  /// Returns true if a review prompt should be shown
  Future<bool> trackConfessionCompletion() async {
    if (await hasOptedOut()) return false;
    if (!await _hasEnoughTimePassed()) return false;

    final prefs = await SharedPreferences.getInstance();
    int count = prefs.getInt(_confessionCountKey) ?? 0;
    count++;
    await prefs.setInt(_confessionCountKey, count);

    // Check if we've hit the threshold
    if (count == ReviewConfig.confessionThreshold) {
      return await _inAppReview.isAvailable();
    }

    return false;
  }

  /// Track penance completion and check if review should be requested
  /// Returns true if a review prompt should be shown
  Future<bool> trackPenanceCompletion() async {
    if (await hasOptedOut()) return false;
    if (!await _hasEnoughTimePassed()) return false;

    final prefs = await SharedPreferences.getInstance();
    int count = prefs.getInt(_penanceCountKey) ?? 0;
    count++;
    await prefs.setInt(_penanceCountKey, count);

    // Check if we've hit the threshold
    if (count == ReviewConfig.penanceThreshold) {
      return await _inAppReview.isAvailable();
    }

    return false;
  }

  /// Request the native in-app review dialog
  /// Call this after user confirms they want to rate
  Future<void> requestReview() async {
    await _recordPromptDate();
    await _inAppReview.requestReview();
  }

  /// Open the store listing directly
  /// Use this for the manual "Rate App" button in settings
  Future<void> openStoreListing() async {
    await _inAppReview.openStoreListing(
      appStoreId: StoreConfig.appStoreId,
    );
  }

  /// Check if in-app review is available on this device
  Future<bool> isAvailable() async {
    return await _inAppReview.isAvailable();
  }
}
