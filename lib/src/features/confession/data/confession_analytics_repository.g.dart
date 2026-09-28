// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confession_analytics_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$confessionAnalyticsRepositoryHash() =>
    r'3d361f5e3031bf0d13c34040ec22446fcc892c50';

/// See also [confessionAnalyticsRepository].
@ProviderFor(confessionAnalyticsRepository)
final confessionAnalyticsRepositoryProvider =
    AutoDisposeProvider<ConfessionAnalyticsRepository>.internal(
      confessionAnalyticsRepository,
      name: r'confessionAnalyticsRepositoryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$confessionAnalyticsRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConfessionAnalyticsRepositoryRef =
    AutoDisposeProviderRef<ConfessionAnalyticsRepository>;
String _$confessionAnalyticsHash() =>
    r'6b5913d16b86f1244977ccac1562b2f43eaebaff';

/// Provider for confession analytics data.
///
/// A Drift stream: it recomputes whenever a confession or one of its items
/// changes, so Insights and the home stats can never drift out of sync with
/// the history screen.
///
/// Copied from [confessionAnalytics].
@ProviderFor(confessionAnalytics)
final confessionAnalyticsProvider =
    AutoDisposeStreamProvider<ConfessionAnalytics>.internal(
      confessionAnalytics,
      name: r'confessionAnalyticsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$confessionAnalyticsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConfessionAnalyticsRef =
    AutoDisposeStreamProviderRef<ConfessionAnalytics>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
