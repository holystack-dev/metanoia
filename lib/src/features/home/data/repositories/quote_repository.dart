import 'dart:convert';
import 'dart:ui';
import 'package:confessionapp/src/core/constants/app_constants.dart';
import 'package:confessionapp/src/features/home/domain/models/quote.dart';
import 'package:flutter/services.dart';

class QuoteRepository {
  Future<List<Quote>> getQuotes(Locale locale) async {
    try {
      final String langKey = LanguageConfig.contentKeyFromLocale(locale);
      final String filePath = 'assets/data/quotes/quotes_$langKey.json';

      String jsonString;
      try {
        jsonString = await rootBundle.loadString(filePath);
      } catch (e) {
        // No quotes for this language: fall back to English.
        jsonString = await rootBundle.loadString(
          'assets/data/quotes/quotes_en.json',
        );
      }

      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => Quote.fromJson(json)).toList();
    } catch (e) {
      // The provider substitutes a fallback quote for an empty list.
      return [];
    }
  }
}
