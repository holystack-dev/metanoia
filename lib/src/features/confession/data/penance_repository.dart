import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'penance_repository.g.dart';

@riverpod
PenanceRepository penanceRepository(Ref ref) {
  return PenanceRepository(ref.watch(appDatabaseProvider));
}

/// Provider for pending (incomplete) penances.
///
/// A Drift stream: completing, editing or deleting a penance — or deleting the
/// confession it belongs to — re-emits here on its own.
@riverpod
Stream<List<PenanceWithConfession>> pendingPenances(Ref ref) {
  return ref.watch(penanceRepositoryProvider).watchPendingPenances();
}

/// Provider for penance by confession ID
@riverpod
Stream<Penance?> penanceForConfession(Ref ref, int confessionId) {
  return ref.watch(penanceRepositoryProvider).watchPenanceForConfession(
        confessionId,
      );
}

class PenanceRepository {
  final AppDatabase _db;

  PenanceRepository(this._db);

  /// Record the penance a confession was given.
  ///
  /// An upsert: a confession has exactly one penance, and both the
  /// finish-confession sheet and confession-day mode may record it.
  Future<int> addPenance(int confessionId, String description) async {
    return _db.transaction(() async {
      final existing = await getPenanceForConfession(confessionId);
      if (existing != null) {
        await updatePenance(existing.id, description);
        return existing.id;
      }

      return _db
          .into(_db.penances)
          .insert(
            PenancesCompanion.insert(
              confessionId: confessionId,
              description: description,
            ),
          );
    });
  }

  /// The confession's penance, tolerating more than one row.
  ///
  /// Takes the first row: `getSingleOrNull` would throw on a duplicate and leave
  /// the screen unable to load.
  SimpleSelectStatement<$PenancesTable, Penance> _penanceForConfessionQuery(
    int confessionId,
  ) {
    return _db.select(_db.penances)
      ..where((t) => t.confessionId.equals(confessionId))
      ..orderBy([(t) => OrderingTerm.asc(t.id)])
      ..limit(1);
  }

  /// Get penance for a specific confession
  Future<Penance?> getPenanceForConfession(int confessionId) {
    return _penanceForConfessionQuery(confessionId).getSingleOrNull();
  }

  /// Watch the penance of a specific confession
  Stream<Penance?> watchPenanceForConfession(int confessionId) {
    return _penanceForConfessionQuery(confessionId).watchSingleOrNull();
  }

  JoinedSelectStatement _pendingPenancesQuery() {
    return _db.select(_db.penances).join([
      innerJoin(
        _db.confessions,
        _db.confessions.id.equalsExp(_db.penances.confessionId),
      ),
    ])
      ..where(_db.penances.isCompleted.equals(false))
      ..orderBy([OrderingTerm.desc(_db.penances.createdAt)]);
  }

  List<PenanceWithConfession> _mapPending(List<TypedResult> rows) {
    return rows
        .map(
          (row) => PenanceWithConfession(
            penance: row.readTable(_db.penances),
            confession: row.readTable(_db.confessions),
          ),
        )
        .toList();
  }

  /// Get all pending (incomplete) penances
  Future<List<PenanceWithConfession>> getPendingPenances() async {
    return _mapPending(await _pendingPenancesQuery().get());
  }

  /// Watch all pending (incomplete) penances
  Stream<List<PenanceWithConfession>> watchPendingPenances() {
    return _pendingPenancesQuery().watch().map(_mapPending);
  }

  /// Mark a penance as completed
  Future<void> completePenance(int penanceId) async {
    await (_db.update(_db.penances)..where((t) => t.id.equals(penanceId)))
        .write(
      PenancesCompanion(
        isCompleted: const Value(true),
        completedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Update penance description
  Future<void> updatePenance(int penanceId, String description) async {
    await (_db.update(_db.penances)..where((t) => t.id.equals(penanceId)))
        .write(PenancesCompanion(description: Value(description)));
  }

  /// Delete a penance
  Future<void> deletePenance(int penanceId) async {
    await (_db.delete(_db.penances)..where((t) => t.id.equals(penanceId))).go();
  }
}

class PenanceWithConfession {
  final Penance penance;
  final Confession confession;

  PenanceWithConfession({required this.penance, required this.confession});
}
