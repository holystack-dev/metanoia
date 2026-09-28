import 'package:flutter/material.dart';

/// The app's font-size preference, applied on top of the device's own text
/// size rather than instead of it.
///
/// The product is clamped to [minScale]..[maxScale]; a 2x system size times
/// Extra Large would otherwise break layouts.
class AppTextScaler extends TextScaler {
  const AppTextScaler({required this.system, required this.preference});

  /// The device's text size, as the user set it for their whole phone.
  final TextScaler system;

  /// The app's own Small / Medium / Large / Extra Large setting.
  final double preference;

  static const minScale = 0.8;
  static const maxScale = 2.0;

  @override
  double scale(double fontSize) {
    // Routed through the system scaler rather than reduced to a multiplier, so
    // a non-linear OS curve (Android 14+) is preserved instead of flattened.
    final scaled = system.scale(fontSize * preference);

    return scaled.clamp(fontSize * minScale, fontSize * maxScale);
  }

  // Deprecated but still abstract on TextScaler. Real scaling uses [scale].
  @override
  // ignore: deprecated_member_use
  double get textScaleFactor =>
      // ignore: deprecated_member_use
      (system.textScaleFactor * preference).clamp(minScale, maxScale);

  @override
  bool operator ==(Object other) =>
      other is AppTextScaler &&
      other.system == system &&
      other.preference == preference;

  @override
  int get hashCode => Object.hash(system, preference);
}
