import 'package:confessionapp/src/core/router/route_guard.dart';
import 'package:confessionapp/src/features/authentication/domain/models/auth_settings.dart';
import 'package:flutter_test/flutter_test.dart';

/// The onboarding x PIN matrix. A deep link that slips past the guard reaches
/// the user's confessed sins without a PIN.
void main() {
  String? redirectFor(
    String location, {
    bool onboarded = true,
    AuthStatus status = AuthStatus.unlocked,
  }) {
    return resolveRedirect(
      onboardingCompleted: onboarded,
      authStatus: status,
      location: location,
    );
  }

  group('onboarding', () {
    test('sends an un-onboarded user to onboarding, from anywhere', () {
      for (final location in ['/', '/confess', '/settings', '/journal']) {
        expect(
          redirectFor(location, onboarded: false),
          '/onboarding',
          reason: '$location should have redirected to onboarding',
        );
      }
    });

    test('lets an un-onboarded user stay on onboarding', () {
      expect(redirectFor('/onboarding', onboarded: false), isNull);
    });

    test('sends an onboarded user away from onboarding', () {
      expect(redirectFor('/onboarding'), '/');
    });
  });

  group('PIN guard on sensitive routes', () {
    // These are the states in which no PIN exists yet.
    const pinMissing = [
      AuthStatus.pinSetupDeferred,
      AuthStatus.uninitialized,
    ];

    test('every sensitive route is guarded when no PIN is set', () {
      for (final status in pinMissing) {
        for (final route in sensitiveRoutes) {
          final redirect = redirectFor(route, status: status);

          expect(
            redirect,
            isNotNull,
            reason: '$route was reachable with status $status',
          );
          expect(redirect, startsWith('/pin-setup?redirect='));
        }
      }
    });

    test('guards nested paths under a sensitive route, not just the root', () {
      // A deep link goes straight to the leaf.
      for (final route in [
        '/confess/history',
        '/confess/insights',
        '/journal/2026-07-12',
        '/settings/security',
      ]) {
        expect(
          redirectFor(route, status: AuthStatus.pinSetupDeferred),
          isNotNull,
          reason: '$route slipped past the PIN guard',
        );
      }
    });

    test('carries the intended destination through PIN setup', () {
      expect(
        redirectFor('/journal/2026-07-12', status: AuthStatus.pinSetupDeferred),
        '/pin-setup?redirect=${Uri.encodeComponent('/journal/2026-07-12')}',
      );
    });

    test('does not guard non-sensitive routes', () {
      for (final route in [
        '/',
        '/guide',
        '/guide/prayers',
        '/guide/faq',
        '/guide/invitation',
        '/guide/confession',
      ]) {
        expect(
          redirectFor(route, status: AuthStatus.pinSetupDeferred),
          isNull,
          reason: '$route should not require a PIN',
        );
      }
    });

    test('the journal is still guarded now that it is a tab', () {
      // The journal is a `StatefulShellBranch` one tap away; the top-level
      // `redirect` must still guard it, or the user's own writing is exposed
      // without a PIN.
      for (final status in pinMissing) {
        expect(
          redirectFor('/journal', status: status),
          '/pin-setup?redirect=${Uri.encodeComponent('/journal')}',
          reason: 'the journal tab was reachable with status $status',
        );
      }
    });

    test('the tab bar: home is free, the other three tabs are guarded', () {
      // Home / Journal / Examine / Confess.
      expect(redirectFor('/', status: AuthStatus.pinSetupDeferred), isNull);

      for (final tab in ['/journal', '/examine', '/confess']) {
        expect(
          redirectFor(tab, status: AuthStatus.pinSetupDeferred),
          isNotNull,
          reason: '$tab is a tab, and holds the user\'s own data',
        );
      }
    });

    test('never redirects away from PIN setup itself', () {
      // Otherwise the user could never get out of the loop.
      for (final status in pinMissing) {
        expect(redirectFor('/pin-setup', status: status), isNull);
      }
    });

    test('lets a user who has a PIN reach every sensitive route', () {
      for (final status in [
        AuthStatus.unlocked,
        AuthStatus.locked,
        AuthStatus.lockedOut,
      ]) {
        for (final route in sensitiveRoutes) {
          expect(
            redirectFor(route, status: status),
            isNull,
            reason: '$route was blocked for status $status',
          );
        }
      }
    });
  });

  group('the sensitive list itself', () {
    test('covers every screen that shows the user their own data', () {
      // A regression here is silent and serious: a route dropped from this list
      // simply stops being guarded.
      expect(
        sensitiveRoutes,
        containsAll(['/examine', '/confess', '/settings', '/journal']),
      );
    });
  });
}
