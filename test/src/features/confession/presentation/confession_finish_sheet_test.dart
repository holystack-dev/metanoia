import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:confessionapp/src/features/confession/data/penance_repository.dart';
import 'package:confessionapp/src/features/confession/presentation/confession_screen.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../helpers/test_app.dart';

/// The finish-confession sheet against a penance already captured in
/// confession-day mode: it must show that penance back rather than ask for it
/// again, and the field must be the single source of truth on finishing.
void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    Animate.restartOnHotReload = false;
    Animate.defaultDuration = Duration.zero;
  });

  late TestAppDatabase db;

  setUp(() {
    // The confession screen starts its showcase overlay on first build, which
    // would swallow every tap in this test.
    SharedPreferences.setMockInitialValues({
      'confession_tutorial_shown': true,
      'onboarding_completed': true,
    });
    db = TestAppDatabase();
  });

  tearDown(() async {
    await db.close();
  });

  Future<int> createActiveConfession() async {
    final confessionId = await db
        .into(db.confessions)
        .insert(ConfessionsCompanion.insert(isFinished: const Value(false)));
    await db
        .into(db.confessionItems)
        .insert(
          ConfessionItemsCompanion.insert(
            confessionId: confessionId,
            content: 'I lied to a friend',
          ),
        );
    return confessionId;
  }

  Widget screenUnder() {
    return ProviderScope(
      overrides: [appDatabaseProvider.overrideWithValue(db)],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        theme: AppTheme.lightTheme,
        home: const ConfessionScreen(),
      ),
    );
  }

  /// Tears the tree down inside the test body so Drift's zero-duration
  /// stream-close timer runs before the test ends.
  Future<void> disposeTree(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 100));
  }

  Future<void> openFinishSheet(WidgetTester tester) async {
    await tester.tap(find.text('Finish Confession'));
    await tester.pumpAndSettle();
  }

  /// The sheet's penance field: the only [TextField] in the tree once it is open.
  TextField penanceField(WidgetTester tester) =>
      tester.widget<TextField>(find.byType(TextField));

  testWidgets('pre-fills the penance already captured in day mode', (
    tester,
  ) async {
    final confessionId = await createActiveConfession();
    await PenanceRepository(db).addPenance(confessionId, 'Three Hail Marys');

    await tester.pumpWidget(screenUnder());
    await tester.pumpAndSettle();
    await openFinishSheet(tester);

    expect(penanceField(tester).controller!.text, 'Three Hail Marys');

    // Presented as the recorded penance, not an empty optional field.
    expect(find.text('Penance'), findsWidgets);
    expect(find.text('Add Penance'), findsNothing);
    expect(find.text('(skip)'), findsNothing);

    await disposeTree(tester);
  });

  testWidgets('finishing without touching the field keeps that penance', (
    tester,
  ) async {
    final confessionId = await createActiveConfession();
    await PenanceRepository(db).addPenance(confessionId, 'Three Hail Marys');

    await tester.pumpWidget(screenUnder());
    await tester.pumpAndSettle();
    await openFinishSheet(tester);

    await tester.tap(find.text('Finish'));
    await tester.pumpAndSettle();

    await disposeTree(tester);

    // One row, unchanged: not duplicated, not overwritten.
    final penances = await PenanceRepository(db).getPendingPenances();
    expect(penances, hasLength(1));
    expect(penances.single.penance.description, 'Three Hail Marys');
    expect(penances.single.penance.confessionId, confessionId);
  });

  testWidgets('editing the pre-filled penance updates it in place', (
    tester,
  ) async {
    final confessionId = await createActiveConfession();
    await PenanceRepository(db).addPenance(confessionId, 'Three Hail Marys');

    await tester.pumpWidget(screenUnder());
    await tester.pumpAndSettle();
    await openFinishSheet(tester);

    await tester.enterText(find.byType(TextField), 'One Our Father');
    await tester.pump();
    await tester.tap(find.text('Finish'));
    await tester.pumpAndSettle();

    await disposeTree(tester);

    final penances = await PenanceRepository(db).getPendingPenances();
    expect(penances, hasLength(1));
    expect(penances.single.penance.description, 'One Our Father');
  });

  testWidgets('clearing the pre-filled penance removes it', (tester) async {
    // The field is pre-filled, so clearing it means "no penance to track"
    // and must remove the row.
    final confessionId = await createActiveConfession();
    await PenanceRepository(db).addPenance(confessionId, 'Three Hail Marys');

    await tester.pumpWidget(screenUnder());
    await tester.pumpAndSettle();
    await openFinishSheet(tester);

    await tester.enterText(find.byType(TextField), '');
    await tester.pump();

    // A late Drift emission must not seed the field back.
    expect(penanceField(tester).controller!.text, isEmpty);

    await tester.tap(find.text('Finish'));
    await tester.pumpAndSettle();

    await disposeTree(tester);

    expect(await PenanceRepository(db).getPendingPenances(), isEmpty);
  });

  testWidgets('still offers to add a penance when none was captured', (
    tester,
  ) async {
    final confessionId = await createActiveConfession();

    await tester.pumpWidget(screenUnder());
    await tester.pumpAndSettle();
    await openFinishSheet(tester);

    expect(penanceField(tester).controller!.text, isEmpty);
    expect(find.text('Add Penance'), findsOneWidget);
    expect(find.text('(skip)'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Read Psalm 51');
    await tester.pump();
    await tester.tap(find.text('Finish'));
    await tester.pumpAndSettle();

    await disposeTree(tester);

    final penances = await PenanceRepository(db).getPendingPenances();
    expect(penances, hasLength(1));
    expect(penances.single.penance.description, 'Read Psalm 51');
    expect(penances.single.penance.confessionId, confessionId);
  });
}
