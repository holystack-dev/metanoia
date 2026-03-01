import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'dart:math';

import 'tables.dart';

import 'data_loader.dart';
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
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      await syncContent();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      // Future migrations go here
      await syncContent();
    },
  );
  Future<void> syncContent() async {
    final languages = LanguageConfig.languageCodes;

    for (final lang in languages) {
      // 1. Sync Commandments
      final commandmentsData = await DataLoader.loadCommandments(lang);

      // Upsert commandments by code (check existence, then insert or update)
      for (final cmd in commandmentsData) {
        final codeValue = cmd.code.value;
        if (codeValue == null) continue; // Skip if code is null

        final existing =
            await (select(commandments)
              ..where((t) => t.code.equals(codeValue))).getSingleOrNull();

        if (existing != null) {
          // Update content if changed
          if (existing.content != cmd.content.value) {
            await update(commandments).replace(
              existing.copyWith(
                content: cmd.content.value,
                customTitle: cmd.customTitle,
              ),
            );
          }
        } else {
          // Insert new
          await into(commandments).insert(cmd);
        }
      }

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

      for (final q in questionsData) {
        final questionId = q.id.value;
        if (existingMap.containsKey(questionId)) {
          // Question exists - update text if changed
          final existing = existingMap[questionId]!;
          if (existing.question != q.question.value) {
            await (update(examinationQuestions)
              ..where((t) => t.id.equals(questionId))).write(
              ExaminationQuestionsCompanion(question: q.question),
            );
          }
          idsToKeep.add(questionId);
        } else {
          // Insert new question
          await into(examinationQuestions).insert(q);
          idsToKeep.add(questionId);
        }
      }

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

      // 3. Sync FAQs
      final faqsData = await DataLoader.loadFaqs(lang);
      await (delete(faqs)..where((t) => t.languageCode.equals(lang))).go();
      await batch((batch) {
        batch.insertAll(faqs, faqsData);
      });

      // 4. Sync Quotes
      final quotesData = await DataLoader.loadQuotes(lang);
      await (delete(quotes)..where((t) => t.languageCode.equals(lang))).go();
      await batch((batch) {
        batch.insertAll(quotes, quotesData);
      });

      // 5. Sync Prayers
      final prayersData = await DataLoader.loadPrayers(lang);
      await (delete(prayers)..where((t) => t.languageCode.equals(lang))).go();
      await batch((batch) {
        batch.insertAll(prayers, prayersData);
      });
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'confession_app.sqlite'));

    // Encryption setup
    // Use encryptedSharedPreferences on Android for better stability
    const secureStorage = FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );

    String? encryptionKey;
    try {
      encryptionKey = await secureStorage.read(key: 'db_key');
    } catch (e) {
      // If reading fails (e.g. key store issues), reset storage
      await secureStorage.deleteAll();
    }

    if (encryptionKey == null) {
      // Generate a new key
      final keyBytes = List<int>.generate(
        32,
        (_) => Random.secure().nextInt(256),
      );
      encryptionKey = base64Encode(keyBytes);
      await secureStorage.write(key: 'db_key', value: encryptionKey);
    }

    return NativeDatabase.createInBackground(
      file,
      setup: (database) {
        database.execute("PRAGMA key = '$encryptionKey';");
      },
    );
  });
}
