import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/router/route_guard.dart';
import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:confessionapp/src/features/authentication/domain/models/auth_settings.dart';
import 'package:confessionapp/src/features/confession/data/penance_repository.dart';
import 'package:confessionapp/src/features/confession/presentation/confession_day_mode_screen.dart';
import 'package:confessionapp/src/features/guide/presentation/prayers_screen.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

import '../../../../helpers/test_app.dart';

void main() {
  setUpAll(setupTestEnvironment);

  late TestAppDatabase db;

  setUp(() {
    db = TestAppDatabase();
  });

  tearDown(() async {
    await db.close();
  });

  const prayerText = 'O My God, I am sorry for my sins with all my heart.';

  /// The bundled prayers content, stubbed: the screen must find the Act of
  /// Contrition by id inside whatever the prayers loader returns.
  final prayers = PrayersContent(
    subtitle: 'Prayers',
    categories: [
      PrayerCategory(
        id: 'confession',
        title: 'Prayers for Confession',
        icon: 'church_outlined',
        prayers: [
          PrayerItem(
            id: 'act_of_contrition',
            title: 'Act of Contrition',
            icon: 'favorite_outline',
            content: prayerText,
          ),
        ],
      ),
    ],
  );

  Future<int> createActiveConfession() async {
    final confessionId = await db
        .into(db.confessions)
        .insert(ConfessionsCompanion.insert(isFinished: const Value(false)));
    for (final sin in ['I lied to a friend', 'I missed Sunday Mass']) {
      await db
          .into(db.confessionItems)
          .insert(
            ConfessionItemsCompanion.insert(
              confessionId: confessionId,
              content: sin,
            ),
          );
    }
    return confessionId;
  }

  /// Built by hand rather than with [createTestApp], which mutes tickers: this
  /// screen pages between its steps with a real `PageController` animation, and
  /// a muted ticker would never let it arrive.
  Widget screenUnder(ThemeData theme) {
    return ProviderScope(
      overrides: [
        appDatabaseProvider.overrideWithValue(db),
        prayersContentProvider.overrideWith((ref) async => prayers),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en'),
        theme: theme,
        home: const ConfessionDayModeScreen(),
      ),
    );
  }

  /// Tears the tree down inside the test body and lets Drift's stream-close
  /// timer (a zero-duration one, fired when the provider container disposes)
  /// run, instead of leaving it pending past the end of the test.
  Future<void> disposeTree(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 100));
  }

  final themes = {'light': AppTheme.lightTheme, 'dark': AppTheme.darkTheme};

  for (final entry in themes.entries) {
    testWidgets('renders every step in the ${entry.key} theme', (tester) async {
      await createActiveConfession();
      await tester.pumpWidget(screenUnder(entry.value));
      await tester.pumpAndSettle();

      // Step 1: the opening formula, with the interval since the last
      // confession (unknown here — there is no earlier finished confession).
      expect(find.text('Bless me, Father, for I have sinned.'), findsOneWidget);
      expect(find.text('Step 1 of 5'), findsOneWidget);

      // Step 2: the sins of the active confession, ending with the line the
      // penitent says once the sins are told.
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      expect(find.text('I lied to a friend'), findsOneWidget);
      expect(find.text('I missed Sunday Mass'), findsOneWidget);
      expect(
        find.text('For these and all my sins, I am truly sorry.'),
        findsOneWidget,
      );

      // Step 3: the Act of Contrition (prayed after confessing), in large serif.
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      expect(find.text('Act of Contrition'), findsOneWidget);
      expect(find.text(prayerText), findsOneWidget);

      final prayerStyle = tester.widget<Text>(find.text(prayerText)).style!;
      expect(prayerStyle.fontFamily, AppTheme.fontFamilyEBGaramond);
      // Well above normal body text, and derived from the theme's own body size
      // so the app-wide font-size textScaler still applies on top.
      final bodyStyle =
          Theme.of(tester.element(find.text(prayerText))).textTheme.bodyLarge!;
      expect(
        prayerStyle.fontSize,
        greaterThan((bodyStyle.fontSize ?? 16) * 1.4),
      );

      // Step 4: penance capture.
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      expect(find.text('What penance were you given?'), findsOneWidget);
      expect(find.text('Save Penance'), findsOneWidget);

      // Step 5: the thanksgiving at dismissal.
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
      expect(
        find.text('Give thanks to the Lord, for He is good.'),
        findsOneWidget,
      );

      await disposeTree(tester);
    });
  }

  testWidgets('saves the penance to the active confession', (tester) async {
    final confessionId = await createActiveConfession();
    await tester.pumpWidget(screenUnder(AppTheme.lightTheme));
    await tester.pumpAndSettle();

    // Opening -> Sins -> Act of Contrition -> Penance (step 4).
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Three Hail Marys');
    await tester.pump();
    await tester.tap(find.text('Save Penance'));
    await tester.pumpAndSettle();

    await disposeTree(tester);

    final penances = await PenanceRepository(db).getPendingPenances();
    expect(penances, hasLength(1));
    expect(penances.single.penance.description, 'Three Hail Marys');
    expect(penances.single.penance.confessionId, confessionId);
  });

  testWidgets('Done saves an unsaved penance instead of discarding it', (
    tester,
  ) async {
    // The realistic flow in a dim confessional: type the penance, then tap the
    // big filled button at the bottom, skipping the smaller "Save Penance"
    // control above it. The penance must not be lost.
    final confessionId = await createActiveConfession();
    await tester.pumpWidget(screenUnder(AppTheme.lightTheme));
    await tester.pumpAndSettle();

    // Opening -> Sins -> Act of Contrition -> Penance (step 4).
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'One Our Father');
    await tester.pump();

    // On to the thanksgiving step, then Done — "Save Penance" is never tapped,
    // and the penance step has scrolled out of view. It must still be saved (the
    // page is kept alive precisely so leaving cannot silently drop it).
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();

    await disposeTree(tester);

    final penances = await PenanceRepository(db).getPendingPenances();
    expect(penances, hasLength(1));
    expect(penances.single.penance.description, 'One Our Father');
    expect(penances.single.penance.confessionId, confessionId);
  });

  testWidgets('Done writes no penance when the field was left empty', (
    tester,
  ) async {
    await createActiveConfession();
    await tester.pumpWidget(screenUnder(AppTheme.lightTheme));
    await tester.pumpAndSettle();

    // Page through to the final (thanksgiving) step without touching penance.
    for (var i = 0; i < 4; i++) {
      await tester.tap(find.text('Next'));
      await tester.pumpAndSettle();
    }
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();

    await disposeTree(tester);

    expect(await PenanceRepository(db).getPendingPenances(), isEmpty);
  });

  testWidgets('saving twice updates the penance rather than duplicating it', (
    tester,
  ) async {
    await createActiveConfession();
    await tester.pumpWidget(screenUnder(AppTheme.lightTheme));
    await tester.pumpAndSettle();

    // Opening -> Sins -> Act of Contrition -> Penance (step 4).
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Three Hail Marys');
    await tester.pump();
    await tester.tap(find.text('Save Penance'));
    await tester.pumpAndSettle();

    // Let the confirmation snack bar go away: it sits over the step controls.
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    // The priest said a decade, not three Hail Marys.
    await tester.enterText(find.byType(TextField), 'A decade of the Rosary');
    await tester.pump();
    // On to the thanksgiving step, then Done — the correction is flushed.
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();

    await disposeTree(tester);

    final penances = await PenanceRepository(db).getPendingPenances();
    expect(penances, hasLength(1));
    expect(penances.single.penance.description, 'A decade of the Rosary');
  });

  group('opening step, second line', () {
    testWidgets('is a fill-in-the-blank template with nothing on record', (
      tester,
    ) async {
      // With nothing on record the line must stay a template for the penitent
      // to complete, not assert an interval the app cannot know.
      await createActiveConfession();
      await tester.pumpWidget(screenUnder(AppTheme.lightTheme));
      await tester.pumpAndSettle();

      expect(
        find.text('It has been [days/weeks/months/years] since my last '
            'confession.'),
        findsOneWidget,
      );
      // No date hint: there is no date to offer.
      expect(find.textContaining('Last Confession:'), findsNothing);

      await disposeTree(tester);
    });

    testWidgets('states the real interval and the exact date on record', (
      tester,
    ) async {
      // 21 days ago: the spoken line rounds to "3 weeks", the hint underneath
      // carries the exact date.
      final finishedAt = DateTime.now().subtract(const Duration(days: 21));
      await db
          .into(db.confessions)
          .insert(
            ConfessionsCompanion.insert(
              date: Value(finishedAt),
              isFinished: const Value(true),
              finishedAt: Value(finishedAt),
            ),
          );
      await createActiveConfession();

      await tester.pumpWidget(screenUnder(AppTheme.lightTheme));
      await tester.pumpAndSettle();

      expect(
        find.text('It has been 3 weeks since my last confession.'),
        findsOneWidget,
      );
      expect(
        find.text('Last Confession: ${DateFormat.yMMMMd('en').format(
          finishedAt,
        )}'),
        findsOneWidget,
      );

      await disposeTree(tester);
    });
  });

  test('confession-day mode is a PIN-guarded route', () {
    expect(
      resolveRedirect(
        onboardingCompleted: true,
        authStatus: AuthStatus.pinSetupDeferred,
        location: '/confess/day-mode',
      ),
      isNotNull,
    );
  });
}
