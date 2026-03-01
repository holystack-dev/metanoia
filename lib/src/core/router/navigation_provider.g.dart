// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentTabIndexHash() => r'eda73bfbb2aac61b9765b0957a2adaaba95015ae';

/// Provider to track the current navigation tab index.
/// This is used to notify widgets when the user switches tabs,
/// allowing them to refresh their data.
///
/// Copied from [CurrentTabIndex].
@ProviderFor(CurrentTabIndex)
final currentTabIndexProvider = NotifierProvider<CurrentTabIndex, int>.internal(
  CurrentTabIndex.new,
  name: r'currentTabIndexProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$currentTabIndexHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentTabIndex = Notifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
