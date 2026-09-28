import 'package:confessionapp/src/core/services/spread_the_word_service.dart';
import 'package:confessionapp/src/features/home/domain/spread_the_word.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'spread_the_word_provider.g.dart';

/// Which "spread the word" invitation the home screen shows.
///
/// Backed by [SharedPreferences], which is not reactive, so the card
/// invalidates this provider after the user shares, rates or dismisses.
@riverpod
Future<SpreadTheWordKind> spreadTheWord(Ref ref) async {
  final state = await SpreadTheWordService().load();
  return resolveSpreadTheWord(
    appOpenCount: state.appOpenCount,
    completedConfessions: state.completedConfessions,
    ratingHandled: state.ratingHandled,
    snoozed: state.snoozed,
  );
}
