// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confession_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$confessionRepositoryHash() =>
    r'6e4fb53c1263d4687377ad3d18d6f403a2de1aa7';

/// See also [confessionRepository].
@ProviderFor(confessionRepository)
final confessionRepositoryProvider =
    AutoDisposeProvider<ConfessionRepository>.internal(
      confessionRepository,
      name: r'confessionRepositoryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$confessionRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConfessionRepositoryRef = AutoDisposeProviderRef<ConfessionRepository>;
String _$lastFinishedConfessionHash() =>
    r'962d46c83e1b95197a5de5acbfbac88d9891fe97';

/// The most recent finished confession, or null.
///
/// A Drift stream: it re-emits whenever the confessions table changes, so no
/// call site has to remember to invalidate it after finishing or deleting a
/// confession.
///
/// Copied from [lastFinishedConfession].
@ProviderFor(lastFinishedConfession)
final lastFinishedConfessionProvider =
    AutoDisposeStreamProvider<Confession?>.internal(
      lastFinishedConfession,
      name: r'lastFinishedConfessionProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$lastFinishedConfessionHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LastFinishedConfessionRef = AutoDisposeStreamProviderRef<Confession?>;
String _$activeExaminationDraftHash() =>
    r'0cfa2bbae108af7f477abf96d225d8388a0d5a9b';

/// The unfinished confession currently being examined, if it has any items.
///
/// Copied from [activeExaminationDraft].
@ProviderFor(activeExaminationDraft)
final activeExaminationDraftProvider =
    AutoDisposeStreamProvider<ActiveExaminationDraft?>.internal(
      activeExaminationDraft,
      name: r'activeExaminationDraftProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$activeExaminationDraftHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActiveExaminationDraftRef =
    AutoDisposeStreamProviderRef<ActiveExaminationDraft?>;
String _$activeConfessionHash() => r'31180832abde34f94bafad27fdad009c07c6538f';

/// The unfinished confession (with its items) shown on the confess screen.
///
/// Copied from [activeConfession].
@ProviderFor(activeConfession)
final activeConfessionProvider =
    AutoDisposeStreamProvider<ConfessionWithItems?>.internal(
      activeConfession,
      name: r'activeConfessionProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$activeConfessionHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActiveConfessionRef =
    AutoDisposeStreamProviderRef<ConfessionWithItems?>;
String _$finishedConfessionsHash() =>
    r'90d9a0e4d8dffcf92f5c51c75b94da9a2c5c19e4';

/// All finished confessions that still have items, newest first.
///
/// Copied from [finishedConfessions].
@ProviderFor(finishedConfessions)
final finishedConfessionsProvider =
    AutoDisposeStreamProvider<List<ConfessionWithItems>>.internal(
      finishedConfessions,
      name: r'finishedConfessionsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$finishedConfessionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FinishedConfessionsRef =
    AutoDisposeStreamProviderRef<List<ConfessionWithItems>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
