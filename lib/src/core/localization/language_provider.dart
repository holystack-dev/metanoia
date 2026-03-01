import 'package:confessionapp/src/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'language_provider.g.dart';

@riverpod
class LanguageController extends _$LanguageController {
  @override
  Future<Locale?> build() async {
    final prefs = await SharedPreferences.getInstance();
    final contentKey = prefs.getString('app_language');
    if (contentKey != null) {
      return LanguageConfig.localeFromContentKey(contentKey);
    }
    return null;
  }

  Future<void> setLanguage(Locale? locale) async {
    final prefs = await SharedPreferences.getInstance();
    if (locale == null) {
      await prefs.remove('app_language');
    } else {
      await prefs.setString(
        'app_language',
        LanguageConfig.contentKeyFromLocale(locale),
      );
    }
    state = AsyncValue.data(locale);
  }
}
