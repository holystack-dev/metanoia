// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sharedPreferencesHash() => r'f12ae338cc4fe91e3d89376161ea55ccdfadfc91';

/// The already-loaded [SharedPreferences] instance.
///
/// Loaded before `runApp` and injected as an override, so the settings the user
/// sees on the very first frame are their own. The theme, font-size and
/// language controllers used to return a default synchronously and then patch
/// themselves once an async read finished, which is what produced the visible
/// flash of the default theme and font at startup — and a race where a setting
/// changed early could be overwritten by the load that was still in flight.
///
/// Overridden in [main]; reading it without that override is a programming
/// error.
///
/// Copied from [sharedPreferences].
@ProviderFor(sharedPreferences)
final sharedPreferencesProvider = Provider<SharedPreferences>.internal(
  sharedPreferences,
  name: r'sharedPreferencesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sharedPreferencesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SharedPreferencesRef = ProviderRef<SharedPreferences>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
