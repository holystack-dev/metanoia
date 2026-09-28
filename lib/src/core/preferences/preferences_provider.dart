import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preferences_provider.g.dart';

/// The already-loaded [SharedPreferences] instance.
///
/// Loaded before `runApp` and injected as an override, so settings controllers
/// can read synchronously and the first frame uses the user's settings.
///
/// Overridden in [main]; reading it without that override is a programming
/// error.
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(Ref ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be overridden with the instance preloaded '
    'in main()',
  );
}
