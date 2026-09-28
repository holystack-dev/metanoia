import 'package:confessionapp/src/core/utils/localized_asset_loader.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  String faqPath(String key) => 'assets/data/faqs/faqs_$key.json';

  test('loads the requested language when its asset exists', () async {
    final content = await loadLocalizedJsonArray('es', faqPath);

    expect(content, isNotEmpty);
  });

  test('falls back to English when the language has no asset', () async {
    // 'zz' has no bundled content; it must fall back rather than throw.
    final fallback = await loadLocalizedJsonArray('zz', faqPath);
    final english = await loadLocalizedJsonArray('en', faqPath);

    expect(fallback, isNotEmpty);
    expect(fallback.length, english.length);
  });

  test('still throws if even the English asset is missing', () async {
    // A genuinely broken path must not be silently swallowed.
    expect(
      loadLocalizedAsset('en', (key) => 'assets/data/nope/nope_$key.json'),
      throwsA(anything),
    );
  });
}
