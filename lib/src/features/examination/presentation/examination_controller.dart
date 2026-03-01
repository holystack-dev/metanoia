import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:confessionapp/src/features/confession/data/confession_repository.dart';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'examination_controller.g.dart';

const kLastExaminationPageKey = 'last_examination_page';

@riverpod
class ExaminationController extends _$ExaminationController {
  int? _draftConfessionId;
  bool _isInitialized = false;
  DateTime? lastSavedAt;
  bool isDraftRestored = false;

  @override
  Map<String, String> build() {
    // Load draft asynchronously after build
    if (!_isInitialized) {
      _isInitialized = true;
      _loadDraft();
    }
    return {};
  }

  Future<void> _loadDraft() async {
    final db = ref.read(appDatabaseProvider);

    // Find the most recent draft confession (isFinished = false)
    final drafts =
        await (db.select(db.confessions)
              ..where((t) => t.isFinished.equals(false))
              ..orderBy([(t) => OrderingTerm.desc(t.date)])
              ..limit(1))
            .get();

    if (drafts.isNotEmpty) {
      final draft = drafts.first;
      _draftConfessionId = draft.id;

      // Load the items from this draft
      final items =
          await (db.select(db.confessionItems)
            ..where((t) => t.confessionId.equals(draft.id))).get();

      // Convert items to Map<String, String> (custom sins use 'custom-{id}' key format)
      final Map<String, String> loadedState = {};
      for (var item in items) {
        if (item.isCustom && item.note != null) {
          // Custom sin stored with its ID in the note field
          loadedState['custom-${item.note}'] = item.content;
        } else if (item.questionId != null) {
          loadedState[item.questionId!] = item.content;
        }
      }

      if (loadedState.isNotEmpty) {
        state = loadedState;
        isDraftRestored = true;
        lastSavedAt = draft.date;
      }
    }
  }

  Future<void> selectQuestion(String id, String text) async {
    state = {...state, id: text};
    await _saveDraft();
  }

  Future<void> unselectQuestion(String id) async {
    final newState = Map<String, String>.from(state);
    newState.remove(id);
    state = newState;
    await _saveDraft();
  }

  bool isChecked(String id) {
    return state.containsKey(id);
  }

  Future<void> _saveDraft() async {
    final db = ref.read(appDatabaseProvider);

    // Create or update draft confession
    if (_draftConfessionId == null) {
      // Create new draft
      _draftConfessionId = await db
          .into(db.confessions)
          .insert(
            ConfessionsCompanion.insert(
              date: Value(DateTime.now()),
              isFinished: const Value(false),
            ),
          );
    } else {
      // Update draft date
      await (db.update(db.confessions)..where(
        (t) => t.id.equals(_draftConfessionId!),
      )).write(ConfessionsCompanion(date: Value(DateTime.now())));
    }

    // Delete existing items for this draft
    await (db.delete(db.confessionItems)
      ..where((t) => t.confessionId.equals(_draftConfessionId!))).go();

    // Insert current selections
    if (state.isNotEmpty) {
      final items =
          state.entries.map((entry) {
            // IDs starting with "custom-" are custom sins
            if (entry.key.startsWith('custom-')) {
              final customSinId = entry.key.substring(7); // Remove "custom-" prefix
              return ConfessionItemsCompanion.insert(
                confessionId: _draftConfessionId!,
                content: entry.value,
                isCustom: const Value(true),
                // Store the custom sin ID in the note field
                note: Value(customSinId),
              );
            } else {
              return ConfessionItemsCompanion.insert(
                confessionId: _draftConfessionId!,
                questionId: Value(entry.key),
                content: entry.value,
              );
            }
          }).toList();

      await db.batch((batch) {
        batch.insertAll(db.confessionItems, items);
      });
    }

    // Update last saved time
    lastSavedAt = DateTime.now();

    // Invalidate the draft provider so home screen updates
    ref.invalidate(activeExaminationDraftProvider);
  }

  Future<void> saveConfession() async {
    if (state.isEmpty) return;

    final db = ref.read(appDatabaseProvider);

    if (_draftConfessionId != null) {
      // Draft already saved - reset for next session
      _draftConfessionId = null;
    } else {
      // No draft exists, create a new confession
      final confessionId = await db
          .into(db.confessions)
          .insert(
            ConfessionsCompanion.insert(
              date: Value(DateTime.now()),
              isFinished: const Value(false),
            ),
          );

      final items =
          state.entries.map((entry) {
            // IDs starting with "custom-" are custom sins
            if (entry.key.startsWith('custom-')) {
              final customSinId = entry.key.substring(7); // Remove "custom-" prefix
              return ConfessionItemsCompanion.insert(
                confessionId: confessionId,
                content: entry.value,
                isCustom: const Value(true),
                // Store the custom sin ID in the note field
                note: Value(customSinId),
              );
            } else {
              return ConfessionItemsCompanion.insert(
                confessionId: confessionId,
                questionId: Value(entry.key),
                content: entry.value,
              );
            }
          }).toList();

      await db.batch((batch) {
        batch.insertAll(db.confessionItems, items);
      });
    }

    // Don't clear the state here - it will be cleared after navigation
    // to ensure the confess screen can load the data properly
  }

  Future<void> clearAfterSave() async {
    // Clear the state and reset for next examination
    state = {};
    _draftConfessionId = null;
    lastSavedAt = null;

    // Clear the saved examination page position
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(kLastExaminationPageKey);
  }

  Future<void> clearDraft() async {
    if (_draftConfessionId != null) {
      final db = ref.read(appDatabaseProvider);

      // Delete items first
      await (db.delete(db.confessionItems)
        ..where((t) => t.confessionId.equals(_draftConfessionId!))).go();

      // Delete the draft confession
      await (db.delete(db.confessions)
        ..where((t) => t.id.equals(_draftConfessionId!))).go();

      _draftConfessionId = null;
    }

    state = {};

    // Clear the saved examination page position
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(kLastExaminationPageKey);

    // Invalidate the draft provider so home screen updates
    ref.invalidate(activeExaminationDraftProvider);
  }
}
