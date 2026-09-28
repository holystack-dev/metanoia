import 'dart:async';

import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/utils/date_utils.dart';
import 'package:confessionapp/src/features/examination/data/examination_repository.dart';
import 'package:confessionapp/src/features/examination/presentation/examination_controller.dart'
    show neutralSelectionKey;
import 'package:confessionapp/src/features/journal/data/journal_repository.dart';
import 'package:confessionapp/src/features/journal/domain/models/journal_models.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'journal_entry_controller.g.dart';

/// How long a text field sits idle before its value is written.
///
/// Autosave must not write on every keystroke, but it must also never lose an
/// evening's reflection: pending text is flushed when the controller is
/// disposed (i.e. when the user leaves the screen).
const kJournalAutosaveDebounce = Duration(milliseconds: 500);

/// What the autosave indicator should show.
enum JournalSaveStatus { idle, pending, saved }

/// Which text field a debounced write belongs to.
enum _JournalField { gratitude, reflection, resolution }

/// Drives the daily entry: debounced autosave of the text fields, immediate
/// writes for mood and sin marks.
///
/// Writes themselves are serialized inside [JournalRepository]; this controller
/// only decides *when* to write.
@riverpod
class JournalEntryController extends _$JournalEntryController {
  final Map<_JournalField, Timer> _timers = {};
  final Map<_JournalField, String> _pending = {};

  // Not `late final`: build() runs again whenever the repository provider is
  // recreated, and a second assignment to a late final field throws.
  JournalRepository? _repository;
  DateTime _day = DateTime.now();
  bool _disposed = false;

  @override
  JournalSaveStatus build(DateTime day) {
    _repository = ref.watch(journalRepositoryProvider);
    _day = startOfDay(day);

    ref.onDispose(() {
      _disposed = true;
      // Leaving the screen must not drop what is still sitting in the debounce
      // window, so anything pending is written now.
      for (final timer in _timers.values) {
        timer.cancel();
      }
      _timers.clear();
      for (final field in _pending.keys.toList()) {
        unawaited(_write(field, _pending[field]!));
      }
      _pending.clear();
    });

    return JournalSaveStatus.idle;
  }

  // ------------------------------------------------------------------- text

  void setGratitude(String value) => _debounce(_JournalField.gratitude, value);

  void setReflection(String value) =>
      _debounce(_JournalField.reflection, value);

  void setResolution(String value) =>
      _debounce(_JournalField.resolution, value);

  /// Writes anything still sitting in the debounce window immediately.
  ///
  /// [onDispose] only runs on an ordinary screen exit, but the OS can kill a
  /// backgrounded app without ever disposing the screen. Flushing when the app
  /// leaves the foreground is what keeps an evening's reflection from dying in
  /// the 500ms debounce gap.
  Future<void> flushPending() async {
    final writes = <Future<void>>[];
    for (final timer in _timers.values) {
      timer.cancel();
    }
    _timers.clear();
    for (final field in _pending.keys.toList()) {
      final value = _pending.remove(field);
      if (value != null) writes.add(_write(field, value));
    }
    await Future.wait(writes);
  }

  void _debounce(_JournalField field, String value) {
    _pending[field] = value;
    state = JournalSaveStatus.pending;

    _timers[field]?.cancel();
    _timers[field] = Timer(kJournalAutosaveDebounce, () {
      _timers.remove(field);
      final pending = _pending.remove(field);
      if (pending == null) return;
      unawaited(_write(field, pending));
    });
  }

  Future<void> _write(_JournalField field, String value) async {
    final repository = _repository;
    if (repository == null) return;

    // An emptied field is stored as null rather than "", so an entry the user
    // cleared out counts as empty for the streak and the calendar.
    final text = value.trim();
    final stored = Value<String?>(text.isEmpty ? null : text);

    await switch (field) {
      _JournalField.gratitude => repository.saveEntry(_day, gratitude: stored),
      _JournalField.reflection => repository.saveEntry(
        _day,
        reflection: stored,
      ),
      _JournalField.resolution => repository.saveEntry(
        _day,
        resolution: stored,
      ),
    };

    _markSaved();
  }

