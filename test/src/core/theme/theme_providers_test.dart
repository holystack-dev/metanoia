import 'package:confessionapp/src/core/preferences/preferences_provider.dart';
import 'package:confessionapp/src/core/theme/font_size_provider.dart';
import 'package:confessionapp/src/core/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// These controllers resolve synchronously from the preferences preloaded in
/// `main`. Returning a default and correcting it from an async read flashes the
/// wrong theme and font size on launch.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<ProviderContainer> containerWith(Map<String, Object> values) async {
    SharedPreferences.setMockInitialValues(values);
    final prefs = await SharedPreferences.getInstance();
    return ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    );
  }

  group('ThemeModeController', () {
    test('defaults to system when nothing is stored', () async {
      final container = await containerWith({});

      expect(container.read(themeModeControllerProvider), ThemeMode.system);
      container.dispose();
    });

    test('resolves the stored theme on the very first read', () async {
      final container = await containerWith({'flutter.theme_mode': 'dark'});

      // No pump, no await: if this needed a second frame to settle, the user
      // would see the light theme first.
      expect(container.read(themeModeControllerProvider), ThemeMode.dark);
      container.dispose();
    });

    test('falls back to system for an unrecognised stored value', () async {
      final container = await containerWith({'flutter.theme_mode': 'nonsense'});

      expect(container.read(themeModeControllerProvider), ThemeMode.system);
      container.dispose();
    });

    test('setTheme updates the state and persists', () async {
      final container = await containerWith({});

      await container
          .read(themeModeControllerProvider.notifier)
          .setTheme(ThemeMode.dark);

      expect(container.read(themeModeControllerProvider), ThemeMode.dark);
      expect(
        container.read(sharedPreferencesProvider).getString('theme_mode'),
        'dark',
      );
      container.dispose();
    });

    test('toggleTheme flips between light and dark', () async {
      final container = await containerWith({'flutter.theme_mode': 'light'});
      final notifier = container.read(themeModeControllerProvider.notifier);

      notifier.toggleTheme();
      expect(container.read(themeModeControllerProvider), ThemeMode.dark);

      notifier.toggleTheme();
      expect(container.read(themeModeControllerProvider), ThemeMode.light);
      container.dispose();
    });
  });

  group('FontSizeController', () {
    test('defaults to medium when nothing is stored', () async {
      final container = await containerWith({});

      expect(
        container.read(fontSizeControllerProvider),
        FontSizeScale.medium,
      );
      container.dispose();
    });

    test('resolves the stored scale on the very first read', () async {
      final container = await containerWith({
        'flutter.font_size_scale': 'extraLarge',
      });

      expect(
        container.read(fontSizeControllerProvider),
        FontSizeScale.extraLarge,
      );
      container.dispose();
    });

    test('falls back to medium for an unrecognised stored value', () async {
      final container = await containerWith({
        'flutter.font_size_scale': 'gigantic',
      });

      expect(container.read(fontSizeControllerProvider), FontSizeScale.medium);
      container.dispose();
    });

    test('setFontSize updates the state and persists', () async {
      final container = await containerWith({});

      await container
          .read(fontSizeControllerProvider.notifier)
          .setFontSize(FontSizeScale.large);

      expect(container.read(fontSizeControllerProvider), FontSizeScale.large);
      expect(
        container.read(sharedPreferencesProvider).getString('font_size_scale'),
        'large',
      );
      container.dispose();
    });

    test('every scale has a sane multiplier', () async {
      for (final scale in FontSizeScale.values) {
        expect(scale.scale, greaterThan(0.5));
        expect(scale.scale, lessThan(2.0));
      }
    });
  });
}
