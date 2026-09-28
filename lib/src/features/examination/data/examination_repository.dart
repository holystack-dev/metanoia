import 'package:confessionapp/src/core/constants/app_constants.dart';
import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:confessionapp/src/core/localization/content_language_provider.dart';
import 'package:confessionapp/src/features/examination/data/user_custom_sins_repository.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'examination_repository.g.dart';

/// Strips the language prefix from a commandment code.
///
/// Content commandment codes are language-scoped (`en-1`, `pt_BR-1`), but user
/// custom sins must survive a content-language switch, so they are stored (and
/// compared) with the language-neutral commandment number (`1`).
///
/// Idempotent: both `en-1` (legacy rows) and `1` normalize to `1`, so no
/// migration is needed.
String? neutralCommandmentCode(String? code) {
  if (code == null) return null;
  return code.split('-').last;
}

/// Re-scopes a (possibly legacy) commandment code to [langKey], e.g. `1` or
/// `en-1` with `es` becomes `es-1`. Used when handing a stored custom sin back
/// to UI that works with the current content language's codes.
String? scopedCommandmentCode(String? code, String langKey) {
  final neutral = neutralCommandmentCode(code);
  return neutral == null ? null : '$langKey-$neutral';
}

/// Normalizes the commandment code of a custom sin before it is written, so new
/// rows are stored language-neutral.
UserCustomSinsCompanion withNeutralCommandmentCode(
  UserCustomSinsCompanion sin,
) {
  if (!sin.commandmentCode.present) return sin;
  return sin.copyWith(
    commandmentCode: Value(neutralCommandmentCode(sin.commandmentCode.value)),
  );
}

/// Groups custom sins by their language-neutral commandment code, merging
/// legacy language-scoped rows into the same bucket.
Map<String?, List<UserCustomSin>> groupCustomSinsByNeutralCode(
  Map<String?, List<UserCustomSin>> grouped,
) {
  final normalized = <String?, List<UserCustomSin>>{};
  grouped.forEach((code, sins) {
    normalized
        .putIfAbsent(neutralCommandmentCode(code), () => <UserCustomSin>[])
        .addAll(sins);
  });
  return normalized;
}

/// The commandments and questions of the current content language, with the
/// user's custom sins folded in.
///
/// A Future provider because the bundled content only changes at startup sync.
/// Custom sins come from the [customSinsGroupedProvider] stream, so this still
/// rebuilds when one is added, edited or deleted.
@riverpod
Future<List<CommandmentWithQuestions>> examinationData(Ref ref) async {
  final db = ref.watch(appDatabaseProvider);
  final contentLanguage = await ref.watch(
    contentLanguageControllerProvider.future,
  );
  final langKey = LanguageConfig.contentKeyFromLocale(contentLanguage);

  final commandments =
      await (db.select(db.commandments)..where(
        (tbl) => tbl.languageCode.equals(langKey),
      )).get();
  final questions =
      await (db.select(db.examinationQuestions)..where(
        (tbl) => tbl.languageCode.equals(langKey),
      )).get();

  // Get custom sins grouped by (language-neutral) commandment code
  final customSinsGrouped = groupCustomSinsByNeutralCode(
    await ref.watch(customSinsGroupedProvider.future),
  );

  final result = commandments.map((c) {
    final relatedQuestions =
        questions.where((q) => q.commandmentId == c.id).toList();

    // Get custom sins for this commandment
    final customSins = c.code == null
        ? const <UserCustomSin>[]
        : (customSinsGrouped[neutralCommandmentCode(c.code)] ??
            const <UserCustomSin>[]);

    return CommandmentWithQuestions(c, relatedQuestions, customSins);
  }).toList();

  // Add "General" section if there are uncategorized custom sins
  final generalCustomSins = customSinsGrouped[null] ?? [];
  if (generalCustomSins.isNotEmpty) {
    result.add(CommandmentWithQuestions.general(generalCustomSins));
  }

  return result;
}

class CommandmentWithQuestions {
  final Commandment? commandment;
  final List<ExaminationQuestion> questions;
  final List<UserCustomSin> customSins;
  final bool isGeneral;

  CommandmentWithQuestions(this.commandment, this.questions, this.customSins)
      : isGeneral = false;

  /// Creates a "General" section for uncategorized custom sins
  CommandmentWithQuestions.general(this.customSins)
      : commandment = null,
        questions = const [],
        isGeneral = true;
}
