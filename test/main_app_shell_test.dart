import 'package:confessionapp/main.dart';
import 'package:confessionapp/src/features/authentication/domain/models/auth_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// [AppShell] keeps the user's own data (pending-sin count, journal streak,
/// time since last confession) off screen while the app is locked. These tests
/// cover when it covers the app and how completely.

AsyncValue<AuthState> _state(AuthStatus status) =>
    AsyncValue.data(AuthState(status: status));

void main() {
  group('shouldBlockAppContent', () {
    test('blocks every locked state', () {
      for (final status in [AuthStatus.locked, AuthStatus.lockedOut]) {
        expect(
          shouldBlockAppContent(
            authState: _state(status),
            onboardingCompleted: true,
          ),
          isTrue,
          reason: '$status must cover the app',
        );
      }
    });

    test('fails closed while auth is unresolved or errored', () {
      // Every cold start passes through loading. An unreadable keystore lands
      // in error. Neither may render the app underneath.
      expect(
        shouldBlockAppContent(
          authState: const AsyncValue.loading(),
          onboardingCompleted: true,
        ),
        isTrue,
      );
      expect(
        shouldBlockAppContent(
          authState: const AsyncValue.error('keystore gone', StackTrace.empty),
          onboardingCompleted: true,
        ),
        isTrue,
      );
    });

    test('lets an unlocked app through', () {
      expect(
        shouldBlockAppContent(
          authState: _state(AuthStatus.unlocked),
          onboardingCompleted: true,
        ),
        isFalse,
      );
    });

    test(
      'does not block during onboarding, when there is nothing to protect',
      () {
        expect(
          shouldBlockAppContent(
            authState: const AsyncValue.loading(),
            onboardingCompleted: false,
          ),
          isFalse,
        );
      },
    );
  });

  group('AppShell semantics', () {
    // A locked LockScreen needs the auth providers; the loading state renders
    // the plain startup shield instead, and blocks for the same reason, so it
    // exercises the same overlay with no provider setup.
    Widget harness({required AsyncValue<AuthState> authState}) => MaterialApp(
      home: AppShell(
        authState: authState,
        onboardingCompleted: true,
        content: const Scaffold(
          body: Text('1 sin is waiting in your confession list'),
        ),
      ),
    );

    testWidgets('blocked content is not reachable by a screen reader', (
      tester,
    ) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(harness(authState: const AsyncValue.loading()));

      // Still in the widget tree, painted underneath the opaque overlay...
      expect(
        find.text('1 sin is waiting in your confession list'),
        findsOneWidget,
      );
      // ...but dropped from the semantics tree by BlockSemantics, so
      // VoiceOver/TalkBack cannot walk to it.
      expect(
        find.bySemanticsLabel('1 sin is waiting in your confession list'),
        findsNothing,
      );

      handle.dispose();
    });

    testWidgets('unblocked content stays reachable', (tester) async {
      final handle = tester.ensureSemantics();
      await tester.pumpWidget(harness(authState: _state(AuthStatus.unlocked)));

      expect(
        find.bySemanticsLabel('1 sin is waiting in your confession list'),
        findsOneWidget,
      );

      handle.dispose();
    });
  });
}
