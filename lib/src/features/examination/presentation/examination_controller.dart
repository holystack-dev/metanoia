import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'examination_controller.g.dart';

const kLastExaminationPageKey = 'last_examination_page';

/// Prefix used for custom sin selection keys ("custom-{id}").
const kCustomSinKeyPrefix = 'custom-';

/// Prefix used for selections carried over from a free-text journal sin mark
/// ("journal-{markId}").
///
/// A free-text mark matches no question or custom sin, so it gets its own key.
/// The mark id in the key links the finished confession back to the mark.
const kJournalSinKeyPrefix = 'journal-';

/// Converts a question id into a language-neutral selection key.
///
/// Question ids are language-scoped (`en-01-001`, `pt_BR-01-001`); selections
/// and draft rows key off the neutral part (`01-001`) so they survive a content
/// language switch. Custom sin keys (`custom-5`) are already neutral.
///
/// Idempotent, so drafts stored with scoped ids still load.
String neutralSelectionKey(String id) {
  if (id.startsWith(kCustomSinKeyPrefix)) return id;
  final parts = id.split('-');
  if (parts.length < 3) return id; // Already neutral ("01-001").
  return parts.sublist(parts.length - 2).join('-');
}

@riverpod
class ExaminationController extends _$ExaminationController {
  int? _draftConfessionId;
  bool _isInitialized = false;
  DateTime? lastSavedAt;
  bool isDraftRestored = false;

  /// Serializes writes to the draft rows so two rapid taps cannot both see a
  /// null draft id (inserting two Confessions rows) and item deletes/inserts
  /// cannot interleave.
  Future<void> _writeQueue = Future<void>.value();

  Future<void> _draftRestored = Future<void>.value();

  /// Completes once the persisted draft (if any) has been merged into [state].
  Future<void> get draftRestored => _draftRestored;

  @override
  Map<String, String> build() {
    // Load draft asynchronously after build
    if (!_isInitialized) {
      _isInitialized = true;
      _draftRestored = _enqueue(_loadDraft);
    }
    return {};
  }

  /// Runs [action] after every previously enqueued write has settled.
  Future<T> _enqueue<T>(Future<T> Function() action) {
    final result = _writeQueue.then((_) => action());
    // Keep the queue usable even if this write failed, while still handing the
    // error to the caller.
    _writeQueue = result.then<void>((_) {}, onError: (Object _) {});
    return result;
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
        // Pre-schema-3 rows that escaped the migration keep the custom sin id
        // in `note`.
        final customSinId = item.customSinId ?? int.tryParse(item.note ?? '');

        if (item.isCustom && customSinId != null) {
          loadedState['$kCustomSinKeyPrefix$customSinId'] = item.content;
        } else if (item.questionId != null) {
          // Older drafts may hold language-scoped ids.
          loadedState[neutralSelectionKey(item.questionId!)] = item.content;
        }
      }

