import 'package:confessionapp/src/features/authentication/data/auth_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late AuthRepository repository;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    FlutterSecureStorage.setMockInitialValues({});
    repository = AuthRepository();
  });

  group('PIN', () {
    test('is not set initially', () async {
      expect(await repository.isPinSet(), isFalse);
    });

    test('verifies a saved PIN and rejects a wrong one', () async {
      await repository.savePin('123456');

      expect(await repository.isPinSet(), isTrue);
      expect(await repository.verifyPin('123456'), isTrue);
      expect(await repository.verifyPin('654321'), isFalse);
    });

    test('two identical PINs hash differently (salted)', () async {
      await repository.savePin('123456');
      final firstHash = await const FlutterSecureStorage().read(key: 'pin_hash');

      await repository.savePin('123456');
      final secondHash = await const FlutterSecureStorage().read(key: 'pin_hash');

      expect(firstHash, isNot(secondHash));
    });
  });

  group('changePin', () {
    test('changes the PIN when the current one is correct', () async {
      await repository.savePin('111111');

      expect(await repository.changePin('111111', '222222'), isTrue);
      expect(await repository.verifyPin('222222'), isTrue);
    });

    test('rejects a wrong current PIN', () async {
      await repository.savePin('111111');

      expect(await repository.changePin('999999', '222222'), isFalse);
      expect(await repository.verifyPin('111111'), isTrue);
    });

    test('counts failed attempts against the lockout', () async {
      // Unthrottled, change PIN would be an unlimited guessing oracle.
      await repository.savePin('111111');

      for (var i = 0; i < 5; i++) {
        await repository.changePin('999999', '222222');
      }

      expect(await repository.getFailedAttempts(), 5);
      expect(await repository.isLockoutExpired(), isFalse);
    });

    test('refuses to run at all while locked out', () async {
      await repository.savePin('111111');
      await repository.setLockoutFromAttempts(5);

      // Even the correct PIN must not be accepted during a lockout, otherwise
      // the lockout can be waited out on the lock screen but bypassed here.
      expect(await repository.changePin('111111', '222222'), isFalse);
      expect(await repository.verifyPin('111111'), isTrue);
    });
  });

  group('progressive lockout', () {
    test('does not lock out below 5 attempts', () async {
      expect(await repository.setLockoutFromAttempts(4), isNull);
      expect(await repository.isLockoutExpired(), isTrue);
    });

    test('locks out at 5 attempts and escalates with more', () async {
      final first = await repository.setLockoutFromAttempts(5);
      final later = await repository.setLockoutFromAttempts(9);

      expect(first, isNotNull);
      expect(later, isNotNull);
      // 9 attempts must buy a longer lockout than 5.
      expect(
        later!.difference(DateTime.now()),
        greaterThan(first!.difference(DateTime.now())),
      );
    });

    test('survives a clock rolled backwards', () async {
      await repository.setLockoutFromAttempts(5);

      // Simulating tampering: rewind the recorded start to the future, which is
      // what a backwards clock jump looks like from the app's point of view.
      await const FlutterSecureStorage().write(
        key: 'auth_lockout_start',
        value: DateTime.now().add(const Duration(days: 1)).toIso8601String(),
      );

      expect(await repository.isLockoutExpired(), isFalse);
    });

    test('resetFailedAttempts clears both the count and the lockout', () async {
      await repository.setLockoutFromAttempts(7);
      await repository.resetFailedAttempts();

      expect(await repository.getFailedAttempts(), 0);
      expect(await repository.getLockoutEnd(), isNull);
      expect(await repository.isLockoutExpired(), isTrue);
    });
  });

  group('progressive lockout table', () {
    // The injected clock is what makes this testable at all: asserting the
    // 30-minute tier against the real clock would mean a 30-minute test.
    late DateTime now;
    late AuthRepository clocked;

    setUp(() {
      now = DateTime(2026, 7, 12, 9, 0);
      clocked = AuthRepository(clock: () => now);
    });

    void advance(Duration by) => now = now.add(by);

    const expectedTiers = {
      5: Duration(seconds: 30),
      6: Duration(minutes: 1),
      7: Duration(minutes: 5),
      8: Duration(minutes: 15),
      9: Duration(minutes: 30),
      12: Duration(minutes: 30), // saturates at the last tier
    };

    expectedTiers.forEach((attempts, duration) {
      test('$attempts attempts locks out for $duration', () async {
        final end = await clocked.setLockoutFromAttempts(attempts);

        expect(end, now.add(duration));

        // Still locked one second before the window closes...
        advance(duration - const Duration(seconds: 1));
        expect(await clocked.isLockoutExpired(), isFalse);

        // ...and released once it has passed.
        advance(const Duration(seconds: 2));
        expect(await clocked.isLockoutExpired(), isTrue);
      });
    });

    test('a clock moved backwards does not release the lockout', () async {
      await clocked.setLockoutFromAttempts(9);

      // A recorded start in the future means the clock cannot be trusted, so
      // the lockout holds.
      now = now.subtract(const Duration(days: 1));

      expect(await clocked.isLockoutExpired(), isFalse);
    });
  });

  group('failed attempts storage', () {
    test('migrates a legacy count out of SharedPreferences', () async {
      // Legacy builds kept this in plaintext prefs, which a rooted device can
      // reset.
      SharedPreferences.setMockInitialValues({'auth_failed_attempts': 3});

      expect(await repository.getFailedAttempts(), 3);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getInt('auth_failed_attempts'), isNull);
      expect(
        await const FlutterSecureStorage().read(key: 'auth_failed_attempts'),
        '3',
      );
    });

    test('increments and persists', () async {
      expect(await repository.incrementFailedAttempts(), 1);
      expect(await repository.incrementFailedAttempts(), 2);
      expect(await repository.getFailedAttempts(), 2);
    });
  });
}
