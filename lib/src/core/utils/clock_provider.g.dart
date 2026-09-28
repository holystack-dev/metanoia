// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clock_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todayHash() => r'9ad48a69b1ab8d386e1833c6eb783e05f208ca5e';

/// Today's date, as a provider.
///
/// Anything that decides *what to show* from the calendar (the liturgical
/// prompt, the anniversary nudge) reads the date through here rather than
/// calling `DateTime.now()` inline, so a test can pin the day with an override
/// instead of waiting for Lent.
///
/// The time of day is stripped: consumers of this provider reason in calendar
/// days, and a value that changed every microsecond would invalidate them
/// constantly.
///
/// Self-correcting, and deliberately so. The provider is kept alive for the
/// life of the process, and a mobile process routinely lives — backgrounded —
/// for days. A value computed once at launch and never revisited meant the
/// liturgical card counting down to Christmas kept saying "3 days" on Christmas
/// Day itself, a season prompt outlived its own 7-day window, and the
/// anniversary dismissal recorded a stale epoch-day and so skewed its cooldown.
/// Rather than depend on the app's lifecycle observer, the provider watches for
/// its own staleness: it recomputes when the app is resumed, and when the local
/// clock crosses midnight while the app is still open.
///
/// Copied from [today].
@ProviderFor(today)
final todayProvider = Provider<DateTime>.internal(
  today,
  name: r'todayProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todayHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodayRef = ProviderRef<DateTime>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
