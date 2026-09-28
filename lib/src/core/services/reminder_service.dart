import 'dart:ui' show Locale, PlatformDispatcher;

import 'package:confessionapp/src/core/constants/app_constants.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;

class ReminderService {
  static final ReminderService _instance = ReminderService._internal();
  factory ReminderService() => _instance;
  ReminderService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    // Initialize timezone database
    tz_data.initializeTimeZones();

    // Get device timezone and set it as local
    try {
      final String timezoneName = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timezoneName));
    } catch (e) {
      // Fallback to UTC if timezone detection fails
      tz.setLocalLocation(tz.UTC);
    }

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(initSettings);
    _initialized = true;
  }

  Future<bool> requestPermissions() async {
    final androidImplementation =
        _notifications
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();

    if (androidImplementation != null) {
      // Request POST_NOTIFICATIONS permission (required for Android 13+)
      final notificationPermission =
          await androidImplementation.requestNotificationsPermission() ?? false;

      // Request exact alarm permission (required for Android 12+)
      await androidImplementation.requestExactAlarmsPermission();

      return notificationPermission;
    }

    final iosImplementation =
        _notifications
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >();

    if (iosImplementation != null) {
      return await iosImplementation.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
          false;
    }

    return true;
  }

  // Maximum notifications to schedule upfront (iOS has a 64 limit)
  static const int _maxScheduledNotifications = 52;

  /// Confession reminders occupy ids `0 .. _maxScheduledNotifications - 1`.
  ///
  /// The journal reminder lives outside that range so the two never cancel or
  /// overwrite each other.
  static const int _journalReminderId = 1000;

  /// Shared preferences key written by `LanguageController`.
  static const String _appLanguageKey = 'app_language';

  /// Resolves the localizations for the user's saved app language (falling back
  /// to the platform locale, then English). [ReminderService] has no
  /// [BuildContext], so the locale is looked up explicitly.
  Future<AppLocalizations> _resolveLocalizations() async {
    Locale locale;
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedKey = prefs.getString(_appLanguageKey);
      locale =
          savedKey != null
              ? LanguageConfig.localeFromContentKey(savedKey)
              : PlatformDispatcher.instance.locale;
    } catch (_) {
      locale = PlatformDispatcher.instance.locale;
    }

    try {
      return lookupAppLocalizations(Locale(locale.languageCode));
    } catch (_) {
      return lookupAppLocalizations(const Locale('en'));
    }
  }

  Future<void> scheduleReminder({
    required int weekday, // 1 = Monday, 7 = Sunday
    required int hour,
    required int minute,
    required int advanceDays,
    required bool isBiweekly,
    required bool isMonthly,
    required bool isQuarterly,
  }) async {
    // Cancel existing reminders first to avoid duplicates
    await cancelAllReminders();

    // Calculate all future notification dates
    final dates = _calculateAllOccurrences(
      weekday: weekday,
      hour: hour,
      minute: minute,
      advanceDays: advanceDays,
      isBiweekly: isBiweekly,
      isMonthly: isMonthly,
      isQuarterly: isQuarterly,
    );

    final l10n = await _resolveLocalizations();

    // Schedule each notification with a unique ID
    for (int i = 0; i < dates.length; i++) {
      await _scheduleNotification(
        id: i,
        scheduledDate: dates[i],
        title: l10n.reminderNotificationTitle,
        body: l10n.reminderNotificationBody,
        details: _notificationDetails(l10n),
      );
    }
  }

  /// The confession reminder's notification details.
  ///
  /// Built per-locale: on Android the channel name and description are shown
  /// to the user in Settings → Notifications.
  NotificationDetails _notificationDetails(AppLocalizations l10n) {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'confession_reminder',
        l10n.confessionReminderChannelName,
        channelDescription: l10n.confessionReminderChannelDescription,
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        // Uses default notification sound
      ),
    );
  }

  /// A channel of its own, so the evening nudge can be silenced (or kept)
  /// independently of the confession reminder in the system settings.
  NotificationDetails _journalNotificationDetails(AppLocalizations l10n) {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'journal_reminder',
        l10n.journalReminderChannelName,
        channelDescription: l10n.journalReminderChannelDescription,
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: false,
        presentSound: true,
      ),
    );
  }

  Future<void> _scheduleNotification({
    required int id,
    required tz.TZDateTime scheduledDate,
    required String title,
    required String body,
    required NotificationDetails details,
    DateTimeComponents? matchDateTimeComponents,
  }) async {
    try {
      await _notifications.zonedSchedule(
        id,
        title,
        body,
        scheduledDate,
        details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: matchDateTimeComponents,
      );
    } catch (e) {
      // Fallback to inexact alarm if exact alarm permission is not granted
      if (e.toString().contains('exact_alarms_not_permitted')) {
        await _notifications.zonedSchedule(
          id,
          title,
          body,
          scheduledDate,
          details,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: matchDateTimeComponents,
        );
      } else {
        rethrow;
      }
    }
  }

  // ------------------------------------------------------- journal reminder

  /// Schedules the daily journal reminder at [hour]:[minute].
  ///
  /// A single repeating notification at the same wall-clock time
  /// (`DateTimeComponents.time`), which is DST-proof and never runs out.
  Future<void> scheduleJournalReminder({
    required int hour,
    required int minute,
  }) async {
    await cancelJournalReminder();

    final l10n = await _resolveLocalizations();

    await _scheduleNotification(
      id: _journalReminderId,
      scheduledDate: _nextDailyOccurrence(hour, minute),
      title: l10n.journalReminderNotificationTitle,
      body: l10n.journalReminderNotificationBody,
      details: _journalNotificationDetails(l10n),
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelJournalReminder() async {
    await _notifications.cancel(_journalReminderId);
  }

  /// Re-schedules the journal reminder if it is no longer pending.
  ///
  /// A reboot, restore or cancelled alarm can leave nothing scheduled.
  Future<bool> refreshJournalReminderIfNeeded({
    required int hour,
    required int minute,
  }) async {
    final pending = await _notifications.pendingNotificationRequests();
    if (pending.any((request) => request.id == _journalReminderId)) {
      return false;
    }

    await scheduleJournalReminder(hour: hour, minute: minute);
    return true;
  }

  /// Today at [hour]:[minute], or tomorrow if that moment has already passed.
  ///
  /// Built from calendar components (never by adding a Duration), so the
  /// wall-clock time holds across a DST transition.
  tz.TZDateTime _nextDailyOccurrence(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    final today = _localDateTime(now.year, now.month, now.day, hour, minute);

    if (today.isAfter(now)) return today;
    return _shiftDays(today, 1, hour, minute);
  }

  /// Builds a local date/time from calendar components.
  ///
  /// Day overflow/underflow is normalized (e.g. day 0 = last day of the
  /// previous month), and the wall-clock [hour]/[minute] is preserved across
  /// daylight-saving transitions — unlike `TZDateTime.add(Duration(days: n))`,
  /// which is absolute-time arithmetic and drifts by an hour after a DST shift.
  tz.TZDateTime _localDateTime(
    int year,
    int month,
    int day,
    int hour,
    int minute,
  ) {
    return tz.TZDateTime(tz.local, year, month, day, hour, minute);
  }

  /// Shifts [date] by [days] calendar days, keeping the wall-clock time.
  tz.TZDateTime _shiftDays(tz.TZDateTime date, int days, int hour, int minute) {
    return _localDateTime(date.year, date.month, date.day + days, hour, minute);
  }

  /// Calculates all future notification dates based on frequency
  List<tz.TZDateTime> _calculateAllOccurrences({
    required int weekday,
    required int hour,
    required int minute,
    required int advanceDays,
    required bool isBiweekly,
    required bool isMonthly,
    required bool isQuarterly,
  }) {
    final List<tz.TZDateTime> dates = [];
    final now = tz.TZDateTime.now(tz.local);

    // Safety limit to prevent infinite loops
    const maxIterations = 200;

    if (isMonthly || isQuarterly) {
      // Monthly or Quarterly: find first [weekday] of each month/quarter
      final monthIncrement = isQuarterly ? 3 : 1;
      var currentMonth = now.month;
      var currentYear = now.year;

      int iterations = 0;
      while (dates.length < _maxScheduledNotifications &&
          iterations < maxIterations) {
        iterations++;

        final occurrence = _findFirstWeekdayOfMonth(
          currentYear,
          currentMonth,
          weekday,
          hour,
          minute,
        );
        final triggerDate = _shiftDays(occurrence, -advanceDays, hour, minute);

        // Only add future dates
        if (triggerDate.isAfter(now)) {
          dates.add(triggerDate);
        }

        // Move to next month/quarter
        currentMonth += monthIncrement;
        if (currentMonth > 12) {
          currentYear += (currentMonth - 1) ~/ 12;
          currentMonth = ((currentMonth - 1) % 12) + 1;
        }
      }
    } else {
      // Weekly or Biweekly
      final dayIncrement = isBiweekly ? 14 : 7;

      // Today at the chosen wall-clock time, moved forward to the target
      // weekday using calendar arithmetic (DST safe).
      final today = _localDateTime(now.year, now.month, now.day, hour, minute);
      final daysUntilWeekday = (weekday - today.weekday) % 7;
      var occurrence = _shiftDays(today, daysUntilWeekday, hour, minute);

      int iterations = 0;
      while (dates.length < _maxScheduledNotifications &&
          iterations < maxIterations) {
        iterations++;

        final triggerDate = _shiftDays(occurrence, -advanceDays, hour, minute);
        if (triggerDate.isAfter(now)) {
          dates.add(triggerDate);
        }

        // Rebuild the next occurrence from date components so the wall-clock
        // time stays put across DST transitions.
        occurrence = _shiftDays(occurrence, dayIncrement, hour, minute);
      }
    }

    return dates;
  }

  /// Cancels the confession reminder series.
  ///
  /// Only its own id range; `cancelAll()` would also cancel the journal
  /// reminder.
  Future<void> cancelAllReminders() async {
    for (var id = 0; id < _maxScheduledNotifications; id++) {
      await _notifications.cancel(id);
    }
  }

  /// Returns the number of pending confession reminders.
  ///
  /// Scoped to the confession id range, so the journal reminder does not mask a
  /// needed reschedule.
  Future<int> getPendingNotificationCount() async {
    final pending = await _notifications.pendingNotificationRequests();
    return pending
        .where((request) => request.id < _maxScheduledNotifications)
        .length;
  }

  /// Refreshes notifications if running low (less than half remaining).
  ///
  /// A pending count of zero means every notification has fired, so it
  /// reschedules too. Call on app startup so reminders continue past 52 weeks.
  Future<bool> refreshIfNeeded({
    required int weekday,
    required int hour,
    required int minute,
    required int advanceDays,
    required bool isBiweekly,
    required bool isMonthly,
    required bool isQuarterly,
  }) async {
    final pendingCount = await getPendingNotificationCount();

    // If less than half the notifications remain (including none at all),
    // reschedule the whole series.
    if (pendingCount < _maxScheduledNotifications ~/ 2) {
      await scheduleReminder(
        weekday: weekday,
        hour: hour,
        minute: minute,
        advanceDays: advanceDays,
        isBiweekly: isBiweekly,
        isMonthly: isMonthly,
        isQuarterly: isQuarterly,
      );
      return true; // Refreshed
    }
    return false; // No refresh needed
  }

  tz.TZDateTime _findFirstWeekdayOfMonth(
    int year,
    int month,
    int weekday,
    int hour,
    int minute,
  ) {
    // Handle month overflow
    if (month > 12) {
      year += (month - 1) ~/ 12;
      month = (month - 1) % 12 + 1;
    }

    final firstOfMonth = _localDateTime(year, month, 1, hour, minute);
    final daysUntilWeekday = (weekday - firstOfMonth.weekday) % 7;
    return _shiftDays(firstOfMonth, daysUntilWeekday, hour, minute);
  }
}
