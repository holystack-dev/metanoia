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
  TextColumn get note => text().nullable()();
  BoolColumn get isCustom => boolean().withDefault(const Constant(false))();
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
