# Test Suite

This directory contains the test suite for the Confession App.

## Test Structure

```
test/
├── helpers/
│   └── test_app.dart          # Shared test utilities and helpers
├── src/
│   └── features/
│       ├── confession/
│       │   ├── data/
│       │   │   ├── confession_repository_test.dart
│       │   │   ├── confession_analytics_repository_test.dart
│       │   │   └── penance_repository_test.dart
│       │   └── presentation/
│       │       └── penance_screen_test.dart (skipped - see below)
│       └── examination/
│           ├── data/
│           │   └── user_custom_sins_repository_test.dart
│           └── presentation/
│               └── examination_controller_test.dart
└── README.md
```

## Running Tests

```bash
# Run all tests
flutter test

# Run a specific test file
flutter test test/src/features/confession/data/confession_repository_test.dart

# Run tests with coverage
flutter test --coverage
```

## Test Coverage

| Component | Tests | Description |
|-----------|-------|-------------|
| ConfessionRepository | 16 | CRUD operations, draft handling, history management |
| PenanceRepository | 10 | Penance creation, completion, listing |
| ConfessionAnalyticsRepository | 6 | Statistics and analytics calculations |
| UserCustomSinsRepository | 8 | Custom sin management and grouping |
| ExaminationController | 9 | State management, draft persistence |

**Total: 50 tests**

## Test Helpers

The `test/helpers/test_app.dart` file provides:

- `TestAppDatabase` - In-memory database for testing (skips content sync)
- `TestApp` - Widget wrapper with localization and Riverpod setup
- `createTestApp()` - Helper to create test app with database override
- `setupTestEnvironment()` - Initialize test bindings and mocks
- `TestData` - Factory methods for creating test data (confessions, penances, custom sins)
- `WidgetTesterExtension` - Convenience methods for widget testing

## Known Limitations

### Widget Tests with flutter_animate

Widget tests for screens using `flutter_animate` are currently skipped due to a timer issue:

- The `flutter_animate` package creates internal timers in `_AnimateState._restart`
- These timers cannot be disabled through standard Flutter testing mechanisms
- Neither `Animate.defaultDuration = Duration.zero` nor `TickerMode(enabled: false)` resolve this

**Affected screens:**
- PenanceScreen
- ConfessionScreen
- HomeScreen
- ExaminationScreen
- And others using `.animate()` extensions

**Workarounds to enable widget tests:**
1. Remove `flutter_animate` from screens to be tested
2. Add a test mode flag to conditionally disable animations in the app
3. Use integration tests instead of widget tests for animated screens

## Writing New Tests

### Data Layer Tests

```dart
import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late ProviderContainer container;

  setUp(() {
    db = TestAppDatabase(NativeDatabase.memory());
    container = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
    );
  });

  tearDown(() async {
    await db.close();
    container.dispose();
  });

  test('example test', () async {
    final repository = container.read(yourRepositoryProvider);
    // Test your repository methods
  });
}

class TestAppDatabase extends AppDatabase {
  TestAppDatabase(super.e);

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async {
      await m.createAll();
      // Skip syncContent() for faster tests
    },
  );
}
```

### Widget Tests (for non-animated screens)

```dart
import 'package:flutter_test/flutter_test.dart';
import '../../../helpers/test_app.dart';

void main() {
  late TestAppDatabase db;

  setUpAll(() async {
    await setupTestEnvironment();
  });

  setUp(() {
    db = TestAppDatabase();
  });

  tearDown(() async {
    await db.close();
  });

  testWidgets('example widget test', (tester) async {
    await tester.pumpWidget(
      createTestApp(
        database: db,
        child: const YourScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Expected Text'), findsOneWidget);
  });
}
```
