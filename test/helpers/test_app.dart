import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A reusable test database that skips content sync
class TestAppDatabase extends AppDatabase {
  TestAppDatabase() : super(NativeDatabase.memory());

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          // Skip syncContent() for tests to avoid asset loading
        },
      );
}

/// A wrapper widget for testing that provides:
/// - MaterialApp with localization
/// - Riverpod ProviderScope with database override
/// - Optional navigation setup
class TestApp extends StatelessWidget {
  final Widget child;
  final List<Override> overrides;
  final List<NavigatorObserver>? navigatorObservers;
  final ThemeData? theme;
  final Locale? locale;

  const TestApp({
    super.key,
    required this.child,
    this.overrides = const [],
    this.navigatorObservers,
    this.theme,
    this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: overrides,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale ?? const Locale('en'),
        theme: theme ?? ThemeData.light(useMaterial3: true),
        navigatorObservers: navigatorObservers ?? [],
        // Wrap with TickerMode to disable animations in tests
        home: TickerMode(
          enabled: false,
          child: child,
        ),
      ),
    );
  }
}

/// Creates a test app with database override
Widget createTestApp({
  required Widget child,
  required AppDatabase database,
  List<Override> additionalOverrides = const [],
  ThemeData? theme,
  Locale? locale,
}) {
  return TestApp(
    overrides: [
      appDatabaseProvider.overrideWithValue(database),
      ...additionalOverrides,
    ],
    theme: theme,
    locale: locale,
    child: child,
  );
}

/// Sets up common test prerequisites
Future<void> setupTestEnvironment() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  // Disable flutter_animate animations in tests to prevent pumpAndSettle timeouts
  Animate.restartOnHotReload = false;
  Animate.defaultDuration = Duration.zero;
}

/// Disables animations for testing - call this in setUp or setUpAll
void disableAnimations() {
  Animate.restartOnHotReload = false;
  Animate.defaultDuration = Duration.zero;
}

/// Extension methods for widget testing
extension WidgetTesterExtension on WidgetTester {
  /// Pumps the widget and waits for all animations to settle
  Future<void> pumpAndSettle2({Duration? duration}) async {
    await pumpAndSettle(duration ?? const Duration(seconds: 1));
  }

  /// Finds a widget by text and taps it
  Future<void> tapByText(String text) async {
    final finder = find.text(text);
    expect(finder, findsOneWidget, reason: 'Could not find text: $text');
    await tap(finder);
    await pump();
  }

  /// Finds a widget by icon and taps it
  Future<void> tapByIcon(IconData icon) async {
    final finder = find.byIcon(icon);
    expect(finder, findsOneWidget, reason: 'Could not find icon: $icon');
    await tap(finder);
    await pump();
  }

  /// Finds a widget by key and taps it
  Future<void> tapByKey(Key key) async {
    final finder = find.byKey(key);
    expect(finder, findsOneWidget, reason: 'Could not find key: $key');
    await tap(finder);
    await pump();
  }
}

/// Common test data helpers
class TestData {
  /// Creates a confession with optional items
  static Future<int> createConfession(
    AppDatabase db, {
    bool isFinished = true,
    DateTime? date,
    int itemCount = 0,
  }) async {
    final confessionId = await db.into(db.confessions).insert(
          ConfessionsCompanion.insert(
            date: Value(date ?? DateTime.now()),
            isFinished: Value(isFinished),
            finishedAt: isFinished ? Value(DateTime.now()) : const Value.absent(),
          ),
        );

    for (int i = 0; i < itemCount; i++) {
      await db.into(db.confessionItems).insert(
            ConfessionItemsCompanion.insert(
              confessionId: confessionId,
              content: 'Test item $i',
            ),
          );
    }

    return confessionId;
  }

  /// Creates a penance for a confession
  static Future<int> createPenance(
    AppDatabase db, {
    required int confessionId,
    String description = 'Test penance',
    bool isCompleted = false,
  }) async {
    final penanceId = await db.into(db.penances).insert(
          PenancesCompanion.insert(
            confessionId: confessionId,
            description: description,
          ),
        );

    if (isCompleted) {
      await (db.update(db.penances)..where((t) => t.id.equals(penanceId))).write(
            PenancesCompanion(
              isCompleted: const Value(true),
              completedAt: Value(DateTime.now()),
            ),
          );
    }

    return penanceId;
  }

  /// Creates a custom sin
  static Future<int> createCustomSin(
    AppDatabase db, {
    required String sinText,
    String? commandmentCode,
    String? note,
  }) async {
    return await db.into(db.userCustomSins).insert(
          UserCustomSinsCompanion.insert(
            sinText: sinText,
            commandmentCode: Value(commandmentCode),
            note: Value(note),
          ),
        );
  }
}
