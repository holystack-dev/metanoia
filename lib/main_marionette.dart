// marionette_flutter is a dev dependency; the lint fires because this debug
// entrypoint lives in lib/.
// ignore: depend_on_referenced_packages
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:marionette_flutter/marionette_flutter.dart';

import 'main.dart' as app;

/// A debug-only entrypoint that exposes the running app to Marionette, so the
/// UI can be driven and screenshotted.
///
/// Not imported from `main.dart`: an automation surface that can read the
/// widget tree and tap anything must never be compiled into a release build
/// of an app holding the user's confessed sins.
///
/// Run with:
///   flutter run -t lib/main_marionette.dart -d <device>
void main() {
  assert(
    kDebugMode,
    'The Marionette entrypoint must never be built in release mode.',
  );

  MarionetteBinding.ensureInitialized();
  app.main();
}
