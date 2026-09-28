import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

/// In all 14 languages the streak string must contain the actual number and
/// never a bare "#": this project's gen-l10n setup substitutes only the named
/// `{count}` placeholder, not the ICU "#" token.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('journalStreakDays renders the count, never a literal "#", in all '
      '14 languages', () {
    final failures = <String>[];

    for (final locale in AppLocalizations.supportedLocales) {
      final l10n = lookupAppLocalizations(locale);

      // Cover the singular (one/=1) and plural branches.
      for (final count in const [1, 2, 7, 21]) {
        final text = l10n.journalStreakDays(count);

        if (text.contains('#')) {
          failures.add(
            '${locale.toLanguageTag()} (count=$count): "$text" still '
            'contains a literal "#"',
          );
        }
        if (!text.contains('$count')) {
          failures.add(
            '${locale.toLanguageTag()} (count=$count): "$text" does not '
            'contain the number $count',
          );
        }
      }
    }

    expect(
      failures,
      isEmpty,
      reason: 'Streak strings that lost their number:\n${failures.join('\n')}',
    );
  });
}
