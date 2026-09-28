import 'package:confessionapp/src/core/preferences/preferences_provider.dart';
import 'package:confessionapp/src/core/utils/clock_provider.dart';
import 'package:confessionapp/src/features/confession/data/anniversary_nudge_provider.dart';
import 'package:confessionapp/src/features/confession/data/confession_analytics_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const dismissedKey = 'anniversary_nudge_dismissed_epoch_day';
  final today = DateTime(2026, 7, 12);

  ConfessionAnalytics analytics({
    required int total,
    required double? average,
    required int daysSince,
  }) {
    return ConfessionAnalytics(
      totalConfessions: total,
      averageDaysBetween: average,
      daysSinceLastConfession: daysSince,
      monthlyFrequency: const [],
      currentStreakWeeks: 0,
      totalItemsConfessed: 0,
    );
  }

  Future<(ProviderContainer, SharedPreferences)> containerWith(
    ConfessionAnalytics value, {
    Map<String, Object> values = const {},
  }) async {
    SharedPreferences.setMockInitialValues(values);
    final prefs = await SharedPreferences.getInstance();

    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        todayProvider.overrideWithValue(today),
        confessionAnalyticsProvider.overrideWith((ref) => Stream.value(value)),
      ],
    );
    addTearDown(container.dispose);
    // The nudge derives from a stream; let it deliver before reading.
    await container.read(confessionAnalyticsProvider.future);
    return (container, prefs);
  }

  test('is silent while the analytics stream is still loading', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        todayProvider.overrideWithValue(today),
        confessionAnalyticsProvider.overrideWith(
          (ref) => const Stream<ConfessionAnalytics>.empty(),
        ),
      ],
    );
    addTearDown(container.dispose);

    expect(container.read(anniversaryNudgeProvider), isNull);
  });

  test('is silent with fewer than three confessions', () async {
    final (container, _) = await containerWith(
      analytics(total: 2, average: 30, daysSince: 200),
    );

    expect(container.read(anniversaryNudgeProvider), isNull);
  });

  test('is silent while the user is within their own cadence', () async {
    final (container, _) = await containerWith(
      analytics(total: 8, average: 30, daysSince: 25),
    );

    expect(container.read(anniversaryNudgeProvider), isNull);
  });

  test('invites once the gap outruns the cadence', () async {
    final (container, _) = await containerWith(
      analytics(total: 8, average: 30, daysSince: 49),
    );

    final nudge = container.read(anniversaryNudgeProvider);
    expect(nudge, isNotNull);
    expect(nudge!.weeksSinceLastConfession, 7);
  });

  test('dismissing hides it and persists the day', () async {
    final (container, prefs) = await containerWith(
      analytics(total: 8, average: 30, daysSince: 49),
    );

    await container.read(anniversaryDismissalProvider.notifier).dismissToday();

    expect(container.read(anniversaryNudgeProvider), isNull);
    // 12 July 2026, in days since the Unix epoch.
    expect(prefs.getInt(dismissedKey), 20646);
  });

  test('a dismissal from yesterday still holds after a restart', () async {
    final (container, _) = await containerWith(
      analytics(total: 8, average: 30, daysSince: 50),
      values: {dismissedKey: 20645}, // 11 July 2026
    );

    expect(container.read(anniversaryNudgeProvider), isNull);
  });

  test('a dismissal from a fortnight ago has expired', () async {
    final (container, _) = await containerWith(
      analytics(total: 8, average: 30, daysSince: 63),
      values: {dismissedKey: 20632}, // 28 June 2026: 14 days back
    );

    expect(container.read(anniversaryNudgeProvider), isNotNull);
  });
}
