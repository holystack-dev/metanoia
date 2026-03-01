import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'package_info_service.g.dart';

/// Provider for package info (version, build number, etc.)
/// Reads directly from pubspec.yaml at runtime
@riverpod
Future<PackageInfo> packageInfo(Ref ref) async {
  return await PackageInfo.fromPlatform();
}
