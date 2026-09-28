// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spread_the_word_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$spreadTheWordHash() => r'c02646589279ba758467f0883645807158cbc602';

/// Which "spread the word" invitation the home screen shows.
///
/// Backed by [SharedPreferences] rather than a Drift stream, so — unlike the
/// rest of the home screen — it does not re-emit on its own. The card invalidates
/// this provider after the user shares, rates or dismisses, which is the one
/// legitimate place a manual `ref.invalidate` belongs here: prefs are not a
/// reactive source, and nothing else on the screen depends on this state.
///
/// Copied from [spreadTheWord].
@ProviderFor(spreadTheWord)
final spreadTheWordProvider =
    AutoDisposeFutureProvider<SpreadTheWordKind>.internal(
      spreadTheWord,
      name: r'spreadTheWordProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$spreadTheWordHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SpreadTheWordRef = AutoDisposeFutureProviderRef<SpreadTheWordKind>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
