import 'dart:convert';
import 'dart:ui';
import 'package:confessionapp/src/core/constants/app_constants.dart';
import 'package:confessionapp/src/features/home/domain/models/quote.dart';
import 'package:flutter/services.dart';

class QuoteRepository {
  Future<List<Quote>> getQuotes(Locale locale) async {
    try {
      // Determine the file path based on the locale
      final String langKey = LanguageConfig.contentKeyFromLocale(locale);
      final String filePath = 'assets/data/quotes/quotes_$langKey.json';

      // Load the JSON file from assets
      // Fallback to English if the specific locale file doesn't exist
      String jsonString;
      try {
        jsonString = await rootBundle.loadString(filePath);
      } catch (e) {
        // Fallback to English if file not found
        jsonString = await rootBundle.loadString(
          'assets/data/quotes/quotes_en.json',
        );
      }

      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => Quote.fromJson(json)).toList();
    } catch (e) {
      // Return empty list or throw error, handled by provider
      return [];
    }
  }
}
