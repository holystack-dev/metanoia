import 'package:confessionapp/src/features/settings/domain/reminder_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists the confession [ReminderConfig] in shared preferences.
class ReminderSettingsRepository {
  const ReminderSettingsRepository();

  static const String _frequencyKey = 'reminder_frequency';
  static const String _weekdayKey = 'reminder_weekday';
  static const String _hourKey = 'reminder_hour';
  static const String _minuteKey = 'reminder_minute';
  static const String _advanceDaysKey = 'reminder_advance_days';

  Future<ReminderConfig> load() async {
    final prefs = await SharedPreferences.getInstance();
    const defaults = ReminderConfig.initial();

    return ReminderConfig(
      frequency: ReminderFrequency.values.firstWhere(
        (e) => e.name == prefs.getString(_frequencyKey),
        orElse: () => defaults.frequency,
      ),
      weekday: prefs.getInt(_weekdayKey) ?? defaults.weekday,
      hour: prefs.getInt(_hourKey) ?? defaults.hour,
      minute: prefs.getInt(_minuteKey) ?? defaults.minute,
      advanceDays: prefs.getInt(_advanceDaysKey) ?? defaults.advanceDays,
    );
  }

  Future<void> save(ReminderConfig config) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_frequencyKey, config.frequency.name);
    await prefs.setInt(_weekdayKey, config.weekday);
    await prefs.setInt(_hourKey, config.hour);
    await prefs.setInt(_minuteKey, config.minute);
    await prefs.setInt(_advanceDaysKey, config.advanceDays);
  }
}

/// Persists the daily [JournalReminderConfig] in shared preferences, under keys
/// of its own so it cannot collide with the confession reminder.
class JournalReminderSettingsRepository {
  const JournalReminderSettingsRepository();

  static const String _enabledKey = 'journal_reminder_enabled';
  static const String _hourKey = 'journal_reminder_hour';
  static const String _minuteKey = 'journal_reminder_minute';

  Future<JournalReminderConfig> load() async {
    final prefs = await SharedPreferences.getInstance();
    const defaults = JournalReminderConfig.initial();

    return JournalReminderConfig(
      isEnabled: prefs.getBool(_enabledKey) ?? defaults.isEnabled,
      hour: prefs.getInt(_hourKey) ?? defaults.hour,
      minute: prefs.getInt(_minuteKey) ?? defaults.minute,
    );
  }

  Future<void> save(JournalReminderConfig config) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_enabledKey, config.isEnabled);
    await prefs.setInt(_hourKey, config.hour);
    await prefs.setInt(_minuteKey, config.minute);
  }
}
