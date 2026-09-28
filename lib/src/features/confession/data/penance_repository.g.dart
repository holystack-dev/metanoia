// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'penance_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$penanceRepositoryHash() => r'd8589fe7f0d64a68c60ecadf0a919f391305583a';

/// See also [penanceRepository].
@ProviderFor(penanceRepository)
final penanceRepositoryProvider =
    AutoDisposeProvider<PenanceRepository>.internal(
      penanceRepository,
      name: r'penanceRepositoryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$penanceRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PenanceRepositoryRef = AutoDisposeProviderRef<PenanceRepository>;
String _$pendingPenancesHash() => r'3fc9c2b37058a0f8d90999307856e394e7ac3973';

/// Provider for pending (incomplete) penances.
///
/// A Drift stream: completing, editing or deleting a penance — or deleting the
/// confession it belongs to — re-emits here on its own.
///
/// Copied from [pendingPenances].
@ProviderFor(pendingPenances)
final pendingPenancesProvider =
    AutoDisposeStreamProvider<List<PenanceWithConfession>>.internal(
      pendingPenances,
      name: r'pendingPenancesProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$pendingPenancesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PendingPenancesRef =
    AutoDisposeStreamProviderRef<List<PenanceWithConfession>>;
String _$penanceForConfessionHash() =>
    r'd2b93f1a545fa969e38a02a4b7b8f72957620d53';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Provider for penance by confession ID
///
/// Copied from [penanceForConfession].
@ProviderFor(penanceForConfession)
const penanceForConfessionProvider = PenanceForConfessionFamily();

/// Provider for penance by confession ID
///
/// Copied from [penanceForConfession].
class PenanceForConfessionFamily extends Family<AsyncValue<Penance?>> {
  /// Provider for penance by confession ID
  ///
  /// Copied from [penanceForConfession].
  const PenanceForConfessionFamily();

  /// Provider for penance by confession ID
  ///
  /// Copied from [penanceForConfession].
  PenanceForConfessionProvider call(int confessionId) {
    return PenanceForConfessionProvider(confessionId);
  }

  @override
  PenanceForConfessionProvider getProviderOverride(
    covariant PenanceForConfessionProvider provider,
  ) {
    return call(provider.confessionId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'penanceForConfessionProvider';
}

/// Provider for penance by confession ID
///
/// Copied from [penanceForConfession].
class PenanceForConfessionProvider extends AutoDisposeStreamProvider<Penance?> {
  /// Provider for penance by confession ID
  ///
  /// Copied from [penanceForConfession].
  PenanceForConfessionProvider(int confessionId)
    : this._internal(
        (ref) =>
            penanceForConfession(ref as PenanceForConfessionRef, confessionId),
        from: penanceForConfessionProvider,
        name: r'penanceForConfessionProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$penanceForConfessionHash,
        dependencies: PenanceForConfessionFamily._dependencies,
        allTransitiveDependencies:
            PenanceForConfessionFamily._allTransitiveDependencies,
        confessionId: confessionId,
      );

  PenanceForConfessionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.confessionId,
  }) : super.internal();

  final int confessionId;

  @override
  Override overrideWith(
    Stream<Penance?> Function(PenanceForConfessionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PenanceForConfessionProvider._internal(
        (ref) => create(ref as PenanceForConfessionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        confessionId: confessionId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Penance?> createElement() {
    return _PenanceForConfessionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PenanceForConfessionProvider &&
        other.confessionId == confessionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, confessionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PenanceForConfessionRef on AutoDisposeStreamProviderRef<Penance?> {
  /// The parameter `confessionId` of this provider.
  int get confessionId;
}

class _PenanceForConfessionProviderElement
    extends AutoDisposeStreamProviderElement<Penance?>
    with PenanceForConfessionRef {
  _PenanceForConfessionProviderElement(super.provider);

  @override
  int get confessionId => (origin as PenanceForConfessionProvider).confessionId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
