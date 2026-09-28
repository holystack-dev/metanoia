import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/theme/app_radius.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/features/examination/data/examination_repository.dart';
import 'package:confessionapp/src/features/examination/presentation/examination_controller.dart'
    show neutralSelectionKey;
import 'package:confessionapp/src/features/journal/data/journal_repository.dart';
import 'package:confessionapp/src/features/journal/presentation/journal_entry_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Opens the sin picker for [day].
Future<void> showSinQuickPicker(BuildContext context, DateTime day) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => SinQuickPicker(day: day),
  );
}

/// Marks a sin on a journal day from one of three sources: the standard
/// question bank (searchable), the user's own custom sins, or free text.
///
/// Standard questions are marked by their *language-neutral* key, so a mark
/// made in English still resolves after the user switches content language.
class SinQuickPicker extends ConsumerStatefulWidget {
  const SinQuickPicker({super.key, required this.day});

  final DateTime day;

  @override
  ConsumerState<SinQuickPicker> createState() => _SinQuickPickerState();
}

class _SinQuickPickerState extends ConsumerState<SinQuickPicker> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _freeTextController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    _freeTextController.dispose();
    super.dispose();
  }

  JournalEntryController get _controller =>
      ref.read(journalEntryControllerProvider(widget.day).notifier);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final viewInsets = MediaQuery.viewInsetsOf(context).bottom;

    final dataAsync = ref.watch(examinationDataProvider);
    final marks =
        ref.watch(journalDayProvider(widget.day)).valueOrNull?.marks ??
        const [];

    final markedQuestionKeys = {
      for (final mark in marks)
        if (mark.questionKey != null) mark.questionKey!,
    };
    final markedCustomSinIds = {
      for (final mark in marks)
        if (mark.customSinId != null) mark.customSinId!,
    };

    return DefaultTabController(
      length: 3,
      child: Padding(
        padding: EdgeInsets.only(bottom: viewInsets),
        child: Container(
          height: MediaQuery.sizeOf(context).height * 0.85,
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppRadius.card),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: scheme.outlineVariant,
                  borderRadius: BorderRadius.circular(AppRadius.bar),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 8, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.journalAddSin,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: scheme.onSurface,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        HapticUtils.lightImpact();
                        Navigator.of(context).pop();
                      },
                      child: Text(l10n.done),
                    ),
                  ],
                ),
              ),
              TabBar(
                // Sized to content: equal thirds truncate "In my own words",
                // which is longer still in several languages.
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                labelColor: scheme.primary,
                unselectedLabelColor: scheme.onSurfaceVariant,
                indicatorColor: scheme.primary,
                tabs: [
                  Tab(text: l10n.journalPickerQuestions),
                  Tab(text: l10n.journalPickerMySins),
                  Tab(text: l10n.journalPickerOwnWords),
                ],
              ),
              Expanded(
                child: dataAsync.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (error, _) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        l10n.errorLoadingLanguage,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                  data: (data) => TabBarView(
                    children: [
                      _QuestionsTab(
                        data: data,
                        query: _query,
                        searchController: _searchController,
                        markedKeys: markedQuestionKeys,
                        onQueryChanged: (value) =>
                            setState(() => _query = value),
                        onSelect: (question, commandmentNo) {
                          HapticUtils.selectionClick();
                          _controller.markQuestion(
                            question.id,
                            commandmentNo: commandmentNo,
                            sinText: question.question,
                          );
                        },
                      ),
                      _CustomSinsTab(
                        data: data,
                        markedIds: markedCustomSinIds,
                        onSelect: (sin, commandmentNo) {
                          HapticUtils.selectionClick();
                          _controller.markCustomSin(
                            sin.id,
                            commandmentNo: commandmentNo,
                            sinText: sin.sinText,
                          );
                        },
                      ),
                      _FreeTextTab(
                        controller: _freeTextController,
                        onSubmit: () async {
                          final text = _freeTextController.text;
                          if (text.trim().isEmpty) return;
                          HapticUtils.lightImpact();
                          final navigator = Navigator.of(context);
                          // Persist first: clearing the field and closing the
                          // sheet before the write lands would lose the sin the
                          // user just typed if the write failed. Keep the text
                          // on failure so it can be tried again.
                          try {
                            await _controller.markFreeText(text);
                          } catch (_) {
                            return;
                          }
                          _freeTextController.clear();
                          navigator.pop();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The commandment number a section belongs to, for insights grouping.
int? _commandmentNoOf(CommandmentWithQuestions section) =>
    section.commandment?.commandmentNo;

/// The commandment number a custom sin belongs to, read from its
/// language-neutral commandment code (`1`, or the legacy `en-1`).
int? _commandmentNoOfCustomSin(UserCustomSin sin) {
  final neutral = neutralCommandmentCode(sin.commandmentCode);
  return neutral == null ? null : int.tryParse(neutral);
}

class _QuestionsTab extends StatelessWidget {
  const _QuestionsTab({
    required this.data,
    required this.query,
    required this.searchController,
    required this.markedKeys,
    required this.onQueryChanged,
    required this.onSelect,
  });

  final List<CommandmentWithQuestions> data;
  final String query;
  final TextEditingController searchController;
  final Set<String> markedKeys;
  final ValueChanged<String> onQueryChanged;
  final void Function(ExaminationQuestion question, int? commandmentNo) onSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final needle = query.trim().toLowerCase();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
          child: TextField(
            controller: searchController,
            onChanged: onQueryChanged,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: l10n.journalSearchSins,
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.card),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Expanded(
          child: needle.isEmpty
              ? _byCommandment(context)
              : _searchResults(context, needle),
        ),
      ],
    );
  }

  /// The default view: the commandments as collapsible sections, so a sin can
  /// be found under its commandment with one tap instead of scrolling one long
  /// flat list of every question.
  Widget _byCommandment(BuildContext context) {
    final sections = [
      for (final section in data)
        if (section.commandment != null) section,
    ];

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 24),
      itemCount: sections.length,
      itemBuilder: (context, index) {
        final section = sections[index];
        final commandment = section.commandment!;
        final markedCount = section.questions
            .where((q) => markedKeys.contains(neutralSelectionKey(q.id)))
            .length;

        return _CommandmentSection(
          // Keyed by content so each section keeps its open/closed state across
          // the rebuild that marking a sin triggers.
          storageKey: commandment.content,
          title: commandment.content,
          markedCount: markedCount,
          children: [
            for (final question in section.questions)
              _PickerTile(
                title: question.question,
                isMarked: markedKeys.contains(
                  neutralSelectionKey(question.id),
                ),
                onTap: markedKeys.contains(neutralSelectionKey(question.id))
                    ? null
                    : () => onSelect(question, _commandmentNoOf(section)),
              ),
          ],
        );
      },
    );
  }

  /// When searching, a flat list of matches across every commandment reads
  /// faster than opening and closing sections.
  Widget _searchResults(BuildContext context, String needle) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final rows = <_PickerRow>[];
    for (final section in data) {
      final commandment = section.commandment;
      if (commandment == null) continue;

      final matches = section.questions.where((question) {
        return question.question.toLowerCase().contains(needle) ||
            commandment.content.toLowerCase().contains(needle);
      }).toList();
      if (matches.isEmpty) continue;

      rows.add(_PickerRow.header(commandment.content));
      for (final question in matches) {
        rows.add(_PickerRow.question(question, _commandmentNoOf(section)));
      }
    }

    if (rows.isEmpty) {
      return Center(
        child: Text(
          l10n.noResults,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: scheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 24),
      itemCount: rows.length,
      itemBuilder: (context, index) {
        final row = rows[index];
        final question = row.question;
        if (question == null) {
          return _SectionHeader(title: row.title ?? '');
        }
        final isMarked = markedKeys.contains(neutralSelectionKey(question.id));
        return _PickerTile(
          title: question.question,
          isMarked: isMarked,
          onTap: isMarked ? null : () => onSelect(question, row.commandmentNo),
        );
      },
    );
  }
}

