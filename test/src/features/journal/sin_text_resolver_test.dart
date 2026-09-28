import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/features/journal/presentation/journal_entry_controller.dart';
import 'package:flutter_test/flutter_test.dart';

/// Marks store a language-neutral key and a text *snapshot*, never being the
/// source of truth for standard questions (those follow the content language).
/// The snapshot exists so a marked sin never blanks out when its source is
/// edited or deleted — losing a marked sin is a pastoral failure.
void main() {
  JournalSinMark mark({
    String? questionKey,
    int? customSinId,
    String? freeText,
    String? snapshot,
  }) {
    return JournalSinMark(
      id: 1,
      entryId: 1,
      questionKey: questionKey,
      customSinId: customSinId,
      freeText: freeText,
      sinTextSnapshot: snapshot,
      commandmentNo: null,
      createdAt: DateTime(2026, 7, 16),
    );
  }

  test('a standard question follows the current content language, not the '
      'snapshot', () {
    const resolver = SinTextResolver(
      questionTexts: {'01-001': 'Live translation'},
      customSinTexts: {},
    );

    final resolved = resolver.resolve(
      mark(questionKey: '01-001', snapshot: 'Old snapshot'),
    );
    expect(resolved.text, 'Live translation');
  });

  test('a deleted custom sin falls back to its snapshot instead of blanking',
      () {
    // The custom sin the mark points at is gone, so customSinTexts has no entry.
    const resolver = SinTextResolver(questionTexts: {}, customSinTexts: {});

    final resolved = resolver.resolve(
      mark(customSinId: 42, snapshot: 'I gossiped about a coworker'),
    );
    expect(resolved.text, 'I gossiped about a coworker');
    expect(resolved.text, isNotEmpty);
  });

  test('a removed standard question falls back to its snapshot, not the raw key',
      () {
    const resolver = SinTextResolver(questionTexts: {}, customSinTexts: {});

    final resolved = resolver.resolve(
      mark(questionKey: '99-999', snapshot: 'Have I neglected prayer?'),
    );
    expect(resolved.text, 'Have I neglected prayer?');
  });

  test('free text still resolves to itself', () {
    const resolver = SinTextResolver(questionTexts: {}, customSinTexts: {});
    final resolved = resolver.resolve(mark(freeText: 'said too much'));
    expect(resolved.text, 'said too much');
  });
}
