import 'dart:convert';

import 'package:confessionapp/src/core/constants/content_markers.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Scripture and saint quotes are identified by content tags, not by matching
/// English book or saint names, so their styling works in every language.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  /// Malayalam is not tagged: its files are not line-aligned with
  /// the others, so it still uses the (Malayalam-aware) heuristic.
  const taggedLanguages = [
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'id',
    'it',
    'ko',
    'pl',
    'pt_BR',
    'ta',
    'tl',
    'vi',
  ];

  Future<List<dynamic>> loadFaqs(String lang) async {
    final raw = await rootBundle.loadString('assets/data/faqs/faqs_$lang.json');
    return jsonDecode(raw) as List<dynamic>;
  }

  test('every tagged language marks the same quotes', () async {
    final counts = <String, (int, int)>{};

    for (final lang in taggedLanguages) {
      final faqs = await loadFaqs(lang);
      var scripture = 0;
      var saint = 0;

      for (final item in faqs) {
        final content = item['content'] as String;
        scripture += kScriptureMarker.allMatches(content).length;
        saint += kSaintMarker.allMatches(content).length;
      }
      counts[lang] = (scripture, saint);
    }

    // Whatever English tags, every other language must tag too, or a
    // translation silently loses its styling.
    final english = counts['en']!;
    expect(english.$1, greaterThan(0), reason: 'no scripture tagged at all');
    expect(english.$2, greaterThan(0), reason: 'no saint quotes tagged at all');

    for (final entry in counts.entries) {
      expect(
        entry.value,
        english,
        reason: '${entry.key} does not tag the same quotes as English',
      );
    }
  });

  test('a line is never tagged as both scripture and a saint', () async {
    for (final lang in taggedLanguages) {
      for (final item in await loadFaqs(lang)) {
        for (final line in (item['content'] as String).split('\n')) {
          expect(
            line.contains(kScriptureMarker) && line.contains(kSaintMarker),
            isFalse,
            reason: 'ambiguous tagging in $lang: $line',
          );
        }
      }
    }
  });

  group('the Amen of every language is tagged', () {
    const allLanguages = [
      'de', 'en', 'es', 'fr', 'hi', 'id', 'it', 'ko',
      'ml', 'pl', 'pt_BR', 'ta', 'tl', 'vi',
    ];

    Future<String> loadPrayers(String lang) {
      return rootBundle.loadString('assets/data/prayers/prayers_$lang.json');
    }

    test('every language tags at least one Amen', () async {
      // Matching the literal 'Amen.' would miss Spanish ("Amén."), Portuguese
      // ("Amém."), Indonesian, Korean, Malayalam, Tamil and Hindi.
      for (final lang in allLanguages) {
        final raw = await loadPrayers(lang);

        expect(
          raw.contains(kAmenMarker),
          isTrue,
          reason: 'no Amen tagged in $lang',
        );
      }
    });

    test('a tagged Amen is short — it is a closing word, not a paragraph',
        () async {
      for (final lang in allLanguages) {
        final json = jsonDecode(await loadPrayers(lang)) as Map<String, dynamic>;

        for (final category in json['categories'] as List<dynamic>) {
          for (final prayer in category['prayers'] as List<dynamic>) {
            final content = prayer['content'] as String?;
            if (content == null) continue;

            for (final line in content.split('\n')) {
              if (!line.contains(kAmenMarker)) continue;

              expect(
                stripContentMarkers(line).length,
                lessThanOrEqualTo(14),
                reason: 'a whole paragraph was tagged as the Amen in $lang',
              );
            }
          }
        }
      }
    });
  });

  group('stripContentMarkers', () {
    test('removes every marker', () {
      expect(
        stripContentMarkers('$kScriptureMarker"Come now, let us reason"'),
        '"Come now, let us reason"',
      );
      expect(
        stripContentMarkers('${kSaintMarker}St. Augustine noted: "..."'),
        'St. Augustine noted: "..."',
      );
      expect(
        stripContentMarkers('${kPrayerMarker}O my God'),
        'O my God',
      );
    });

    test('leaves unmarked text exactly as it is', () {
      const text = 'Confession restores the soul.';

      expect(stripContentMarkers(text), text);
    });

    test('no marker survives into displayed FAQ text', () async {
      for (final lang in taggedLanguages) {
        for (final item in await loadFaqs(lang)) {
          final stripped = stripContentMarkers(item['content'] as String);

          for (final marker in kContentMarkers) {
            expect(
              stripped.contains(marker),
              isFalse,
              reason: '$marker leaked into displayed text in $lang',
            );
          }
        }
      }
    });
  });
}
