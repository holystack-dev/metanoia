import 'package:confessionapp/src/core/preferences/preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
class ThemeModeController extends _$ThemeModeController {
  static const _key = 'theme_mode';

  /// Resolved synchronously from the preferences preloaded in `main`, so the
  /// very first frame already uses the user's theme.
  @override
  ThemeMode build() {
    final themeName = ref.watch(sharedPreferencesProvider).getString(_key);
    if (themeName == null) return ThemeMode.system;

    return ThemeMode.values.firstWhere(
      (e) => e.name == themeName,
      orElse: () => ThemeMode.system,
    );
  }

  void toggleTheme() {
    final newMode = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    setTheme(newMode);
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    await ref.read(sharedPreferencesProvider).setString(_key, mode.name);
  }
}
