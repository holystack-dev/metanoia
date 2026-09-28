import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:confessionapp/src/core/utils/haptic_utils.dart';

/// The back button for the app's AppBars.
///
/// * `context.pop()` when the route can pop.
/// * `context.go(fallbackLocation)` otherwise: a top-level route reached by a
///   deep link or notification has nothing beneath it to pop to.
///
/// The icon takes its colour from `appBarTheme.foregroundColor`.
class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.fallbackLocation = '/'});

  /// Where to go when this route has nothing to pop back to.
  final String fallbackLocation;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      // Localized by flutter_localizations in all supported locales.
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () {
        HapticUtils.lightImpact();
        if (context.canPop()) {
          context.pop();
        } else {
          context.go(fallbackLocation);
        }
      },
    );
  }
}
