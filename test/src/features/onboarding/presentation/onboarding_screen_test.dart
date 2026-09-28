import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/preferences/preferences_provider.dart';
import 'package:confessionapp/src/features/onboarding/presentation/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferences prefs;

  setUp(() async {
    // Entrance animations are collapsed, but never `pumpAndSettle` these
    // screens: MysticalBackground repeats forever and would never settle.
    Animate.restartOnHotReload = false;
    Animate.defaultDuration = Duration.zero;
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
  });

  /// The onboarding screen with a real (but minimal) router, so the `context.go`
  /// on completion has somewhere to land.
  Widget harness() {
    final router = GoRouter(
      initialLocation: '/onboarding',
      routes: [
        GoRoute(
          path: '/onboarding',
          builder: (_, __) => const OnboardingScreen(),
        ),
        GoRoute(
          path: '/',
          builder: (_, __) => const Scaffold(body: Text('HOME')),
        ),
      ],
    );

    return ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: MaterialApp.router(
        routerConfig: router,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        theme: ThemeData.light(useMaterial3: true),
      ),
    );
  }

  /// `pumpAndSettle` would never return here (MysticalBackground repeats
  /// forever), so drive a bounded number of frames instead.
  Future<void> pumpFrames(WidgetTester tester, {int frames = 12}) async {
    for (var i = 0; i < frames; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  Future<void> pumpOnboarding(WidgetTester tester) async {
    // The onboarding pages are full-bleed and sized for a phone; the 800x600
    // default test window is shorter than any device they ship on.
    tester.view.physicalSize = const Size(1179, 2556);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(harness());
    await pumpFrames(tester);
  }

  /// Skip -> confirm.
  Future<void> confirmSkip(WidgetTester tester) async {
    await tester.tap(find.text('Skip').first);
    await pumpFrames(tester);
    // The dialog's confirm action carries the same label as the top-bar button.
    await tester.tap(find.descendant(
      of: find.byType(FilledButton),
      matching: find.text('Skip'),
    ));
    await pumpFrames(tester);
  }

  group('OnboardingScreen', () {
    testWidgets('is a five-page flow starting on the Metanoia page',
        (tester) async {
      await pumpOnboarding(tester);

      final pageView = tester.widget<PageView>(find.byType(PageView));
      expect(pageView.childrenDelegate.estimatedChildCount, 5);

      // Page 1: the etymology page, not a feature tour.
      expect(find.text('Turn Back to Grace'), findsOneWidget);
    });

    testWidgets('Skip lands on the final page and does NOT complete onboarding',
        (tester) async {
      await pumpOnboarding(tester);

      await confirmSkip(tester);

      // Skip does not complete outright: a skipper must still read the
      // disclaimer on the last page.
      expect(find.text("You're All Set"), findsOneWidget);
      expect(
        find.text(
          'A spiritual companion for confession—not a replacement for it.',
        ),
        findsOneWidget,
      );

      // Still in onboarding: the flag is untouched and we did not navigate home.
      expect(find.text('HOME'), findsNothing);
      expect(prefs.getBool('onboarding_completed'), isNot(isTrue));
    });

    testWidgets('completing from the final page sets the onboarding flag',
        (tester) async {
      await pumpOnboarding(tester);
      await confirmSkip(tester);

      await tester.tap(find.text('Get Started'));
      await pumpFrames(tester);

      expect(prefs.getBool('onboarding_completed'), isTrue);
      expect(find.text('HOME'), findsOneWidget);
    });
  });
}
