// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$journalRepositoryHash() => r'e85ad4c2274e5d48d078d07b53810419e523f8d1';

/// See also [journalRepository].
@ProviderFor(journalRepository)
final journalRepositoryProvider =
    AutoDisposeProvider<JournalRepository>.internal(
      journalRepository,
      name: r'journalRepositoryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$journalRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef JournalRepositoryRef = AutoDisposeProviderRef<JournalRepository>;
String _$journalDayHash() => r'6a594340c5b6124af47b6f1e85df8505a6cb4bf2';

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

/// The entry for a given day, or null if the user has not written one.
///
/// Copied from [journalDay].
@ProviderFor(journalDay)
const journalDayProvider = JournalDayFamily();

/// The entry for a given day, or null if the user has not written one.
///
/// Copied from [journalDay].
class JournalDayFamily extends Family<AsyncValue<JournalDay?>> {
  /// The entry for a given day, or null if the user has not written one.
  ///
  /// Copied from [journalDay].
  const JournalDayFamily();

  /// The entry for a given day, or null if the user has not written one.
  ///
  /// Copied from [journalDay].
  JournalDayProvider call(DateTime day) {
    return JournalDayProvider(day);
  }

  @override
  JournalDayProvider getProviderOverride(
    covariant JournalDayProvider provider,
  ) {
    return call(provider.day);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'journalDayProvider';
}

/// The entry for a given day, or null if the user has not written one.
///
/// Copied from [journalDay].
class JournalDayProvider extends AutoDisposeStreamProvider<JournalDay?> {
  /// The entry for a given day, or null if the user has not written one.
  ///
  /// Copied from [journalDay].
  JournalDayProvider(DateTime day)
    : this._internal(
        (ref) => journalDay(ref as JournalDayRef, day),
        from: journalDayProvider,
        name: r'journalDayProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$journalDayHash,
        dependencies: JournalDayFamily._dependencies,
        allTransitiveDependencies: JournalDayFamily._allTransitiveDependencies,
        day: day,
      );

  JournalDayProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.day,
  }) : super.internal();

  final DateTime day;

  @override
  Override overrideWith(
    Stream<JournalDay?> Function(JournalDayRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: JournalDayProvider._internal(
        (ref) => create(ref as JournalDayRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        day: day,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<JournalDay?> createElement() {
    return _JournalDayProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is JournalDayProvider && other.day == day;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, day.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin JournalDayRef on AutoDisposeStreamProviderRef<JournalDay?> {
  /// The parameter `day` of this provider.
  DateTime get day;
}

class _JournalDayProviderElement
    extends AutoDisposeStreamProviderElement<JournalDay?>
    with JournalDayRef {
  _JournalDayProviderElement(super.provider);

  @override
  DateTime get day => (origin as JournalDayProvider).day;
}

String _$journalMonthHash() => r'7d78f00c41100deef4f3b2eb8ba925a1bbec7092';

/// Every entry in the given month, keyed by day, for the calendar.
///
/// Copied from [journalMonth].
@ProviderFor(journalMonth)
const journalMonthProvider = JournalMonthFamily();

/// Every entry in the given month, keyed by day, for the calendar.
///
/// Copied from [journalMonth].
class JournalMonthFamily extends Family<AsyncValue<Map<DateTime, JournalDay>>> {
  /// Every entry in the given month, keyed by day, for the calendar.
  ///
  /// Copied from [journalMonth].
  const JournalMonthFamily();

  /// Every entry in the given month, keyed by day, for the calendar.
  ///
  /// Copied from [journalMonth].
  JournalMonthProvider call(DateTime month) {
    return JournalMonthProvider(month);
  }

  @override
  JournalMonthProvider getProviderOverride(
    covariant JournalMonthProvider provider,
  ) {
    return call(provider.month);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'journalMonthProvider';
}

/// Every entry in the given month, keyed by day, for the calendar.
///
/// Copied from [journalMonth].
class JournalMonthProvider
    extends AutoDisposeStreamProvider<Map<DateTime, JournalDay>> {
  /// Every entry in the given month, keyed by day, for the calendar.
  ///
  /// Copied from [journalMonth].
  JournalMonthProvider(DateTime month)
    : this._internal(
        (ref) => journalMonth(ref as JournalMonthRef, month),
        from: journalMonthProvider,
        name: r'journalMonthProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$journalMonthHash,
        dependencies: JournalMonthFamily._dependencies,
        allTransitiveDependencies:
            JournalMonthFamily._allTransitiveDependencies,
        month: month,
      );

  JournalMonthProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.month,
  }) : super.internal();

  final DateTime month;

  @override
  Override overrideWith(
    Stream<Map<DateTime, JournalDay>> Function(JournalMonthRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: JournalMonthProvider._internal(
        (ref) => create(ref as JournalMonthRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        month: month,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Map<DateTime, JournalDay>> createElement() {
    return _JournalMonthProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is JournalMonthProvider && other.month == month;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, month.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin JournalMonthRef
    on AutoDisposeStreamProviderRef<Map<DateTime, JournalDay>> {
  /// The parameter `month` of this provider.
  DateTime get month;
}

class _JournalMonthProviderElement
    extends AutoDisposeStreamProviderElement<Map<DateTime, JournalDay>>
    with JournalMonthRef {
  _JournalMonthProviderElement(super.provider);

  @override
  DateTime get month => (origin as JournalMonthProvider).month;
}

String _$journalStreakHash() => r'6dd4e22a4f9057c9db7545bcffe37a741a6fdcb9';

/// Consecutive days, ending today or yesterday, with a non-empty entry.
///
/// Copied from [journalStreak].
@ProviderFor(journalStreak)
final journalStreakProvider = AutoDisposeStreamProvider<int>.internal(
  journalStreak,
  name: r'journalStreakProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$journalStreakHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef JournalStreakRef = AutoDisposeStreamProviderRef<int>;
String _$unconfessedSinMarksHash() =>
    r'8e73e5a432f53f5ff5641b55e9cb6dc67cc651b1';

/// Sins marked in the journal that have not yet been carried into a confession.
///
/// Copied from [unconfessedSinMarks].
@ProviderFor(unconfessedSinMarks)
final unconfessedSinMarksProvider =
    AutoDisposeStreamProvider<List<JournalSinMark>>.internal(
      unconfessedSinMarks,
      name: r'unconfessedSinMarksProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$unconfessedSinMarksHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UnconfessedSinMarksRef =
    AutoDisposeStreamProviderRef<List<JournalSinMark>>;
String _$journalStruggleAreasHash() =>
    r'dde8ef1ec99ab2c8fae6f1938afae887b596719a';

/// Journal sin marks grouped by commandment, most-marked first.
///
/// Copied from [journalStruggleAreas].
@ProviderFor(journalStruggleAreas)
final journalStruggleAreasProvider =
    AutoDisposeStreamProvider<List<StruggleArea>>.internal(
      journalStruggleAreas,
      name: r'journalStruggleAreasProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$journalStruggleAreasHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef JournalStruggleAreasRef =
    AutoDisposeStreamProviderRef<List<StruggleArea>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
