import 'package:flutter/foundation.dart';

/// How often the confession reminder fires.
enum ReminderFrequency { none, weekly, biweekly, monthly, quarterly }

/// User configuration for the confession reminder.
@immutable
class ReminderConfig {
  const ReminderConfig({
    required this.frequency,
    required this.weekday,
    required this.hour,
    required this.minute,
    required this.advanceDays,
  });

  /// Defaults used when nothing has been saved yet.
  const ReminderConfig.initial()
    : frequency = ReminderFrequency.none,
      weekday = DateTime.saturday,
      hour = 9,
      minute = 0,
      advanceDays = 0;

  final ReminderFrequency frequency;

  /// 1 = Monday … 7 = Sunday (matches [DateTime.weekday]).
  final int weekday;
  final int hour;
  final int minute;
  final int advanceDays;

  bool get isEnabled => frequency != ReminderFrequency.none;
  bool get isBiweekly => frequency == ReminderFrequency.biweekly;
  bool get isMonthly => frequency == ReminderFrequency.monthly;
  bool get isQuarterly => frequency == ReminderFrequency.quarterly;

  ReminderConfig copyWith({
    ReminderFrequency? frequency,
    int? weekday,
    int? hour,
    int? minute,
    int? advanceDays,
  }) {
    return ReminderConfig(
      frequency: frequency ?? this.frequency,
      weekday: weekday ?? this.weekday,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      advanceDays: advanceDays ?? this.advanceDays,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderConfig &&
          other.frequency == frequency &&
          other.weekday == weekday &&
          other.hour == hour &&
          other.minute == minute &&
          other.advanceDays == advanceDays;

  @override
  int get hashCode =>
      Object.hash(frequency, weekday, hour, minute, advanceDays);
}

/// User configuration for the daily journal reminder.
///
/// Independent of [ReminderConfig]: stored under different keys and scheduled
/// on a different notification channel.
@immutable
class JournalReminderConfig {
  const JournalReminderConfig({
    required this.isEnabled,
    required this.hour,
    required this.minute,
  });

  /// Defaults used when nothing has been saved yet: off, and 9 PM once enabled.
  const JournalReminderConfig.initial()
    : isEnabled = false,
      hour = 21,
      minute = 0;

  final bool isEnabled;
  final int hour;
  final int minute;

  JournalReminderConfig copyWith({bool? isEnabled, int? hour, int? minute}) {
    return JournalReminderConfig(
      isEnabled: isEnabled ?? this.isEnabled,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JournalReminderConfig &&
          other.isEnabled == isEnabled &&
          other.hour == hour &&
          other.minute == minute;

  @override
  int get hashCode => Object.hash(isEnabled, hour, minute);
}

/// Outcome of an attempt to save a [ReminderConfig].
enum ReminderUpdateResult {
  /// The configuration was persisted and the schedule updated.
  saved,

  /// Notification permission was denied — nothing was persisted or scheduled.
  permissionDenied,
}
