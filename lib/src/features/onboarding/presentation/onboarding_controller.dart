import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'onboarding_controller.g.dart';

@riverpod
class OnboardingController extends _$OnboardingController {
  static const _onboardingCompletedKey = 'onboarding_completed';

  @override
  Future<bool> build() async {
    return await hasCompletedOnboarding();
  }

  Future<bool> hasCompletedOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingCompletedKey) ?? false;
  }

  Future<void> markOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompletedKey, true);
    state = const AsyncValue.data(true);
  }

  Future<void> resetOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompletedKey, false);
    state = const AsyncValue.data(false);
  }
}
