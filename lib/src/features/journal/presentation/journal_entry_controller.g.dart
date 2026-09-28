// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_entry_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sinTextResolverHash() => r'41dfa899252c33088439ec3208fb5903e7c2e707';

/// Display text for sin marks, in the current content language.
///
/// Copied from [sinTextResolver].
@ProviderFor(sinTextResolver)
final sinTextResolverProvider =
    AutoDisposeFutureProvider<SinTextResolver>.internal(
      sinTextResolver,
      name: r'sinTextResolverProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$sinTextResolverHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SinTextResolverRef = AutoDisposeFutureProviderRef<SinTextResolver>;
String _$journalEntryControllerHash() =>
    r'7ede5addcec519e9b86a5b98ea10022fb7012188';

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

abstract class _$JournalEntryController
    extends BuildlessAutoDisposeNotifier<JournalSaveStatus> {
  late final DateTime day;

  JournalSaveStatus build(DateTime day);
}

/// Drives the daily entry: debounced autosave of the text fields, immediate
/// writes for mood and sin marks.
///
/// Writes themselves are serialized inside [JournalRepository]; this controller
/// only decides *when* to write.
///
/// Copied from [JournalEntryController].
@ProviderFor(JournalEntryController)
const journalEntryControllerProvider = JournalEntryControllerFamily();

/// Drives the daily entry: debounced autosave of the text fields, immediate
/// writes for mood and sin marks.
///
/// Writes themselves are serialized inside [JournalRepository]; this controller
/// only decides *when* to write.
///
/// Copied from [JournalEntryController].
class JournalEntryControllerFamily extends Family<JournalSaveStatus> {
  /// Drives the daily entry: debounced autosave of the text fields, immediate
  /// writes for mood and sin marks.
  ///
  /// Writes themselves are serialized inside [JournalRepository]; this controller
  /// only decides *when* to write.
  ///
  /// Copied from [JournalEntryController].
  const JournalEntryControllerFamily();

  /// Drives the daily entry: debounced autosave of the text fields, immediate
  /// writes for mood and sin marks.
  ///
  /// Writes themselves are serialized inside [JournalRepository]; this controller
  /// only decides *when* to write.
  ///
  /// Copied from [JournalEntryController].
  JournalEntryControllerProvider call(DateTime day) {
    return JournalEntryControllerProvider(day);
  }

  @override
  JournalEntryControllerProvider getProviderOverride(
    covariant JournalEntryControllerProvider provider,
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
  String? get name => r'journalEntryControllerProvider';
}

/// Drives the daily entry: debounced autosave of the text fields, immediate
/// writes for mood and sin marks.
///
/// Writes themselves are serialized inside [JournalRepository]; this controller
/// only decides *when* to write.
///
/// Copied from [JournalEntryController].
class JournalEntryControllerProvider
    extends
        AutoDisposeNotifierProviderImpl<
          JournalEntryController,
          JournalSaveStatus
        > {
  /// Drives the daily entry: debounced autosave of the text fields, immediate
  /// writes for mood and sin marks.
  ///
  /// Writes themselves are serialized inside [JournalRepository]; this controller
  /// only decides *when* to write.
  ///
  /// Copied from [JournalEntryController].
  JournalEntryControllerProvider(DateTime day)
    : this._internal(
        () => JournalEntryController()..day = day,
        from: journalEntryControllerProvider,
        name: r'journalEntryControllerProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$journalEntryControllerHash,
        dependencies: JournalEntryControllerFamily._dependencies,
        allTransitiveDependencies:
            JournalEntryControllerFamily._allTransitiveDependencies,
        day: day,
      );

  JournalEntryControllerProvider._internal(
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
  JournalSaveStatus runNotifierBuild(
    covariant JournalEntryController notifier,
  ) {
    return notifier.build(day);
  }

  @override
  Override overrideWith(JournalEntryController Function() create) {
    return ProviderOverride(
      origin: this,
      override: JournalEntryControllerProvider._internal(
        () => create()..day = day,
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
  AutoDisposeNotifierProviderElement<JournalEntryController, JournalSaveStatus>
  createElement() {
    return _JournalEntryControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is JournalEntryControllerProvider && other.day == day;
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
mixin JournalEntryControllerRef
    on AutoDisposeNotifierProviderRef<JournalSaveStatus> {
  /// The parameter `day` of this provider.
  DateTime get day;
}

class _JournalEntryControllerProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          JournalEntryController,
          JournalSaveStatus
        >
    with JournalEntryControllerRef {
  _JournalEntryControllerProviderElement(super.provider);

  @override
  DateTime get day => (origin as JournalEntryControllerProvider).day;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
