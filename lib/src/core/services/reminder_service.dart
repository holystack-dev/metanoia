import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
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

    // Schedule each notification with a unique ID
    for (int i = 0; i < dates.length; i++) {
      await _scheduleNotification(id: i, scheduledDate: dates[i]);
    }
  }

  static const _notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      'confession_reminder',
      'Confession Reminders',
      channelDescription: 'Reminders for confession',
      importance: Importance.high,
      priority: Priority.high,
    ),
    iOS: DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      // Uses default notification sound
    ),
  );

  Future<void> _scheduleNotification({
    required int id,
    required tz.TZDateTime scheduledDate,
  }) async {
    try {
      await _notifications.zonedSchedule(
        id,
        'Time for Confession',
        'Remember to examine your conscience and prepare for confession',
        scheduledDate,
        _notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e) {
      // Fallback to inexact alarm if exact alarm permission is not granted
      if (e.toString().contains('exact_alarms_not_permitted')) {
        await _notifications.zonedSchedule(
          id,
          'Time for Confession',
          'Remember to examine your conscience and prepare for confession',
          scheduledDate,
          _notificationDetails,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
        );
      } else {
        rethrow;
      }
    }
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

    if (isMonthly || isQuarterly) {
      // Monthly or Quarterly: find first [weekday] of each month/quarter
      final monthIncrement = isQuarterly ? 3 : 1;
      var currentMonth = now.month;
      var currentYear = now.year;

      // Iterate with safety limit
      int iterations = 0;
      const maxIterations = 200; // Safety limit to prevent infinite loop

      while (dates.length < _maxScheduledNotifications &&
          iterations < maxIterations) {
        iterations++;

        final candidate = _findFirstWeekdayOfMonth(
          currentYear,
          currentMonth,
          weekday,
          hour,
          minute,
        );
        final triggerDate = candidate.subtract(Duration(days: advanceDays));

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

      // Find the first occurrence
      var scheduledDate = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        hour,
        minute,
      );

      // Find next occurrence of the target weekday
      while (scheduledDate.weekday != weekday) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      // Skip to next occurrence if trigger date passed
      var triggerDate = scheduledDate.subtract(Duration(days: advanceDays));
      if (triggerDate.isBefore(now) || triggerDate.isAtSameMomentAs(now)) {
        scheduledDate = scheduledDate.add(Duration(days: dayIncrement));
      }

      // Schedule multiple occurrences
      for (int i = 0; i < _maxScheduledNotifications; i++) {
        triggerDate = scheduledDate.subtract(Duration(days: advanceDays));
        dates.add(triggerDate);
        scheduledDate = scheduledDate.add(Duration(days: dayIncrement));
      }
    }

    return dates;
  }

  Future<void> cancelAllReminders() async {
    await _notifications.cancelAll();
  }

  /// Returns the number of pending scheduled notifications
  Future<int> getPendingNotificationCount() async {
    final pending = await _notifications.pendingNotificationRequests();
    return pending.length;
  }

  /// Refreshes notifications if running low (less than half remaining)
  /// Call this on app startup to ensure notifications continue beyond 52 weeks
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

    // If less than half the notifications remain, reschedule all
    if (pendingCount > 0 && pendingCount < _maxScheduledNotifications ~/ 2) {
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

    var date = tz.TZDateTime(tz.local, year, month, 1, hour, minute);
    while (date.weekday != weekday) {
      date = date.add(const Duration(days: 1));
    }
    return date;
  }
}
