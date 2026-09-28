import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/theme/app_radius.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/features/examination/presentation/examination_controller.dart';
import 'package:confessionapp/src/features/journal/data/journal_repository.dart';
import 'package:confessionapp/src/features/journal/presentation/journal_entry_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The selection key an examination uses for [mark].
///
/// Questions and custom sins already have a language-neutral key of their own;
/// a free-text mark has none, so it is carried under `journal-{markId}`.
String journalMarkSelectionKey(JournalSinMark mark) {
  if (mark.questionKey != null) return mark.questionKey!;
  if (mark.customSinId != null) {
    return '$kCustomSinKeyPrefix${mark.customSinId}';
  }
  return '$kJournalSinKeyPrefix${mark.id}';
}

/// Builds the examination selections for [marks], with their text resolved in
/// the current content language. Marks whose text cannot be resolved (a
/// question that no longer exists, a deleted custom sin) are skipped rather
/// than added as a blank line the user cannot interpret.
Map<String, String> journalSelectionsFor(
  List<JournalSinMark> marks,
  SinTextResolver resolver,
) {
  final selections = <String, String>{};
  for (final mark in marks) {
    final text = resolver.resolve(mark).text.trim();
    if (text.isEmpty) continue;
    selections[journalMarkSelectionKey(mark)] = text;
  }
  return selections;
}

/// "Include the N sins you marked in your journal": offers journal marks not
/// yet confessed for inclusion in the examination.
///
/// Renders nothing when there is nothing to carry over, so it can sit
/// unconditionally above the examination.
class JournalPreloadBanner extends ConsumerStatefulWidget {
  const JournalPreloadBanner({super.key});

  @override
  ConsumerState<JournalPreloadBanner> createState() =>
      _JournalPreloadBannerState();
}

class _JournalPreloadBannerState extends ConsumerState<JournalPreloadBanner> {
  bool _dismissed = false;
  bool _isWorking = false;

  Future<void> _include(List<JournalSinMark> marks) async {
    if (_isWorking) return;
    setState(() => _isWorking = true);

    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);

    final resolver = await ref.read(sinTextResolverProvider.future);
    final added = await ref
        .read(examinationControllerProvider.notifier)
        .preloadFromJournal(journalSelectionsFor(marks, resolver));

    if (!mounted) return;
    setState(() {
      _isWorking = false;
      _dismissed = true;
    });

    HapticUtils.lightImpact();
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(l10n.journalPreloadAdded(added)),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    if (_dismissed) return const SizedBox.shrink();

    final selected = ref.watch(examinationControllerProvider);
    // Offer each distinct sin once: drop sins already ticked, and collapse
    // marks of the same question on different days, so the count matches
    // what gets added.
    final seen = <String>{};
    final marks = <JournalSinMark>[];
    for (final mark
        in ref.watch(unconfessedSinMarksProvider).valueOrNull ??
            const <JournalSinMark>[]) {
      final key = neutralSelectionKey(journalMarkSelectionKey(mark));
      if (selected.containsKey(key)) continue;
      if (!seen.add(key)) continue;
      marks.add(mark);
    }
    if (marks.isEmpty) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
      decoration: BoxDecoration(
        color: scheme.primaryContainer.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        children: [
          Icon(Icons.auto_stories_outlined, color: scheme.primary, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              l10n.journalPreloadTitle(marks.length),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.onSurface,
              ),
            ),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: _isWorking ? null : () => _include(marks),
            child: Text(l10n.journalPreloadAction),
          ),
          IconButton(
            icon: const Icon(Icons.close, size: 18),
            tooltip: l10n.dismiss,
            color: scheme.onSurfaceVariant,
            onPressed: () {
              HapticUtils.lightImpact();
              setState(() => _dismissed = true);
            },
          ),
        ],
      ),
    );
  }
}
