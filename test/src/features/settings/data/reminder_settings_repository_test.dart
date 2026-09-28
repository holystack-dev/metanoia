import 'package:confessionapp/src/features/settings/data/reminder_settings_repository.dart';
import 'package:confessionapp/src/features/settings/domain/reminder_config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const repository = ReminderSettingsRepository();

  setUp(() => SharedPreferences.setMockInitialValues({}));

  group('ReminderConfig', () {
    test('starts off, so the app never nags an unasked user', () {
      const config = ReminderConfig.initial();

      expect(config.frequency, ReminderFrequency.none);
      expect(config.isEnabled, isFalse);
    });

    test('isEnabled is true for every frequency except none', () {
      for (final frequency in ReminderFrequency.values) {
        final config = const ReminderConfig.initial().copyWith(
          frequency: frequency,
        );

        expect(
          config.isEnabled,
          frequency != ReminderFrequency.none,
          reason: 'isEnabled was wrong for $frequency',
        );
      }
    });

    test('two configs with the same values are equal', () {
      const a = ReminderConfig.initial();
      final b = const ReminderConfig.initial().copyWith(
        frequency: ReminderFrequency.weekly,
      );
      final c = const ReminderConfig.initial().copyWith(
        frequency: ReminderFrequency.weekly,
      );

      expect(b, c);
      expect(b.hashCode, c.hashCode);
      expect(a, isNot(b));
    });
  });

  group('persistence', () {
    test('loads the defaults when nothing has been saved', () async {
      final config = await repository.load();

      expect(config, const ReminderConfig.initial());
    });

    test('a saved config round-trips exactly', () async {
      final saved = const ReminderConfig.initial().copyWith(
        frequency: ReminderFrequency.biweekly,
        weekday: DateTime.saturday,
        hour: 18,
        minute: 30,
        advanceDays: 2,
      );

      await repository.save(saved);

      expect(await repository.load(), saved);
    });

    test('falls back to the default for a corrupt stored frequency', () async {
      SharedPreferences.setMockInitialValues({
        'flutter.reminder_frequency': 'fortnightly-ish',
      });

      final config = await repository.load();

      expect(config.frequency, const ReminderConfig.initial().frequency);
    });
  });

  group('JournalReminderConfig', () {
    test('defaults to off at 9 PM', () {
      const config = JournalReminderConfig.initial();

      expect(config.isEnabled, isFalse);
      expect(config.hour, 21);
    });

    test('uses different preference keys from the confession reminder',
        () async {
      // They are two independent reminders; sharing a key would make one
      // silently overwrite the other.
      await repository.save(
        const ReminderConfig.initial().copyWith(hour: 8, minute: 15),
      );

      final journal = const JournalReminderConfig.initial().copyWith(
        isEnabled: true,
        hour: 21,
        minute: 45,
      );
      await const JournalReminderSettingsRepository().save(journal);

      final confession = await repository.load();
      expect(confession.hour, 8);
      expect(confession.minute, 15);

      final reloaded = await const JournalReminderSettingsRepository().load();
      expect(reloaded, journal);
    });
  });
}
