import 'dart:convert';

import 'package:confessionapp/src/core/constants/app_constants.dart';
import 'package:flutter/services.dart';

/// Loads a bundled JSON content file for a content language, falling back to
/// English when that language's file is missing.
///
/// [pathBuilder] maps a language key (`en`, `pt_BR`, ...) to its asset path.
Future<String> loadLocalizedAsset(
  String languageKey,
  String Function(String languageKey) pathBuilder,
) async {
  try {
    return await rootBundle.loadString(pathBuilder(languageKey));
  } catch (_) {
    if (languageKey == LanguageConfig.defaultContentLanguage) rethrow;

    // English is bundled for every content type.
    return rootBundle.loadString(
      pathBuilder(LanguageConfig.defaultContentLanguage),
    );
  }
}

/// [loadLocalizedAsset], decoded as a JSON object.
Future<Map<String, dynamic>> loadLocalizedJsonObject(
  String languageKey,
  String Function(String languageKey) pathBuilder,
) async {
  final raw = await loadLocalizedAsset(languageKey, pathBuilder);
  return jsonDecode(raw) as Map<String, dynamic>;
}

/// [loadLocalizedAsset], decoded as a JSON array.
Future<List<dynamic>> loadLocalizedJsonArray(
  String languageKey,
  String Function(String languageKey) pathBuilder,
) async {
  final raw = await loadLocalizedAsset(languageKey, pathBuilder);
  return jsonDecode(raw) as List<dynamic>;
}
