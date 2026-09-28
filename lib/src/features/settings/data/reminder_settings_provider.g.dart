// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reminderSettingsHash() => r'9a497d29136f56e962c6f5082c0a6de0b58e58b4';

/// Holds the persisted confession reminder configuration.
///
/// Building this provider has NO side effects: it only reads the saved
/// configuration. Scheduling and refreshing notifications are explicit actions
/// ([updateConfig] / [refreshScheduleIfNeeded]).
///
/// Copied from [ReminderSettings].
@ProviderFor(ReminderSettings)
final reminderSettingsProvider =
    AsyncNotifierProvider<ReminderSettings, ReminderConfig>.internal(
      ReminderSettings.new,
      name: r'reminderSettingsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$reminderSettingsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ReminderSettings = AsyncNotifier<ReminderConfig>;
String _$journalReminderSettingsHash() =>
    r'fa6a52f1fa34ddbf6fb7e3a5ddb024f3737fa0aa';

/// Holds the persisted daily journal reminder configuration.
///
/// Separate from [ReminderSettings] in every respect — storage, schedule and
/// notification channel — so turning one on or off never touches the other.
/// Building it has no side effects, exactly as with the confession reminder.
///
/// Copied from [JournalReminderSettings].
@ProviderFor(JournalReminderSettings)
final journalReminderSettingsProvider = AsyncNotifierProvider<
  JournalReminderSettings,
  JournalReminderConfig
>.internal(
  JournalReminderSettings.new,
  name: r'journalReminderSettingsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$journalReminderSettingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$JournalReminderSettings = AsyncNotifier<JournalReminderConfig>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
