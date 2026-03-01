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

/// Provider for pending (incomplete) penances
@riverpod
Future<List<PenanceWithConfession>> pendingPenances(Ref ref) async {
  final repo = ref.watch(penanceRepositoryProvider);
  return repo.getPendingPenances();
}

/// Provider for penance by confession ID
@riverpod
Future<Penance?> penanceForConfession(Ref ref, int confessionId) async {
  final repo = ref.watch(penanceRepositoryProvider);
  return repo.getPenanceForConfession(confessionId);
}

class PenanceRepository {
  final AppDatabase _db;

  PenanceRepository(this._db);

  /// Add a penance for a confession
  Future<int> addPenance(int confessionId, String description) async {
    return _db.into(_db.penances).insert(
          PenancesCompanion.insert(
            confessionId: confessionId,
            description: description,
          ),
        );
  }

  /// Get penance for a specific confession
  Future<Penance?> getPenanceForConfession(int confessionId) async {
    return (_db.select(_db.penances)
          ..where((t) => t.confessionId.equals(confessionId)))
        .getSingleOrNull();
  }

  /// Get all pending (incomplete) penances
  Future<List<PenanceWithConfession>> getPendingPenances() async {
    final query = _db.select(_db.penances).join([
      innerJoin(
        _db.confessions,
        _db.confessions.id.equalsExp(_db.penances.confessionId),
      ),
    ])
      ..where(_db.penances.isCompleted.equals(false))
      ..orderBy([OrderingTerm.desc(_db.penances.createdAt)]);

    final results = await query.get();
    return results.map((row) {
      return PenanceWithConfession(
        penance: row.readTable(_db.penances),
        confession: row.readTable(_db.confessions),
      );
    }).toList();
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
