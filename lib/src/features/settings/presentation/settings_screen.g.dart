// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$keepHistorySettingsHash() =>
    r'847780e65db60eb0d7d8c6d1396dd4201e72fe64';

/// See also [KeepHistorySettings].
@ProviderFor(KeepHistorySettings)
final keepHistorySettingsProvider =
    AutoDisposeAsyncNotifierProvider<KeepHistorySettings, bool>.internal(
      KeepHistorySettings.new,
      name: r'keepHistorySettingsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$keepHistorySettingsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$KeepHistorySettings = AutoDisposeAsyncNotifier<bool>;
String _$examinationModeSettingsHash() =>
    r'7dd57f339e18682d00a1bff9012399db20ca3d8f';

/// See also [ExaminationModeSettings].
@ProviderFor(ExaminationModeSettings)
final examinationModeSettingsProvider = AutoDisposeAsyncNotifierProvider<
  ExaminationModeSettings,
  ExaminationModePreference
>.internal(
  ExaminationModeSettings.new,
  name: r'examinationModeSettingsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$examinationModeSettingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ExaminationModeSettings =
    AutoDisposeAsyncNotifier<ExaminationModePreference>;
String _$reminderSettingsHash() => r'a3863ca309c4c53c921dbfc8a906a62358834909';

/// See also [ReminderSettings].
@ProviderFor(ReminderSettings)
final reminderSettingsProvider =
    AutoDisposeAsyncNotifierProvider<ReminderSettings, ReminderConfig>.internal(
      ReminderSettings.new,
      name: r'reminderSettingsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$reminderSettingsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ReminderSettings = AutoDisposeAsyncNotifier<ReminderConfig>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
