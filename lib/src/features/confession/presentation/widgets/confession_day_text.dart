import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// The serif text style used everywhere inside Confession-day mode.
///
/// Scaled up from the theme's `bodyLarge` rather than a literal size, so the
/// app-wide `TextScaler` (the user's font-size preference) still applies.
///
/// [scale] is the multiple of normal body text. Everything in this mode reads
/// at 1.4x-1.6x body, which is what makes it legible in a dim confessional.
TextStyle confessionDaySerif(
  BuildContext context, {
  double scale = 1.6,
  double height = 1.6,
  FontWeight? fontWeight,
  FontStyle? fontStyle,
  Color? color,
}) {
  final theme = Theme.of(context);
  final base = theme.textTheme.bodyLarge ?? const TextStyle(fontSize: 16);

  return base.copyWith(
    fontFamily: AppTheme.fontFamilyEBGaramond,
    fontFamilyFallback: AppTheme.fontFamilyFallback,
    fontSize: (base.fontSize ?? 16) * scale,
    height: height,
    letterSpacing: 0,
    fontWeight: fontWeight,
    fontStyle: fontStyle,
    color: color ?? theme.colorScheme.onSurface,
  );
}

/// Strips the `[PRAYER]`/`[RUBRIC]`/... markers the bundled prayer content uses
/// for its rich rendering elsewhere.
///
/// Confession-day mode shows one prayer as a single calm block of text, so the
/// markers must not leak into it if a translation ever adds them.
String stripPrayerMarkup(String content) {
  return content.replaceAll(RegExp(r'\[/?[A-Z]+\]'), '').trim();
}