  void _markSaved() {
    // The provider can be gone by the time a flushed write completes.
    if (_disposed) return;
    if (_pending.isNotEmpty) return;
    state = JournalSaveStatus.saved;
  }

  // ------------------------------------------------------------------- mood

  Future<void> setMood(Mood? mood) async {
    state = JournalSaveStatus.pending;
    await _repository?.saveEntry(_day, mood: Value(mood?.value));
    _markSaved();
  }

  // --------------------------------------------------------------- sin marks

  /// Marks a question from the standard bank.
  ///
  /// [questionId] is the language-scoped content id (`en-1-001`); it is stored
  /// language-neutral (`1-001`) so the mark survives a content-language switch.
  Future<void> markQuestion(
    String questionId, {
    int? commandmentNo,
    String? sinText,
  }) async {
    state = JournalSaveStatus.pending;
    await _repository?.addSinMark(
      _day,
      questionKey: neutralSelectionKey(questionId),
      sinText: sinText,
      commandmentNo: commandmentNo,
    );
    _markSaved();
  }

  Future<void> markCustomSin(
    int customSinId, {
    int? commandmentNo,
    String? sinText,
  }) async {
    state = JournalSaveStatus.pending;
    await _repository?.addSinMark(
      _day,
      customSinId: customSinId,
      sinText: sinText,
      commandmentNo: commandmentNo,
    );
    _markSaved();
  }

  Future<void> markFreeText(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    state = JournalSaveStatus.pending;
    await _repository?.addSinMark(_day, freeText: trimmed);
    _markSaved();
  }

  Future<void> removeMark(int markId) async {
    state = JournalSaveStatus.pending;
    await _repository?.removeSinMark(markId);
    _markSaved();
  }

  /// Deletes the whole day, marks included.
  Future<void> deleteDay() async {
    for (final timer in _timers.values) {
      timer.cancel();
    }
    _timers.clear();
    _pending.clear();

    await _repository?.deleteDay(_day);
    if (_disposed) return;
    state = JournalSaveStatus.idle;
  }
}

/// Resolves stored sin marks into display text using the *current* content
/// language.
///
/// Marks store a language-neutral question key, never the text, so a user who
/// switches content language sees their journal in the new language rather than
/// losing it.
class SinTextResolver {
  const SinTextResolver({
    required this.questionTexts,
    required this.customSinTexts,
  });

  /// Neutral question key (`1-001`) to question text.
  final Map<String, String> questionTexts;

  /// Custom sin id to its text.
  final Map<int, String> customSinTexts;

  ResolvedSinMark resolve(JournalSinMark mark) {
    // Prefer the live content text (so a language switch updates a standard
    // question), then the snapshot taken when the sin was marked (so an edited
    // or deleted custom sin does not blank the mark), then any free text, and
    // only as a last resort the raw key.
    final text = switch (mark) {
      _ when mark.questionKey != null =>
        questionTexts[mark.questionKey!] ??
            mark.sinTextSnapshot ??
            mark.freeText ??
            mark.questionKey!,
      _ when mark.customSinId != null =>
        customSinTexts[mark.customSinId!] ??
            mark.sinTextSnapshot ??
            mark.freeText ??
            '',
      _ => mark.freeText ?? mark.sinTextSnapshot ?? '',
    };
    return ResolvedSinMark(mark: mark, text: text);
  }
}

/// Display text for sin marks, in the current content language.
@riverpod
Future<SinTextResolver> sinTextResolver(Ref ref) async {
  final data = await ref.watch(examinationDataProvider.future);

  final questionTexts = <String, String>{};
  final customSinTexts = <int, String>{};

  for (final section in data) {
    for (final question in section.questions) {
      questionTexts[neutralSelectionKey(question.id)] = question.question;
    }
    for (final sin in section.customSins) {
      customSinTexts[sin.id] = sin.sinText;
    }
  }

  return SinTextResolver(
    questionTexts: questionTexts,
    customSinTexts: customSinTexts,
  );
}
