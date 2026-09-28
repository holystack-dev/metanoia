// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anniversary_nudge_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$anniversaryNudgeHash() => r'a8bcdae0fabdd358b50ca13814ffb67c32965bd8';

/// The anniversary invitation to show, or `null` for silence.
///
/// Derived from the user's own confession history: see
/// [evaluateAnniversaryNudge] for the rules.
///
/// Copied from [anniversaryNudge].
@ProviderFor(anniversaryNudge)
final anniversaryNudgeProvider =
    AutoDisposeProvider<AnniversaryNudge?>.internal(
      anniversaryNudge,
      name: r'anniversaryNudgeProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$anniversaryNudgeHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AnniversaryNudgeRef = AutoDisposeProviderRef<AnniversaryNudge?>;
String _$anniversaryDismissalHash() =>
    r'7cb16485972c68914ab52ce20558303bbb72dfc9';

/// The day the anniversary prompt was last dismissed, if ever.
///
/// Copied from [AnniversaryDismissal].
@ProviderFor(AnniversaryDismissal)
final anniversaryDismissalProvider =
    AutoDisposeNotifierProvider<AnniversaryDismissal, int?>.internal(
      AnniversaryDismissal.new,
      name: r'anniversaryDismissalProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$anniversaryDismissalHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AnniversaryDismissal = AutoDisposeNotifier<int?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
