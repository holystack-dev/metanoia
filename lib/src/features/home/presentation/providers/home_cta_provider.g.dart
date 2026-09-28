// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_cta_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$homeCtaHash() => r'cd82f89fc8cb88862384b1ff0b425bc8607bac39';

/// The one call to action the home screen shows.
///
/// Composed from the existing Drift streams, so it stays current on its own —
/// selecting a sin, finishing a confession or completing a penance re-emits
/// here with no invalidation anywhere. The precedence itself lives in
/// [resolveHomeCta], as a pure function, so it can be tested without a widget.
///
/// While the streams are still loading, the invitation to begin is the safe
/// answer: it is what a first-time user (the common case) will see anyway, and
/// it never sends anyone to a screen that has nothing on it.
///
/// Copied from [homeCta].
@ProviderFor(homeCta)
final homeCtaProvider = AutoDisposeProvider<HomeCta>.internal(
  homeCta,
  name: r'homeCtaProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$homeCtaHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HomeCtaRef = AutoDisposeProviderRef<HomeCta>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