class _CustomSinsTab extends StatelessWidget {
  const _CustomSinsTab({
    required this.data,
    required this.markedIds,
    required this.onSelect,
  });

  final List<CommandmentWithQuestions> data;
  final Set<int> markedIds;
  final void Function(UserCustomSin sin, int? commandmentNo) onSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final sins = [
      for (final section in data) ...section.customSins,
    ];

    if (sins.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            l10n.noCustomSins,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: sins.length,
      itemBuilder: (context, index) {
        final sin = sins[index];
        final isMarked = markedIds.contains(sin.id);

        return _PickerTile(
          title: sin.sinText,
          isMarked: isMarked,
          onTap: isMarked
              ? null
              : () => onSelect(sin, _commandmentNoOfCustomSin(sin)),
        );
      },
    );
  }
}

class _FreeTextTab extends StatelessWidget {
  const _FreeTextTab({required this.controller, required this.onSubmit});

  final TextEditingController controller;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: controller,
            autofocus: false,
            maxLines: 3,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: l10n.journalPickerFreeTextHint,
              filled: true,
              fillColor: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.card),
                borderSide: BorderSide.none,
              ),
            ),
            style: theme.textTheme.bodyLarge?.copyWith(
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(onPressed: onSubmit, child: Text(l10n.addButton)),
        ],
      ),
    );
  }
}

/// A commandment as a collapsible section in the picker's default view: tap to
/// open its questions, so a sin is two taps away instead of a long scroll.
class _CommandmentSection extends StatelessWidget {
  const _CommandmentSection({
    required this.storageKey,
    required this.title,
    required this.markedCount,
    required this.children,
  });

  final String storageKey;
  final String title;
  final int markedCount;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Theme(
      // ExpansionTile draws a hairline divider above and below when open; the
      // picker reads cleaner without them.
      data: theme.copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        key: PageStorageKey<String>(storageKey),
        shape: const Border(),
        collapsedShape: const Border(),
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
        childrenPadding: EdgeInsets.zero,
        iconColor: scheme.primary,
        collapsedIconColor: scheme.onSurfaceVariant,
        title: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: scheme.primary,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
            ),
            if (markedCount > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: scheme.primaryContainer,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text(
                  '$markedCount',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: scheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        children: children,
      ),
    );
  }
}

/// A flattened row of the questions list: either a commandment header or a
/// question. Flattening keeps the list lazily built instead of nesting
/// scrollables.
class _PickerRow {
  const _PickerRow.header(this.title)
    : question = null,
      commandmentNo = null;

  const _PickerRow.question(this.question, this.commandmentNo) : title = null;

  final String? title;
  final ExaminationQuestion? question;
  final int? commandmentNo;
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 6),
      child: Text(
        title,
        style: theme.textTheme.labelLarge?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _PickerTile extends StatelessWidget {
  const _PickerTile({
    required this.title,
    required this.isMarked,
    required this.onTap,
  });

  final String title;
  final bool isMarked;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: isMarked ? scheme.onSurfaceVariant : scheme.onSurface,
        ),
      ),
      trailing: Icon(
        isMarked ? Icons.check_circle : Icons.add_circle_outline,
        color: isMarked ? scheme.primary : scheme.onSurfaceVariant,
      ),
    );
  }
}
