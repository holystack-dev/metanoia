import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'tutorial_controller.g.dart';

@riverpod
class TutorialController extends _$TutorialController {
  static const _homeTutorialKey = 'home_tutorial_shown';
  static const _examinationTutorialKey = 'examination_tutorial_shown';
  static const _confessionTutorialKey = 'confession_tutorial_shown';

  @override
  FutureOr<void> build() {}

  Future<bool> shouldShowHomeTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    return !(prefs.getBool(_homeTutorialKey) ?? false);
  }

  Future<bool> shouldShowExaminationTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    return !(prefs.getBool(_examinationTutorialKey) ?? false);
  }

  Future<bool> shouldShowConfessionTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    return !(prefs.getBool(_confessionTutorialKey) ?? false);
  }

  Future<void> markHomeTutorialShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_homeTutorialKey, true);
  }

  Future<void> markExaminationTutorialShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_examinationTutorialKey, true);
  }

  Future<void> markConfessionTutorialShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_confessionTutorialKey, true);
  }

  Future<void> resetTutorials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_homeTutorialKey);
    await prefs.remove(_examinationTutorialKey);
    await prefs.remove(_confessionTutorialKey);
  }
}
