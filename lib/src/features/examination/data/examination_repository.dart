import 'package:confessionapp/src/core/constants/app_constants.dart';
import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:confessionapp/src/core/localization/content_language_provider.dart';
import 'package:confessionapp/src/features/examination/data/user_custom_sins_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'examination_repository.g.dart';

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

  // Get custom sins grouped by commandment
  final customSinsRepo = ref.read(userCustomSinsRepositoryProvider);
  final customSinsGrouped =
      await customSinsRepo.getCustomSinsGroupedByCommandment();

  final result = commandments.map((c) {
    final relatedQuestions =
        questions.where((q) => q.commandmentId == c.id).toList();

    // Get custom sins for this commandment
    final customSins = customSinsGrouped[c.code] ?? [];

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
