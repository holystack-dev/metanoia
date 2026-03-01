import 'dart:math';
import 'dart:ui';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confessionapp/src/features/home/data/repositories/quote_repository.dart';
import 'package:confessionapp/src/features/home/domain/models/quote.dart';

part 'quote_provider.g.dart';

@riverpod
QuoteRepository quoteRepository(Ref ref) {
  return QuoteRepository();
}

@riverpod
Future<Quote> randomQuote(Ref ref, Locale locale) async {
  final repository = ref.watch(quoteRepositoryProvider);
  final quotes = await repository.getQuotes(locale);

  if (quotes.isEmpty) {
    // Fallback quote if list is empty
    return Quote(
      author: '1 John 1:9',
      quote:
          'If we confess our sins, he is faithful and just and will forgive us our sins and purify us from all unrighteousness.',
    );
  }

  final random = Random();
  return quotes[random.nextInt(quotes.length)];
}
