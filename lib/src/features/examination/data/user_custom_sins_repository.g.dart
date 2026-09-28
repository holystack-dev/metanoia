// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_custom_sins_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userCustomSinsRepositoryHash() =>
    r'96b9f219cf6cdfa5cac5923c98d97b41ac3c0b5b';

/// See also [userCustomSinsRepository].
@ProviderFor(userCustomSinsRepository)
final userCustomSinsRepositoryProvider =
    AutoDisposeProvider<UserCustomSinsRepository>.internal(
      userCustomSinsRepository,
      name: r'userCustomSinsRepositoryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$userCustomSinsRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserCustomSinsRepositoryRef =
    AutoDisposeProviderRef<UserCustomSinsRepository>;
String _$customSinsGroupedHash() => r'f6fc393b62dc3ff90c96dea86cd948ad743bd7ea';

/// User custom sins, grouped by their (raw) commandment code.
///
/// A Drift stream: adding, editing or deleting a custom sin re-emits here, and
/// through [examinationData] reaches the examination screen, without anyone
/// having to invalidate a provider.
///
/// Copied from [customSinsGrouped].
@ProviderFor(customSinsGrouped)
final customSinsGroupedProvider =
    AutoDisposeStreamProvider<Map<String?, List<UserCustomSin>>>.internal(
      customSinsGrouped,
      name: r'customSinsGroupedProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$customSinsGroupedHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CustomSinsGroupedRef =
    AutoDisposeStreamProviderRef<Map<String?, List<UserCustomSin>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
