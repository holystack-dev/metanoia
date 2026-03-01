import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:confessionapp/src/features/examination/data/examination_note_provider.dart';
import 'package:confessionapp/src/features/examination/data/examination_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Bottom sheet showing a summary of selected sins grouped by commandment
class ExaminationSummarySheet extends ConsumerWidget {
  final List<CommandmentWithQuestions> data;
  final Map<String, String> selectedQuestions;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const ExaminationSummarySheet({
    super.key,
    required this.data,
    required this.selectedQuestions,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    // Watch the note visibility state
    final noteHiddenAsync = ref.watch(examinationNoteControllerProvider);
    final isNoteHidden = noteHiddenAsync.valueOrNull ?? false;

    // Group selected questions by commandment
    final groupedSelections = _groupSelectionsByCommandment(l10n);

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Row(
              children: [
                Icon(
                  Icons.summarize_outlined,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.examinationSummary,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        l10n.selectedCount(selectedQuestions.length),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onCancel,
                  tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                ),
              ],
            ),
          ),

          const Divider(),

          // Content
          Flexible(
            child: groupedSelections.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Text(
                        l10n.noSinsSelected,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: groupedSelections.length,
                    itemBuilder: (context, index) {
                      final entry = groupedSelections.entries.elementAt(index);
                      return _CommandmentGroup(
                        commandmentTitle: entry.key,
                        sins: entry.value,
                        index: index,
                      );
                    },
                  ),
          ),

          // Dismissible examination note
          if (!isNoteHidden)
            _ExaminationNote(
              onDismiss: () {
                ref
                    .read(examinationNoteControllerProvider.notifier)
                    .hideNote();
              },
            ),

          // Action buttons
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onCancel,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(l10n.continueEditing),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: selectedQuestions.isNotEmpty ? onConfirm : null,
                      icon: const Icon(Icons.check),
                      label: Text(l10n.proceedToConfess),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Map<String, List<String>> _groupSelectionsByCommandment(AppLocalizations l10n) {
    final Map<String, List<String>> grouped = {};

    for (final item in data) {
      final commandmentTitle = item.isGeneral
          ? l10n.general
          : item.commandment?.customTitle ??
              '${l10n.commandment} ${item.commandment?.commandmentNo}';

      // Check standard questions
      for (final q in item.questions) {
        if (selectedQuestions.containsKey(q.id)) {
          grouped.putIfAbsent(commandmentTitle, () => []);
          grouped[commandmentTitle]!.add(q.question);
        }
      }

      // Check custom sins (custom-{id} format)
      for (final s in item.customSins) {
        if (selectedQuestions.containsKey('custom-${s.id}')) {
          grouped.putIfAbsent(commandmentTitle, () => []);
          grouped[commandmentTitle]!.add('✦ ${s.sinText}');
        }
      }
    }

    return grouped;
  }
}

/// Dismissible note about thorough examination
class _ExaminationNote extends StatelessWidget {
  final VoidCallback onDismiss;

  const _ExaminationNote({required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: const EdgeInsets.fromLTRB(12, 10, 4, 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lightbulb_outline,
            size: 18,
            color: theme.colorScheme.primary.withValues(alpha: 0.8),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              l10n.examinationNote,
              style: TextStyle(
                fontFamily: AppTheme.fontFamilyLato,
                fontSize: 13,
                fontStyle: FontStyle.italic,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                height: 1.4,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              size: 18,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
            ),
            onPressed: onDismiss,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
            tooltip: 'Dismiss',
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}

class _CommandmentGroup extends StatelessWidget {
  final String commandmentTitle;
  final List<String> sins;
  final int index;

  const _CommandmentGroup({
    required this.commandmentTitle,
    required this.sins,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Commandment header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.bookmark,
                  size: 16,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    commandmentTitle,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${sins.length}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Sins list
          ...sins.asMap().entries.map((entry) {
            final sinIndex = entry.key;
            final sin = entry.value;
            return Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '•',
                    style: TextStyle(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      sin,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: (50 * sinIndex).ms).slideX(begin: 0.05, end: 0);
          }),
        ],
      ),
    ).animate().fadeIn(delay: (100 * index).ms);
  }
}
