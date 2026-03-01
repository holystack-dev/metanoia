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
String _$pendingPenancesHash() => r'bce24910dce9e2e4fc2f6ac70e5b1edc29ad0675';

/// Provider for pending (incomplete) penances
///
/// Copied from [pendingPenances].
@ProviderFor(pendingPenances)
final pendingPenancesProvider =
    AutoDisposeFutureProvider<List<PenanceWithConfession>>.internal(
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
    AutoDisposeFutureProviderRef<List<PenanceWithConfession>>;
String _$penanceForConfessionHash() =>
    r'56209a6bd827ddf6b76c61c1739ec9d5367cf05a';

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
class PenanceForConfessionProvider extends AutoDisposeFutureProvider<Penance?> {
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
    FutureOr<Penance?> Function(PenanceForConfessionRef provider) create,
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
  AutoDisposeFutureProviderElement<Penance?> createElement() {
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
mixin PenanceForConfessionRef on AutoDisposeFutureProviderRef<Penance?> {
  /// The parameter `confessionId` of this provider.
  int get confessionId;
}

class _PenanceForConfessionProviderElement
    extends AutoDisposeFutureProviderElement<Penance?>
    with PenanceForConfessionRef {
  _PenanceForConfessionProviderElement(super.provider);

  @override
  int get confessionId => (origin as PenanceForConfessionProvider).confessionId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
