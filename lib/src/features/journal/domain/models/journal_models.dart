import 'package:confessionapp/src/core/database/app_database.dart';

/// How the user felt spiritually on a given day.
///
/// Stored as 1-5 so the value is stable across languages and releases; the
/// label and colour are resolved in the UI.
enum Mood {
  desolate(1),
  struggling(2),
  steady(3),
  grateful(4),
  consoled(5);

  const Mood(this.value);

  final int value;

  static Mood? fromValue(int? value) {
    if (value == null) return null;
    for (final mood in Mood.values) {
      if (mood.value == value) return mood;
    }
    return null;
  }
}

/// A journal entry together with the sins marked on it.
class JournalDay {
  const JournalDay({required this.entry, required this.marks});

  final JournalEntry entry;
  final List<JournalSinMark> marks;

  Mood? get mood => Mood.fromValue(entry.mood);

  /// Whether the user actually wrote or marked anything.
  ///
  /// An entry row can exist while still empty, because it is created as soon as
  /// the user opens the day and autosave begins.
  bool get isEmpty =>
      marks.isEmpty &&
      (entry.gratitude?.trim().isEmpty ?? true) &&
      (entry.reflection?.trim().isEmpty ?? true) &&
      (entry.resolution?.trim().isEmpty ?? true) &&
      entry.mood == null;

  bool get isNotEmpty => !isEmpty;
}

/// How often the user marked sins under one commandment.
///
/// The commandment is kept as its number (language neutral); the name is
/// resolved from the current content language when it is shown.
class StruggleArea {
  const StruggleArea({required this.commandmentNo, required this.count});

  final int commandmentNo;
  final int count;
}

/// A sin marked in the journal, resolved for display.
///
/// [JournalSinMark.questionKey] is language-neutral, so the text shown is
/// whatever the current content language says today — the mark itself does not
/// go stale when the user switches language.
class ResolvedSinMark {
  const ResolvedSinMark({
    required this.mark,
    required this.text,
  });

  final JournalSinMark mark;

  /// Display text, resolved from the current content language.
  final String text;

  /// True once the mark has been carried into a finished confession.
  bool get isAbsolved => mark.confessedInConfessionId != null;
}
