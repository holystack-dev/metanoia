/// Corner-radius tokens for the whole app.
///
/// Every rounded corner should come from here. Use the semantic names at call
/// sites (`AppRadius.card`, `AppRadius.tile`, ...) rather than the raw scale.
abstract final class AppRadius {
  // ---------------------------------------------------------------------------
  // Scale (logical pixels)
  // ---------------------------------------------------------------------------
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 28;

  /// Fully rounded. Larger than any surface in the app, so Flutter clamps it to
  /// half the shorter side — i.e. a stadium/circle whatever the box size.
  static const double full = 999;

  // ---------------------------------------------------------------------------
  // Semantic tokens
  // ---------------------------------------------------------------------------

  /// Drag handles and progress-bar tracks.
  static const double bar = xxs;

  /// Chips, badges and other small pills.
  static const double chip = sm;

  /// List tiles, inputs, buttons and small icon containers.
  static const double tile = md;

  /// Cards and primary containers.
  static const double card = lg;

  /// Bottom sheets and large/feature containers.
  static const double sheet = xl;

  /// Material 3 dialogs (M3 spec default is 28).
  static const double dialog = xxl;

  /// Onboarding hero surfaces and their full-width CTA buttons.
  static const double hero = xxl;

  /// Circular/stadium surfaces: keypad keys, dots, indicators.
  static const double pill = full;
}
