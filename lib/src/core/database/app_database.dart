import 'package:drift/drift.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'tables.dart';

import 'data_loader.dart';
import 'database_encryption.dart';
import 'package:confessionapp/src/core/constants/app_constants.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Commandments,
    ExaminationQuestions,
    Faqs,
    Quotes,
    Confessions,
    ConfessionItems,
    UserSettings,
    Prayers,
    UserCustomSins,
    Penances,
    JournalEntries,
    JournalSinMarks,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e, this.syncContentOnOpen = true])
    : super(e ?? openEncryptedDatabase());

  /// Whether to load the bundled JSON content into the database.
  ///
  /// Off in tests, which have no assets but still run the production
  /// [migration] (foreign keys, indexes).
  final bool syncContentOnOpen;

  /// SharedPreferences key recording the content version last synced into the
  /// database. See [ContentConfig.version].
  static const contentVersionKey = 'content_version';

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      if (syncContentOnOpen) {
        await syncContent();
        await _markContentSynced();
      }
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from < 3) {
        await _migrateToV3(m);
      }
    },
    beforeOpen: (details) async {
      // Drift does not enable foreign keys by default; the cascades declared
      // in tables.dart depend on this.
      await customStatement('PRAGMA foreign_keys = ON');

      await _createIndexes();

      if (!details.wasCreated && syncContentOnOpen) {
        await _syncContentIfOutdated();
      }
    },
  );

  /// Schema 2 -> 3: the daily journal, and a real home for custom-sin ids.
  ///
  /// Additive only: nothing is dropped, and the only rewrite moves custom-sin
  /// ids out of `note`.
  ///
  /// Every step must be idempotent. Drift stamps the new schema version only
  /// after `beforeOpen` (which re-syncs content) completes, so a kill during
  /// the first launch replays this migration. A repeated `addColumn` would
  /// throw on every open and leave the database unreachable.
  Future<void> _migrateToV3(Migrator m) async {
    // CREATE TABLE IF NOT EXISTS — safe to repeat.
    await m.createTable(journalEntries);
    await m.createTable(journalSinMarks);

    // ALTER TABLE ADD COLUMN has no IF NOT EXISTS, so guard it ourselves.
    if (!await _hasColumn('confession_items', 'custom_sin_id')) {
      await m.addColumn(confessionItems, confessionItems.customSinId);
    }

    // Move custom-sin ids stored in `note` into the dedicated column. Notes
    // that are not numeric are left alone; moved rows have a null note, so a
    // re-run is a no-op.
    await customStatement('''
      UPDATE confession_items
         SET custom_sin_id = CAST(note AS INTEGER),
             note = NULL
       WHERE is_custom = 1
         AND note IS NOT NULL
         AND CAST(note AS INTEGER) > 0
    ''');
  }

  Future<bool> _hasColumn(String table, String column) async {
    final rows = await customSelect('PRAGMA table_info($table)').get();
    return rows.any((row) => row.read<String>('name') == column);
  }

  /// SQLite does not index foreign-key columns automatically.
  ///
  /// `IF NOT EXISTS` and run on open, so it needs no schema bump.
  Future<void> _createIndexes() async {
    const statements = [
      'CREATE INDEX IF NOT EXISTS idx_confession_items_confession_id '
          'ON confession_items (confession_id)',
      'CREATE INDEX IF NOT EXISTS idx_penances_confession_id '
          'ON penances (confession_id)',
      'CREATE INDEX IF NOT EXISTS idx_examination_questions_commandment_id '
          'ON examination_questions (commandment_id)',
      'CREATE INDEX IF NOT EXISTS idx_examination_questions_language_code '
          'ON examination_questions (language_code)',
      'CREATE INDEX IF NOT EXISTS idx_journal_sin_marks_entry_id '
          'ON journal_sin_marks (entry_id)',
      // Every journal read is by day or by day range (calendar, streak).
      'CREATE INDEX IF NOT EXISTS idx_journal_entries_entry_date '
          'ON journal_entries (entry_date)',
    ];

    for (final statement in statements) {
      await customStatement(statement);
    }
  }

  /// Re-syncs bundled JSON content when it has changed since the last run.
  ///
  /// Independent of [schemaVersion], so content-only releases reach existing
  /// installs without a schema bump.
  Future<void> _syncContentIfOutdated() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getInt(contentVersionKey) == ContentConfig.version) return;

    await syncContent();
    await _markContentSynced();
  }

  Future<void> _markContentSynced() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(contentVersionKey, ContentConfig.version);
  }

  Future<void> syncContent() async {
    for (final lang in LanguageConfig.languageCodes) {
      await _syncLanguage(lang);
    }
  }

  /// Syncs one language's bundled content.
  ///
  /// One transaction per language, so a kill between deleting and re-inserting
  /// FAQs and quotes cannot leave the language empty. Writes are batched.
  Future<void> _syncLanguage(String lang) async {
    // Asset decoding is not a database operation; keep it out of the write
    // transaction where it would only hold the lock open longer.
    final commandmentsData = await DataLoader.loadCommandments(lang);
    final faqsData = await DataLoader.loadFaqs(lang);
    final quotesData = await DataLoader.loadQuotes(lang);

    await transaction(() async {
      // 1. Sync Commandments — upsert by code.
      final existingCommandments = await select(commandments).get();
      final commandmentsByCode = {
        for (final c in existingCommandments)
          if (c.code != null) c.code!: c,
      };

      await batch((batch) {
        for (final cmd in commandmentsData) {
          final codeValue = cmd.code.value;
          if (codeValue == null) continue; // Skip if code is null

          final existing = commandmentsByCode[codeValue];
          if (existing == null) {
            batch.insert(commandments, cmd);
          } else if (existing.content != cmd.content.value) {
            // Update content if changed
            batch.replace(
              commandments,
              existing.copyWith(
                content: cmd.content.value,
                customTitle: cmd.customTitle,
              ),
            );
          }
        }
      });

      // 2. Sync Questions
      // First, get all commandments to resolve codes
      final allCommandments = await select(commandments).get();
      final questionsData = await DataLoader.loadQuestions(
        lang,
        allCommandments,
      );

      final existingQuestions =
          await (select(examinationQuestions)
            ..where((t) => t.languageCode.equals(lang))).get();

      // Map existing questions by their stable string ID
      final existingMap = {for (var q in existingQuestions) q.id: q};

      final idsToKeep = <String>{};

      await batch((batch) {
        for (final q in questionsData) {
          final questionId = q.id.value;
          idsToKeep.add(questionId);

          final existing = existingMap[questionId];
          if (existing == null) {
            // Insert new question
            batch.insert(examinationQuestions, q);
          } else if (existing.question != q.question.value) {
            // Question exists - update text if changed
            batch.update(
              examinationQuestions,
              ExaminationQuestionsCompanion(question: q.question),
              where: (t) => t.id.equals(questionId),
            );
          }
        }
      });

      // Identify questions to delete (removed from JSON)
      final idsToDelete =
          existingQuestions
              .map((q) => q.id)
              .where((id) => !idsToKeep.contains(id))
              .toList();

      if (idsToDelete.isNotEmpty) {
        // Unlink from ConfessionItems first (set questionId to null)
        await (update(confessionItems)..where(
          (t) => t.questionId.isIn(idsToDelete),
        )).write(const ConfessionItemsCompanion(questionId: Value(null)));

        // Delete questions
        await (delete(examinationQuestions)
          ..where((t) => t.id.isIn(idsToDelete))).go();
      }

      // 3-4. Replace this language's FAQs and quotes.
      //
      // Prayers are not synced: the Prayers table is unused, as the prayers
      // screen reads its assets directly.
      await (delete(faqs)..where((t) => t.languageCode.equals(lang))).go();
      await (delete(quotes)..where((t) => t.languageCode.equals(lang))).go();

      await batch((batch) {
        batch.insertAll(faqs, faqsData);
        batch.insertAll(quotes, quotesData);
      });
    });
  }
}