      if (loadedState.isNotEmpty) {
        // Merge instead of overwrite: selections made while the draft was
        // still loading must not be clobbered by the restore.
        state = {...loadedState, ...state};
        isDraftRestored = true;
        lastSavedAt = draft.date;
      }
    }
  }

  Future<void> selectQuestion(String id, String text) async {
    state = {...state, neutralSelectionKey(id): text};
    await _saveDraft();
  }

  Future<void> unselectQuestion(String id) async {
    final key = neutralSelectionKey(id);
    // Nothing selected: skip the write so we never create an empty draft.
    if (!state.containsKey(key)) return;

    final newState = Map<String, String>.from(state);
    newState.remove(key);
    state = newState;
    await _saveDraft();
  }

  bool isChecked(String id) {
    return state.containsKey(neutralSelectionKey(id));
  }

  /// Carries the sins marked in the journal into this examination.
  ///
  /// [selections] maps a selection key to its display text:
  /// * a question mark uses its language-neutral key (`01-001`),
  /// * a custom sin uses `custom-{id}`,
  /// * a free-text mark uses `journal-{markId}` and is added as an item of its
  ///   own, since it matches neither a question nor a custom sin.
  ///
  /// Existing selections are left untouched, so preloading never duplicates or
  /// overwrites one.
  ///
  /// Uses the serialized write queue, since a burst of selections could
  /// otherwise insert two draft confessions.
  ///
  /// Returns how many sins were actually added.
  Future<int> preloadFromJournal(Map<String, String> selections) {
    return _enqueue<int>(() async {
      final merged = Map<String, String>.from(state);
      var added = 0;

      for (final entry in selections.entries) {
        final key = neutralSelectionKey(entry.key);
        if (merged.containsKey(key)) continue;
        merged[key] = entry.value;
        added++;
      }

      if (added == 0) return 0;

      state = merged;
      await _performSaveDraft();
      return added;
    });
  }

  Future<void> _saveDraft() => _enqueue(_performSaveDraft);

  Future<void> _performSaveDraft() async {
    final db = ref.read(appDatabaseProvider);
    final selections = Map<String, String>.from(state);

    await db.transaction(() async {
      // Create or update draft confession. Because writes are serialized, the
      // id is assigned exactly once.
      if (_draftConfessionId == null) {
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
      if (selections.isNotEmpty) {
        final items = _itemsFor(_draftConfessionId!, selections);
        await db.batch((batch) {
          batch.insertAll(db.confessionItems, items);
        });
      }
    });

    // Update last saved time
    lastSavedAt = DateTime.now();

    // The draft provider is a Drift stream over these rows.
  }

  List<ConfessionItemsCompanion> _itemsFor(
    int confessionId,
    Map<String, String> selections,
  ) {
    return selections.entries.map((entry) {
      // IDs starting with "custom-" are custom sins
      if (entry.key.startsWith(kCustomSinKeyPrefix)) {
        final customSinId = int.tryParse(
          entry.key.substring(kCustomSinKeyPrefix.length),
        );
        return ConfessionItemsCompanion.insert(
          confessionId: confessionId,
          content: entry.value,
          isCustom: const Value(true),
          // `note` is reserved for the user's own notes.
          customSinId: Value(customSinId),
        );
      }
      return ConfessionItemsCompanion.insert(
        confessionId: confessionId,
        questionId: Value(entry.key),
        content: entry.value,
      );
    }).toList();
  }

  Future<void> saveConfession() => _enqueue(_performSaveConfession);

  Future<void> _performSaveConfession() async {
    if (state.isEmpty) return;

    final db = ref.read(appDatabaseProvider);

    if (_draftConfessionId != null) {
      // Draft already saved - reset for next session
      _draftConfessionId = null;
      return;
    }

    // No draft exists, create a new confession
    final selections = Map<String, String>.from(state);
    await db.transaction(() async {
      final confessionId = await db
          .into(db.confessions)
          .insert(
            ConfessionsCompanion.insert(
              date: Value(DateTime.now()),
              isFinished: const Value(false),
            ),
          );

      final items = _itemsFor(confessionId, selections);
      await db.batch((batch) {
        batch.insertAll(db.confessionItems, items);
      });
    });

    // Don't clear the state here - it will be cleared by clearAfterSave() so
    // the confess screen can load the data properly.
  }

  Future<void> clearAfterSave() => _enqueue(_performClearAfterSave);

  Future<void> _performClearAfterSave() async {
    // Clear the state and reset for next examination
    state = {};
    _draftConfessionId = null;
    lastSavedAt = null;
    isDraftRestored = false;

    // Clear the saved examination page position
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(kLastExaminationPageKey);
  }

  Future<void> clearDraft() => _enqueue(_performClearDraft);

  Future<void> _performClearDraft() async {
    if (_draftConfessionId != null) {
      final db = ref.read(appDatabaseProvider);
      final draftId = _draftConfessionId!;

      await db.transaction(() async {
        // Delete items first
        await (db.delete(db.confessionItems)
          ..where((t) => t.confessionId.equals(draftId))).go();

        // Delete the draft confession
        await (db.delete(db.confessions)
          ..where((t) => t.id.equals(draftId))).go();
      });

      _draftConfessionId = null;
    }

    state = {};
    isDraftRestored = false;

    // Clear the saved examination page position
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(kLastExaminationPageKey);
  }
}
