import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'database_provider.g.dart';

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase();
  // Close with the provider so a rebuilt scope (AppRoot.restarterOf) does not
  // leak the connection. Tolerates a second close: delete-all closes the
  // database itself before the scope is disposed.
  ref.onDispose(() async {
    try {
      await db.close();
    } catch (_) {
      // Already closed.
    }
  });
  return db;
}
