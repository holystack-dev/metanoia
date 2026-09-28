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

  SimpleSelectStatement<$UserCustomSinsTable, UserCustomSin>
      _allCustomSinsQuery() {
    return _db.select(_db.userCustomSins)
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
  }

  /// Get all custom sins ordered by creation date
  Future<List<UserCustomSin>> _getAllCustomSins() {
    return _allCustomSinsQuery().get();
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
    return _groupByCommandment(await _getAllCustomSins());
  }

  /// Watch custom sins grouped by commandment code
  Stream<Map<String?, List<UserCustomSin>>>
  watchCustomSinsGroupedByCommandment() {
    return _allCustomSinsQuery().watch().map(_groupByCommandment);
  }

  Map<String?, List<UserCustomSin>> _groupByCommandment(
    List<UserCustomSin> allSins,
  ) {
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

/// User custom sins, grouped by their (raw) commandment code.
///
/// A Drift stream, so changes reach [examinationData] without invalidation.
@riverpod
Stream<Map<String?, List<UserCustomSin>>> customSinsGrouped(Ref ref) {
  return ref
      .watch(userCustomSinsRepositoryProvider)
      .watchCustomSinsGroupedByCommandment();
}
