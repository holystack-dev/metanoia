import 'package:flutter/services.dart';

/// Utility class for haptic feedback throughout the app.
/// Provides consistent tactile feedback for a premium feel.
class HapticUtils {
  /// Light impact - for selections, toggles, small interactions
  static void lightImpact() {
    HapticFeedback.lightImpact();
  }

  /// Medium impact - for button taps, card presses
  static void mediumImpact() {
    HapticFeedback.mediumImpact();
  }

  /// Heavy impact - for significant actions (delete, confirm)
  static void heavyImpact() {
    HapticFeedback.heavyImpact();
  }

  /// Selection click - for checkbox, radio, chip selections
  static void selectionClick() {
    HapticFeedback.selectionClick();
  }

  /// Vibrate - for errors or warnings
  static void vibrate() {
    HapticFeedback.vibrate();
  }
}
