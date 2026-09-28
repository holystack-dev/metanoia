import 'package:drift/drift.dart';

// Static Content Tables

class Commandments extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get commandmentNo => integer()();
  TextColumn get content => text()();
  TextColumn get languageCode => text().withDefault(const Constant('en'))();
  TextColumn get code => text().nullable().unique()();
  TextColumn get customTitle => text().nullable()();
}

class ExaminationQuestions extends Table {
  // Stable string ID format: {lang}-{cmdNum}-{questionNum} e.g., "en-1-001"
  TextColumn get id => text()();
  IntColumn get commandmentId => integer().references(Commandments, #id)();
  TextColumn get question => text()();
  TextColumn get languageCode => text().withDefault(const Constant('en'))();

  @override
  Set<Column> get primaryKey => {id};
}

class Faqs extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get heading => text()();
  TextColumn get title => text()();
  TextColumn get content => text()();
  TextColumn get languageCode => text().withDefault(const Constant('en'))();
}

class Quotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get author => text()();
  TextColumn get quote => text()();
  TextColumn get languageCode => text().withDefault(const Constant('en'))();
}

// User Data Tables (Encrypted)

class Confessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isFinished => boolean().withDefault(const Constant(false))();
  DateTimeColumn get finishedAt => dateTime().nullable()();
}

class ConfessionItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get confessionId =>
      integer().references(Confessions, #id, onDelete: KeyAction.cascade)();
  TextColumn get content => text()();

  /// Free-text note on this item. The custom-sin id lives in [customSinId].
  TextColumn get note => text().nullable()();

  BoolColumn get isCustom => boolean().withDefault(const Constant(false))();

  /// The [UserCustomSins] row this item came from, when [isCustom].
  ///
  /// Not a foreign key: existing rows may reference deleted custom sins, and
  /// the constraint would make them unwritable.
  IntColumn get customSinId => integer().nullable()();

  // Reference to examination question by stable string ID (e.g., "en-1-001")
  TextColumn get questionId => text().nullable()();
}

class UserSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get key => text().unique()();
  TextColumn get value => text()();
}

class Prayers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get content => text()();
  IntColumn get displayOrder => integer()();
  TextColumn get languageCode => text()();
}

// User Data Tables - Custom Sins

class UserCustomSins extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sinText => text()();
  TextColumn get note => text().nullable()();

  // Optional: Link to a commandment code (null = standalone/general custom sin)
  TextColumn get commandmentCode => text().nullable()();

  // Track if this is a user's edited version of a pre-existing question
  // If set, this custom sin is shown instead of the original during examination
  // Uses stable string ID (e.g., "en-1-001")
  TextColumn get originalQuestionId => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

// Penance tracking for confessions
class Penances extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get confessionId =>
      integer().references(Confessions, #id, onDelete: KeyAction.cascade)();
  TextColumn get description => text()(); // What penance was given
  BoolColumn get isCompleted =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get completedAt => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// Daily Journal (the traditional "Daily Examen")
//
// One entry per calendar day, sitting between the episodic Examination and the
// Confession itself: a daily habit that feeds better-prepared confessions.

class JournalEntries extends Table {
  IntColumn get id => integer().autoIncrement()();

  /// The calendar day this entry is for, at local midnight.
  ///
  /// Unique — one entry per day, so edits update the same row and the streak
  /// and calendar queries stay trivial.
  DateTimeColumn get entryDate => dateTime()();

  /// "Where did I see God today?"
  TextColumn get gratitude => text().nullable()();

  /// Free reflection on the day.
  TextColumn get reflection => text().nullable()();

  /// An intention for tomorrow.
  TextColumn get resolution => text().nullable()();

  /// Spiritual state, 1-5. Null if the user skipped it.
  IntColumn get mood => integer().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  List<Set<Column>> get uniqueKeys => [
    {entryDate},
  ];
}

class JournalSinMarks extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get entryId =>
      integer().references(JournalEntries, #id, onDelete: KeyAction.cascade)();

  /// Language-neutral question key ("01-001", never "en-01-001"), so marks
  /// survive a content-language change. Display text is resolved at read time.
  TextColumn get questionKey => text().nullable()();

  /// A [UserCustomSins] row, when the mark came from one.
  IntColumn get customSinId => integer().nullable()();

  /// An ad-hoc mark the user typed.
  TextColumn get freeText => text().nullable()();

  /// The display text as it read the moment the sin was marked.
  ///
  /// A fallback, not the source of truth: standard questions resolve to the
  /// current content language at read time. It keeps a mark from disappearing
  /// when its custom sin is later edited or deleted.
  TextColumn get sinTextSnapshot => text().nullable()();

  /// Commandment number, kept denormalised so insights can group by it.
  IntColumn get commandmentNo => integer().nullable()();

  /// Set once this mark has been carried into a finished confession, which is
  /// what lets the journal show it as absolved.
  IntColumn get confessedInConfessionId => integer().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
