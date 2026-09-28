import 'package:confessionapp/src/core/theme/app_text_scaler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// The app's font-size setting multiplies the device's text scale rather than
/// replacing it, so a user's OS-wide enlargement is respected.
void main() {
  const base = 16.0;

  AppTextScaler scaler({double system = 1.0, double preference = 1.0}) {
    return AppTextScaler(
      system: TextScaler.linear(system),
      preference: preference,
    );
  }

  test('honours the device text size when the app is on its default', () {
    // The OS setting is preserved.
    expect(scaler(system: 1.5).scale(base), 24);
  });

  test('honours the app preference when the device is on its default', () {
    expect(scaler(preference: 1.3).scale(base), closeTo(20.8, 0.001));
  });

  test('composes the two rather than letting one win', () {
    // 1.5 x 1.15 = 1.725
    expect(
      scaler(system: 1.5, preference: 1.15).scale(base),
      closeTo(27.6, 0.001),
    );
  });

  test('clamps the product, so an accessible phone does not tear layouts', () {
    // A device at 2x times the app's Extra Large would be 2.6x.
    final huge = scaler(system: 2.0, preference: 1.3);

    expect(huge.scale(base), base * AppTextScaler.maxScale);
  });

  test('clamps the floor too', () {
    final tiny = scaler(system: 0.5, preference: 0.85);

    expect(tiny.scale(base), base * AppTextScaler.minScale);
  });

  test('is equal for equal inputs, so MediaQuery does not rebuild needlessly',
      () {
    expect(scaler(system: 1.2, preference: 1.15), scaler(system: 1.2, preference: 1.15));
    expect(
      scaler(system: 1.2, preference: 1.15).hashCode,
      scaler(system: 1.2, preference: 1.15).hashCode,
    );
    expect(scaler(system: 1.2), isNot(scaler(system: 1.4)));
  });
}
