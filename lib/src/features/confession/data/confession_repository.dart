import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'confession_repository.g.dart';

@riverpod
ConfessionRepository confessionRepository(Ref ref) {
  return ConfessionRepository(ref.watch(appDatabaseProvider));
}

@riverpod
Future<Confession?> lastFinishedConfession(Ref ref) async {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.confessions)
        ..where((tbl) => tbl.isFinished.equals(true))
        ..orderBy([
          (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
        ])
        ..limit(1))
      .getSingleOrNull();
}

/// Represents an active (unfinished) examination draft
class ActiveExaminationDraft {
  final Confession confession;
  final int itemCount;

  ActiveExaminationDraft({
    required this.confession,
    required this.itemCount,
  });
}

@riverpod
Future<ActiveExaminationDraft?> activeExaminationDraft(Ref ref) async {
  final db = ref.watch(appDatabaseProvider);

  // Find unfinished confession (draft)
  final draft = await (db.select(db.confessions)
        ..where((tbl) => tbl.isFinished.equals(false))
        ..orderBy([
          (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
        ])
        ..limit(1))
      .getSingleOrNull();

  if (draft == null) return null;

  // Count items in this draft
  final itemCount = await (db.selectOnly(db.confessionItems)
        ..addColumns([db.confessionItems.id.count()])
        ..where(db.confessionItems.confessionId.equals(draft.id)))
      .map((row) => row.read(db.confessionItems.id.count()) ?? 0)
      .getSingle();

  if (itemCount == 0) return null;

  return ActiveExaminationDraft(
    confession: draft,
    itemCount: itemCount,
  );
}

@riverpod
Future<List<ConfessionWithItems>> finishedConfessions(Ref ref) async {
  final repo = ref.watch(confessionRepositoryProvider);
  return repo.getFinishedConfessions();
}

class ConfessionRepository {
  final AppDatabase _db;

  ConfessionRepository(this._db);

  /// Get all finished confessions ordered by date (newest first)
  Future<List<ConfessionWithItems>> getFinishedConfessions() async {
    final confessions =
        await (_db.select(_db.confessions)
              ..where((tbl) => tbl.isFinished.equals(true))
              ..orderBy([
                (t) =>
                    OrderingTerm(expression: t.date, mode: OrderingMode.desc),
              ]))
            .get();

    final result = <ConfessionWithItems>[];
    for (final confession in confessions) {
      final items =
          await (_db.select(_db.confessionItems)
            ..where((tbl) => tbl.confessionId.equals(confession.id))).get();

      // Only add confessions that have items (skip empty ones)
      if (items.isNotEmpty) {
        result.add(ConfessionWithItems(confession, items));
      }
    }

    return result;
  }

  /// Delete a specific confession and all its items
  Future<void> deleteConfession(int confessionId) async {
    await _db.transaction(() async {
      // Delete all items first
      await (_db.delete(_db.confessionItems)
        ..where((tbl) => tbl.confessionId.equals(confessionId))).go();

      // Delete the confession
      await (_db.delete(_db.confessions)
        ..where((tbl) => tbl.id.equals(confessionId))).go();
    });
  }

  /// Delete all finished confessions and their items
  Future<void> deleteAllFinishedConfessions() async {
    await _db.transaction(() async {
      // Get all finished confession IDs
      final finishedIds =
          await (_db.select(_db.confessions)..where(
            (tbl) => tbl.isFinished.equals(true),
          )).map((c) => c.id).get();

      // Delete all items for finished confessions
      for (final id in finishedIds) {
        await (_db.delete(_db.confessionItems)
          ..where((tbl) => tbl.confessionId.equals(id))).go();
      }

      // Delete all finished confessions
      await (_db.delete(_db.confessions)
        ..where((tbl) => tbl.isFinished.equals(true))).go();
    });
  }

  /// Mark a confession as finished
  Future<void> markConfessionAsFinished(
    int confessionId, {
    bool keepHistory = true,
  }) async {
    await _db.transaction(() async {
      if (!keepHistory) {
        // Delete items if history is not kept
        await (_db.delete(_db.confessionItems)
          ..where((tbl) => tbl.confessionId.equals(confessionId))).go();
      }

      await (_db.update(_db.confessions)
        ..where((tbl) => tbl.id.equals(confessionId))).write(
        ConfessionsCompanion(
          isFinished: const Value(true),
          finishedAt: Value(DateTime.now()),
        ),
      );
    });
  }

  /// Update the date of a confession
  Future<void> updateConfessionDate(int confessionId, DateTime newDate) async {
    await (_db.update(_db.confessions)
      ..where((tbl) => tbl.id.equals(confessionId))).write(
      ConfessionsCompanion(date: Value(newDate)),
    );
  }
}

class ConfessionWithItems {
  final Confession confession;
  final List<ConfessionItem> items;

  ConfessionWithItems(this.confession, this.items);
}
