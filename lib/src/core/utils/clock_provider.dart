import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clock_provider.g.dart';

/// Today's date, as a provider.
///
/// Calendar-driven UI (liturgical prompt, anniversary nudge) reads the date
/// here rather than calling `DateTime.now()`, so tests can pin the day. The
/// time of day is stripped.
///
/// Kept alive for the process, which can live backgrounded for days, so it
/// recomputes on resume and at local midnight.
@Riverpod(keepAlive: true)
DateTime today(Ref ref) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  _invalidateOnResume(ref);
  _invalidateAtMidnight(ref, now: now, today: today);

  return today;
}

/// Recomputes the day whenever the app comes back to the foreground.
void _invalidateOnResume(Ref ref) {
  try {
    final listener = AppLifecycleListener(onResume: ref.invalidateSelf);
    ref.onDispose(listener.dispose);
  } catch (_) {
    // No widgets binding (pure unit test), so nothing can resume.
  }
}

/// Recomputes the day at the next local midnight, for an app left open.
///
/// The delay is built from calendar components rather than by adding 24 hours,
/// so it lands on midnight across a daylight-saving transition too.
void _invalidateAtMidnight(
  Ref ref, {
  required DateTime now,
  required DateTime today,
}) {
  final tomorrow = DateTime(today.year, today.month, today.day + 1);
  final untilMidnight = tomorrow.difference(now) + const Duration(seconds: 1);

  final timer = Timer(untilMidnight, ref.invalidateSelf);
  ref.onDispose(timer.cancel);
}
