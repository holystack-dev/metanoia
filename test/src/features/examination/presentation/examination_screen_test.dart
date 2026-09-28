import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/preferences/preferences_provider.dart';
import 'package:confessionapp/src/features/examination/presentation/examination_screen.dart';
import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../helpers/test_app.dart';

/// Entering the examination must cost nothing: no modal dialog or sheet before
/// the first question. The welcome prompt is an inline, dismissible card and
/// the mode choice is an inline toggle.
void main() {
  late AppDatabase db;
  late SharedPreferences prefs;

  Future<void> pumpExamination(WidgetTester tester) async {
    await tester.pumpWidget(
      createTestApp(
        database: db,
        additionalOverrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: const ExaminationScreen(),
      ),
    );
    // The data future, the draft restore and the mode preference all resolve
    // asynchronously; pumpAndSettle would spin forever on the loading spinner.
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 60));
    }
  }

  /// Tears the tree down inside the test body.
  ///
  /// Drift schedules a zero-duration timer when its query streams are closed by
  /// the ProviderScope's disposal; letting that happen after the body ends trips
  /// the "a Timer is still pending" invariant.
  Future<void> disposeTree(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 10));
  }

  setUp(() async {
    await setupTestEnvironment();
    // The showcase tutorial is a separate concern and would otherwise cover the
    // screen on a first run.
    SharedPreferences.setMockInitialValues({
      'flutter.examination_tutorial_shown': true,
    });
    prefs = await SharedPreferences.getInstance();

    db = TestAppDatabase(NativeDatabase.memory());
    final commandmentId = await db.into(db.commandments).insert(
          CommandmentsCompanion.insert(
            commandmentNo: 1,
            content: 'I am the Lord your God.',
            code: const Value('c1'),
            customTitle: const Value('Commandment 1'),
          ),
        );
    await db.into(db.examinationQuestions).insert(
          ExaminationQuestionsCompanion.insert(
            id: 'en-1-001',
            commandmentId: commandmentId,
            question: 'Have I neglected prayer?',
          ),
        );
  });

  tearDown(() => db.close());

  testWidgets('lands straight in the examination: no dialog, no sheet',
      (tester) async {
    await pumpExamination(tester);

    expect(find.byType(Dialog), findsNothing);
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(BottomSheet), findsNothing);
    // No mode-selection sheet question, no welcome dialog actions.
    expect(find.text('How would you like to examine?'), findsNothing);
    expect(find.text("No, I'm ready to begin"), findsNothing);

    // ...and the questions themselves are readable straight away.
    expect(find.text('Have I neglected prayer?'), findsOneWidget);

    await disposeTree(tester);
  });

  testWidgets('the encouragement offer is an inline card, and it can be '
      'dismissed for good', (tester) async {
    await pumpExamination(tester);

    // The welcome guidance, inline and non-blocking.
    expect(find.text('Before you begin'), findsOneWidget);
    expect(
      find.text(
        'Is this your first confession in a while, or are you feeling anxious '
        'about going?',
      ),
      findsOneWidget,
    );
    expect(find.byType(Dialog), findsNothing);

    await tester.tap(find.text('Not Now'));
    await tester.pump();

    expect(find.text('Before you begin'), findsNothing);
    expect(prefs.getBool('invitation_dialog_dont_show'), isTrue);

    await disposeTree(tester);
  });

  testWidgets('a prior "do not show again" keeps the card away', (tester) async {
    SharedPreferences.setMockInitialValues({
      'flutter.examination_tutorial_shown': true,
      'flutter.invitation_dialog_dont_show': true,
    });
    prefs = await SharedPreferences.getInstance();

    await pumpExamination(tester);

    expect(find.text('Before you begin'), findsNothing);
    expect(find.text('Have I neglected prayer?'), findsOneWidget);

    await disposeTree(tester);
  });

  testWidgets('mode selection is an inline toggle, not a gate', (tester) async {
    await pumpExamination(tester);

    expect(find.text('Quick Review'), findsOneWidget);
    expect(find.text('Deep Reflection'), findsOneWidget);

    // Switching mode swaps the view in place — no sheet, no navigation.
    await tester.tap(find.text('Deep Reflection'));
    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(milliseconds: 60));
    }

    expect(find.byType(BottomSheet), findsNothing);
    // Deep Reflection's answer buttons, in place, with no modal in between.
    expect(find.text('Yes'), findsOneWidget);
    expect(find.text('No'), findsOneWidget);

    await disposeTree(tester);
  });

  testWidgets('the guided view keeps a single progress indicator',
      (tester) async {
    await pumpExamination(tester);

    // No "1 of 1" badge or "0 selected" AppBar pill: nothing is counted until
    // something is named.
    expect(find.text('1 of 1'), findsNothing);
    expect(find.text('0 selected'), findsNothing);
    expect(find.textContaining('named so far'), findsNothing);

    await tester.tap(find.text('Have I neglected prayer?'));
    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(milliseconds: 60));
    }

    expect(find.text('One named so far'), findsOneWidget);
  
    await disposeTree(tester);
  });
}
