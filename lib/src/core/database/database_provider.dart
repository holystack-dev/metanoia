import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'database_provider.g.dart';

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  return AppDatabase();
}
