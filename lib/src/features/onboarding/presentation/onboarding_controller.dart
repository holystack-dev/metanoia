import 'package:confessionapp/src/core/preferences/preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_controller.g.dart';

@riverpod
class OnboardingController extends _$OnboardingController {
  static const _onboardingCompletedKey = 'onboarding_completed';

  /// Resolved synchronously from the preferences preloaded in `main`, so the
  /// router's `redirect` never awaits.
  @override
  bool build() {
    return ref.watch(sharedPreferencesProvider).getBool(_onboardingCompletedKey) ??
        false;
  }

  Future<void> markOnboardingComplete() async {
    state = true;
    await ref
        .read(sharedPreferencesProvider)
        .setBool(_onboardingCompletedKey, true);
  }

  Future<void> resetOnboarding() async {
    state = false;
    await ref
        .read(sharedPreferencesProvider)
        .setBool(_onboardingCompletedKey, false);
  }
}
