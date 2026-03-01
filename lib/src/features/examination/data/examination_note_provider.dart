import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'examination_note_provider.g.dart';

/// Provider to manage the dismissible examination note state
/// Stores whether the user has permanently dismissed the note
@riverpod
class ExaminationNoteController extends _$ExaminationNoteController {
  static const _noteHiddenKey = 'examination_note_hidden';

  @override
  FutureOr<bool> build() async {
    return await _isNoteHidden();
  }

  /// Check if the note has been permanently dismissed
  Future<bool> _isNoteHidden() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_noteHiddenKey) ?? false;
  }

  /// Permanently hide the examination note
  Future<void> hideNote() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_noteHiddenKey, true);
    state = const AsyncValue.data(true);
  }
}
