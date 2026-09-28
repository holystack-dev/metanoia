import 'package:confessionapp/src/core/preferences/preferences_provider.dart';
import 'package:confessionapp/src/features/onboarding/presentation/onboarding_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferences prefs;

  Future<ProviderContainer> containerWith(Map<String, Object> values) async {
    SharedPreferences.setMockInitialValues(values);
    prefs = await SharedPreferences.getInstance();

    final container = ProviderContainer(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('OnboardingController', () {
    test('resolves to false synchronously when onboarding has never run',
        () async {
      final container = await containerWith({});

      // No AsyncValue: the router's redirect depends on this being readable
      // without awaiting anything.
      expect(container.read(onboardingControllerProvider), isFalse);
    });

    test('resolves to true synchronously when onboarding was completed',
        () async {
      final container = await containerWith({'onboarding_completed': true});

      expect(container.read(onboardingControllerProvider), isTrue);
    });

    test('markOnboardingComplete updates state immediately and persists',
        () async {
      final container = await containerWith({});

      await container
          .read(onboardingControllerProvider.notifier)
          .markOnboardingComplete();

      expect(container.read(onboardingControllerProvider), isTrue);
      expect(prefs.getBool('onboarding_completed'), isTrue);
    });

    test('resetOnboarding updates state immediately and persists', () async {
      final container = await containerWith({'onboarding_completed': true});

      await container
          .read(onboardingControllerProvider.notifier)
          .resetOnboarding();

      expect(container.read(onboardingControllerProvider), isFalse);
      expect(prefs.getBool('onboarding_completed'), isFalse);
    });
  });
}
