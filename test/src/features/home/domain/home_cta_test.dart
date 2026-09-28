import 'package:confessionapp/src/features/home/domain/home_cta.dart';
import 'package:flutter_test/flutter_test.dart';

/// The home screen shows exactly one call to action, and which one it is is the
/// whole answer to "what should I do now?". The precedence is therefore worth
/// pinning down: a regression here silently sends the user to the wrong screen.
void main() {
  final now = DateTime(2026, 7, 12, 9);
  final today = DateTime(2026, 7, 12, 7);
  final yesterday = DateTime(2026, 7, 11, 21);

  HomeCta resolve({
    int penances = 0,
    int items = 0,
    DateTime? draftStartedAt,
  }) {
    return resolveHomeCta(
      pendingPenanceCount: penances,
      draftItemCount: items,
      draftStartedAt: draftStartedAt,
      now: now,
    );
  }

  group('precedence', () {
    test('nothing in flight invites an examination', () {
      expect(resolve(), const HomeCta(HomeCtaKind.beginExamination));
    });

    test("a draft started today is a draft to continue, with its count", () {
      expect(
        resolve(items: 3, draftStartedAt: today),
        const HomeCta(HomeCtaKind.continueExamination, count: 3),
      );
    });

    test('a draft left behind on an earlier day means: go and confess', () {
      expect(
        resolve(items: 7, draftStartedAt: yesterday),
        const HomeCta(HomeCtaKind.readyToConfess, count: 7),
      );
    });

    test('a pending penance outranks a draft in progress', () {
      expect(
        resolve(penances: 1, items: 4, draftStartedAt: today),
        const HomeCta(HomeCtaKind.completePenance, count: 1),
      );
    });

    test('a pending penance outranks a finished, unconfessed examination', () {
      expect(
        resolve(penances: 2, items: 4, draftStartedAt: yesterday),
        const HomeCta(HomeCtaKind.completePenance, count: 2),
      );
    });

    test('a pending penance outranks an empty slate', () {
      expect(
        resolve(penances: 3),
        const HomeCta(HomeCtaKind.completePenance, count: 3),
      );
    });
  });

  group('edge cases', () {
    test('an empty draft is not worth resuming', () {
      // The examination screen creates the confession row the moment it opens.
      // A row with nothing selected in it is not a draft the user left behind.
      expect(
        resolve(items: 0, draftStartedAt: today),
        const HomeCta(HomeCtaKind.beginExamination),
      );
    });

    test('a draft started earlier today is still "continue", not "ready"', () {
      // Calendar days, not elapsed hours: this is the same day.
      expect(
        resolve(items: 2, draftStartedAt: DateTime(2026, 7, 12, 0, 1)).kind,
        HomeCtaKind.continueExamination,
      );
    });

    test('a draft with no start date falls back to "continue"', () {
      // Never send someone to the confession list on missing information.
      expect(
        resolve(items: 2).kind,
        HomeCtaKind.continueExamination,
      );
    });

    test('begin carries no count', () {
      expect(resolve().count, 0);
    });
  });
}
