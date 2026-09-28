import 'package:confessionapp/src/core/services/reminder_service.dart';
import 'package:confessionapp/src/features/settings/data/reminder_settings_repository.dart';
import 'package:confessionapp/src/features/settings/domain/reminder_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reminder_settings_provider.g.dart';

/// Holds the persisted confession reminder configuration.
///
/// Building this provider has no side effects; scheduling happens only via
/// [updateConfig] / [refreshScheduleIfNeeded].
@Riverpod(keepAlive: true)
class ReminderSettings extends _$ReminderSettings {
  static const ReminderSettingsRepository _repository =
      ReminderSettingsRepository();

  @override
  Future<ReminderConfig> build() => _repository.load();

  /// Persists [config] and updates the scheduled notifications.
  ///
  /// When enabling, notification permission is requested first; if denied,
  /// nothing is persisted and [ReminderUpdateResult.permissionDenied] is
  /// returned.
  Future<ReminderUpdateResult> updateConfig(ReminderConfig config) async {
    final service = ReminderService();
    await service.initialize();

    if (!config.isEnabled) {
      await _repository.save(config);
      state = AsyncValue.data(config);
      await service.cancelAllReminders();
      return ReminderUpdateResult.saved;
    }

    final granted = await service.requestPermissions();
    if (!granted) {
      return ReminderUpdateResult.permissionDenied;
    }

    await _repository.save(config);
    state = AsyncValue.data(config);
    await _schedule(service, config);
    return ReminderUpdateResult.saved;
  }

  /// Re-schedules the reminder series when the pending notifications are
  /// running low (or have all fired). Safe to call on app start / whenever the
  /// settings screen is opened.
  Future<void> refreshScheduleIfNeeded() async {
    final config = await future;
    if (!config.isEnabled) return;

    final service = ReminderService();
    await service.initialize();
    await service.refreshIfNeeded(
      weekday: config.weekday,
      hour: config.hour,
      minute: config.minute,
      advanceDays: config.advanceDays,
      isBiweekly: config.isBiweekly,
      isMonthly: config.isMonthly,
      isQuarterly: config.isQuarterly,
    );
  }

  Future<void> _schedule(ReminderService service, ReminderConfig config) {
    return service.scheduleReminder(
      weekday: config.weekday,
      hour: config.hour,
      minute: config.minute,
      advanceDays: config.advanceDays,
      isBiweekly: config.isBiweekly,
      isMonthly: config.isMonthly,
      isQuarterly: config.isQuarterly,
    );
  }
}

/// Holds the persisted daily journal reminder configuration.
///
/// Independent of [ReminderSettings]: separate storage, schedule and
/// notification channel. Building it has no side effects.
@Riverpod(keepAlive: true)
class JournalReminderSettings extends _$JournalReminderSettings {
  static const JournalReminderSettingsRepository _repository =
      JournalReminderSettingsRepository();

  @override
  Future<JournalReminderConfig> build() => _repository.load();

  /// Persists [config] and updates the scheduled reminder.
  ///
  /// When enabling, notification permission is requested first; if denied,
  /// nothing is persisted and [ReminderUpdateResult.permissionDenied] is
  /// returned.
  Future<ReminderUpdateResult> updateConfig(JournalReminderConfig config) async {
    final service = ReminderService();
    await service.initialize();

    if (!config.isEnabled) {
      await _repository.save(config);
      state = AsyncValue.data(config);
      await service.cancelJournalReminder();
      return ReminderUpdateResult.saved;
    }

    final granted = await service.requestPermissions();
    if (!granted) {
      return ReminderUpdateResult.permissionDenied;
    }

    await _repository.save(config);
    state = AsyncValue.data(config);
    await service.scheduleJournalReminder(
      hour: config.hour,
      minute: config.minute,
    );
    return ReminderUpdateResult.saved;
  }

  /// Re-schedules the daily reminder if nothing is pending for it.
  Future<void> refreshScheduleIfNeeded() async {
    final config = await future;
    if (!config.isEnabled) return;

    final service = ReminderService();
    await service.initialize();
    await service.refreshJournalReminderIfNeeded(
      hour: config.hour,
      minute: config.minute,
    );
  }
}
