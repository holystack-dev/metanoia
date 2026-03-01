// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$quoteRepositoryHash() => r'7e5cb101b41d051d864d01e9974a6912e4ea3ef3';

/// See also [quoteRepository].
@ProviderFor(quoteRepository)
final quoteRepositoryProvider = AutoDisposeProvider<QuoteRepository>.internal(
  quoteRepository,
  name: r'quoteRepositoryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$quoteRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef QuoteRepositoryRef = AutoDisposeProviderRef<QuoteRepository>;
String _$randomQuoteHash() => r'5dda2df8df80fa04256fe615ba7f9f41f873d2e3';

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

/// See also [randomQuote].
@ProviderFor(randomQuote)
const randomQuoteProvider = RandomQuoteFamily();

/// See also [randomQuote].
class RandomQuoteFamily extends Family<AsyncValue<Quote>> {
  /// See also [randomQuote].
  const RandomQuoteFamily();

  /// See also [randomQuote].
  RandomQuoteProvider call(Locale locale) {
    return RandomQuoteProvider(locale);
  }

  @override
  RandomQuoteProvider getProviderOverride(
    covariant RandomQuoteProvider provider,
  ) {
    return call(provider.locale);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'randomQuoteProvider';
}

/// See also [randomQuote].
class RandomQuoteProvider extends AutoDisposeFutureProvider<Quote> {
  /// See also [randomQuote].
  RandomQuoteProvider(Locale locale)
    : this._internal(
        (ref) => randomQuote(ref as RandomQuoteRef, locale),
        from: randomQuoteProvider,
        name: r'randomQuoteProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$randomQuoteHash,
        dependencies: RandomQuoteFamily._dependencies,
        allTransitiveDependencies: RandomQuoteFamily._allTransitiveDependencies,
        locale: locale,
      );

  RandomQuoteProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.locale,
  }) : super.internal();

  final Locale locale;

  @override
  Override overrideWith(
    FutureOr<Quote> Function(RandomQuoteRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RandomQuoteProvider._internal(
        (ref) => create(ref as RandomQuoteRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        locale: locale,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Quote> createElement() {
    return _RandomQuoteProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RandomQuoteProvider && other.locale == locale;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, locale.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RandomQuoteRef on AutoDisposeFutureProviderRef<Quote> {
  /// The parameter `locale` of this provider.
  Locale get locale;
}

class _RandomQuoteProviderElement
    extends AutoDisposeFutureProviderElement<Quote>
    with RandomQuoteRef {
  _RandomQuoteProviderElement(super.provider);

  @override
  Locale get locale => (origin as RandomQuoteProvider).locale;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
