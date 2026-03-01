import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_custom_sins_repository.g.dart';

/// Repository for managing user custom sins
class UserCustomSinsRepository {
  final AppDatabase _db;

  UserCustomSinsRepository(this._db);

  /// Get all custom sins ordered by creation date
  Future<List<UserCustomSin>> _getAllCustomSins() async {
    return await (_db.select(_db.userCustomSins)
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).get();
  }

  /// Insert a new custom sin
  Future<int> insertCustomSin(UserCustomSinsCompanion sin) async {
    return await _db.into(_db.userCustomSins).insert(sin);
  }

  /// Update an existing custom sin
  Future<void> updateCustomSin(int id, UserCustomSinsCompanion sin) async {
    await (_db.update(_db.userCustomSins)..where(
      (t) => t.id.equals(id),
    )).write(sin.copyWith(updatedAt: Value(DateTime.now())));
  }

  /// Delete a custom sin
  Future<void> deleteCustomSin(int id) async {
    await (_db.delete(_db.userCustomSins)..where((t) => t.id.equals(id))).go();
  }

  /// Get custom sin by ID
  Future<UserCustomSin?> getCustomSinById(int id) async {
    return await (_db.select(_db.userCustomSins)
      ..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  /// Group custom sins by commandment code
  Future<Map<String?, List<UserCustomSin>>>
  getCustomSinsGroupedByCommandment() async {
    final allSins = await _getAllCustomSins();
    final Map<String?, List<UserCustomSin>> grouped = {};

    for (final sin in allSins) {
      if (!grouped.containsKey(sin.commandmentCode)) {
        grouped[sin.commandmentCode] = [];
      }
      grouped[sin.commandmentCode]!.add(sin);
    }

    return grouped;
  }
}

@riverpod
UserCustomSinsRepository userCustomSinsRepository(Ref ref) {
  return UserCustomSinsRepository(ref.watch(appDatabaseProvider));
}
