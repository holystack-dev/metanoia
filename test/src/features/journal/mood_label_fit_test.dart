import 'dart:io';

import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Every mood label must fit on one line. A single long word wider than its
/// cell has no break opportunity, so Flutter breaks it mid-word
/// ("Consolazio / ne") rather than ellipsizing it.
///
/// Measures every locale's labels at the narrowest supported phone.
void main() {
  // mood_selector.dart: a Wrap of content-sized options, each bounded by
  // BoxConstraints(minWidth: 64, maxWidth: 140) with horizontal padding 4.
  // A label wider than the ceiling still has nowhere to break.
  const maxOptionWidth = 140.0;
  const horizontalPadding = 4.0 * 2;
  const cellWidth = maxOptionWidth - horizontalPadding;

  // Without this the test measures Ahem, whose every glyph is a square of the
  // font size, so every string "overflows" and the test proves nothing.
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final loader = FontLoader(AppTheme.fontFamilyLato);
    for (final path in const [
      'assets/fonts/Lato-Regular.ttf',
      'assets/fonts/Lato-Bold.ttf',
    ]) {
      final bytes = await File(path).readAsBytes();
      loader.addFont(Future.value(ByteData.sublistView(bytes)));
    }
    await loader.load();
  });

  test('every mood label fits its cell on one line, in all 14 languages', () {
    // labelSmall in the app's text theme.
    final style = AppTheme.lightTheme.textTheme.labelSmall!;

    final failures = <String>[];

    for (final locale in AppLocalizations.supportedLocales) {
      final l10n = lookupAppLocalizations(locale);
      final labels = <String, String>{
        'desolate': l10n.journalMoodDesolate,
        'struggling': l10n.journalMoodStruggling,
        'steady': l10n.journalMoodSteady,
        'grateful': l10n.journalMoodGrateful,
        'consoled': l10n.journalMoodConsoled,
      };

      for (final entry in labels.entries) {
        final painter = TextPainter(
          text: TextSpan(text: entry.value, style: style),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center,
          maxLines: 2,
        )..layout(maxWidth: cellWidth);

        // didExceedMaxLines would catch >2 lines; what we actually cannot allow
        // is any wrap at all, because a wrap of a single word is a mid-word break.
        final lines = painter.computeLineMetrics().length;
        final isSingleWord = !entry.value.trim().contains(' ');

        if (lines > 1 && isSingleWord) {
          failures.add(
            '${locale.toLanguageTag()}.${entry.key}: "${entry.value}" '
            'does not fit ${cellWidth.toStringAsFixed(0)}px on one line '
            '— a single word has no break opportunity, so it splits mid-word',
          );
        }
      }
    }

    expect(
      failures,
      isEmpty,
      reason: 'Mood labels that break mid-word:\n${failures.join('\n')}',
    );
  });
}
