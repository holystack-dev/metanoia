// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'liturgical_prompt_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$liturgicalPromptHash() => r'69f9d11a7d959ab316122549e9ac92a3d8e0a7fa';

/// The one liturgical invitation to show today, or `null` for silence.
///
/// Copied from [liturgicalPrompt].
@ProviderFor(liturgicalPrompt)
final liturgicalPromptProvider =
    AutoDisposeProvider<LiturgicalPrompt?>.internal(
      liturgicalPrompt,
      name: r'liturgicalPromptProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$liturgicalPromptHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LiturgicalPromptRef = AutoDisposeProviderRef<LiturgicalPrompt?>;
String _$liturgicalDismissalsHash() =>
    r'b5893de18f745a7a03396f5d94f8dc10705687e6';

/// The liturgical prompts the user has waved away.
///
/// Persisted as year-scoped keys ("season:lent:2026"), so a dismissal is
/// permanent for that season or feast and silent about the next one.
///
/// Copied from [LiturgicalDismissals].
@ProviderFor(LiturgicalDismissals)
final liturgicalDismissalsProvider =
    AutoDisposeNotifierProvider<LiturgicalDismissals, Set<String>>.internal(
      LiturgicalDismissals.new,
      name: r'liturgicalDismissalsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$liturgicalDismissalsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$LiturgicalDismissals = AutoDisposeNotifier<Set<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
