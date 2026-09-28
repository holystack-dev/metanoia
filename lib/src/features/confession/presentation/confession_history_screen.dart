import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/theme/app_radius.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/core/widgets/app_back_button.dart';
import 'package:confessionapp/src/core/widgets/empty_state.dart';
import 'package:confessionapp/src/features/confession/data/confession_repository.dart';
import 'package:confessionapp/src/features/confession/data/penance_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ConfessionHistoryScreen extends ConsumerStatefulWidget {
  const ConfessionHistoryScreen({super.key});

  @override
  ConsumerState<ConfessionHistoryScreen> createState() =>
      _ConfessionHistoryScreenState();
}

class _ConfessionHistoryScreenState
    extends ConsumerState<ConfessionHistoryScreen> {
  /// Confessions swiped away but not yet committed, while their Undo snackbar
  /// is on screen. They are filtered out of the list below — the row has to
  /// genuinely leave the tree, or the dismissed Dismissible stays in it (which
  /// asserts in debug and leaves an invisible gap in release).
  final Set<int> _pendingDeletions = {};

  /// The history list is a Drift stream, so it — and everything else derived
  /// from the confessions tables — is already current. The gesture is kept
  /// because users reach for it; it just settles.
  Future<void> _onRefresh() async {
    HapticUtils.lightImpact();
    await Future<void>.delayed(const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(fallbackLocation: '/confess'),
        title: Text(l10n.confessionHistoryTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            tooltip: l10n.deleteAll,
            onPressed: () => _showDeleteAllDialog(context),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ref
            .watch(finishedConfessionsProvider)
            .when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('${l10n.error}: $error')),
              data: (allConfessions) {
                final liveIds =
                    allConfessions.map((c) => c.confession.id).toSet();

                // A hidden id the stream no longer returns has had its deletion
                // committed and needs no hiding. Dropping it here (rather than
                // right after the delete) keeps the row out of the tree until
                // the stream has caught up, and stops a later confession that
                // reuses the rowid from being hidden as well.
                _pendingDeletions.removeWhere((id) => !liveIds.contains(id));

                // Hide the rows whose Undo window is still open.
                final confessions =
                    allConfessions
                        .where(
                          (c) => !_pendingDeletions.contains(c.confession.id),
                        )
                        .toList();

                if (confessions.isEmpty) {
                  return ListView(
                    // A plain Column would not scroll, and RefreshIndicator needs a
                    // scrollable child for the pull gesture to reach it.
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.7,
                        child: EmptyState(
                          icon: Icons.history,
                          title: l10n.noConfessionHistory,
                          subtitle: l10n.noConfessionHistoryDesc,
                          action: FilledButton.icon(
                            onPressed: () {
                              HapticUtils.lightImpact();
                              context.go('/examine');
                            },
                            icon: const Icon(Icons.assignment_outlined),
                            label: Text(l10n.startExamination),
                          ),
                        ),
                      ),
                    ],
                  ).animate().fadeIn();
                }

                return ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount: confessions.length,
                  itemBuilder: (context, index) {
                    final confession = confessions[index];
                    final locale = Localizations.localeOf(context).toString();
                    final dateFormat = DateFormat.yMMMd(locale).add_jm();

                    return Dismissible(
                      key: Key('confession_${confession.confession.id}'),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.error,
                          borderRadius: BorderRadius.circular(AppRadius.card),
                        ),
                        child: Icon(
                          Icons.delete,
                          color: Theme.of(context).colorScheme.onError,
                        ),
                      ),
                      onDismissed: (direction) {
                        _handleDeleteWithUndo(context, confession, l10n);
                      },
                      child: Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 0,
                        color: Theme.of(context).colorScheme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppRadius.card),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.outlineVariant,
                            width: 1,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            HapticUtils.lightImpact();
                            _showConfessionDetails(context, confession);
                          },
                          borderRadius: BorderRadius.circular(AppRadius.card),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.primaryContainer,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.check_circle,
                                        color:
                                            Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            dateFormat.format(
                                              confession.confession.date,
                                            ),
                                            style: Theme.of(
                                              context,
                                            ).textTheme.titleMedium?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onSurfaceVariant,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Padding(
                                  padding: const EdgeInsets.only(left: 44.0),
                                  child: Text(
                                    // A confession made while "keep history"
                                    // was off has only its date.
                                    confession.items.isEmpty
                                        ? l10n.detailsNotSaved
                                        : l10n.itemsConfessed(
                                            confession.items.length,
                                          ),
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ).animate().fadeIn(duration: 150.ms),
                    );
                  },
                );
              },
            ),
      ),
    );
  }

  void _handleDeleteWithUndo(
    BuildContext context,
    ConfessionWithItems confession,
    AppLocalizations l10n,
  ) {
    HapticUtils.heavyImpact();
    final confessionId = confession.confession.id;
    // Read now: the delete below runs after the snackbar closes, by which time
    // this screen may already be gone.
    final repository = ref.read(confessionRepositoryProvider);

    var undone = false;

    // Hide the row while the Undo window is open. Nothing is deleted yet.
    setState(() => _pendingDeletions.add(confessionId));

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            content: Text(l10n.confessionDeleted),
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
              label: l10n.undo,
              onPressed: () {
                undone = true;
                // Bringing the id back into the list rebuilds a fresh
                // Dismissible, so the row actually reappears; the old one had
                // already recorded itself as dismissed.
                if (mounted) {
                  setState(() => _pendingDeletions.remove(confessionId));
                }
              },
            ),
          ),
        )
        .closed
        .then((_) async {
          if (undone) return;

          await repository.deleteConfession(confessionId);

          // The id stays in _pendingDeletions: build drops it once
          // the history stream has re-emitted without this confession. Removing
          // it here would rebuild the row against the not-yet-updated stream
          // value, re-inserting an already dismissed Dismissible.
        });
  }

  void _showDeleteAllDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text(l10n.deleteAllConfessionsTitle),
            content: Text(l10n.deleteAllConfessionsContent),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text(l10n.cancel),
              ),
              FilledButton(
                onPressed: () async {
                  HapticUtils.heavyImpact();
                  Navigator.pop(dialogContext); // Close dialog
                  await ref
                      .read(confessionRepositoryProvider)
                      .deleteAllFinishedConfessions();
                  // History, the home stats and Insights are all Drift streams
                  // over the confessions tables and refresh themselves.
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.allConfessionsDeleted)),
                    );
                    Navigator.pop(context); // Go back to confession screen
                  }
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(dialogContext).colorScheme.error,
                ),
                child: Text(l10n.deleteAll),
              ),
            ],
          ),
    );
  }

  void _showConfessionDetails(
    BuildContext context,
    ConfessionWithItems confession,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ConfessionDetailsSheet(confession: confession),
    );
  }
}

class _ConfessionDetailsSheet extends ConsumerStatefulWidget {
  final ConfessionWithItems confession;

  const _ConfessionDetailsSheet({required this.confession});

  @override
  ConsumerState<_ConfessionDetailsSheet> createState() =>
      _ConfessionDetailsSheetState();
}

class _ConfessionDetailsSheetState
    extends ConsumerState<_ConfessionDetailsSheet> {
  late DateTime _currentDate;

  @override
  void initState() {
    super.initState();
    _currentDate = widget.confession.confession.date;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final dateFormat = DateFormat.yMMMMd(
      Localizations.localeOf(context).toString(),
    );
    final penanceAsync = ref.watch(
      penanceForConfessionProvider(widget.confession.confession.id),
    );

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder:
          (context, scrollController) => Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppRadius.sheet),
              ),
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurfaceVariant.withValues(
                      alpha: 0.4,
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.bar),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Icon(Icons.church, color: theme.colorScheme.primary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.confessionDate,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _showEditDatePicker(context, l10n),
                              child: Row(
                                children: [
                                  Text(
                                    dateFormat.format(_currentDate),
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: theme.colorScheme.primary,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    Icons.edit,
                                    size: 16,
                                    color: theme.colorScheme.primary,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(20),
                    children: [
                      // Penance Section
                      penanceAsync.when(
                        loading: () => const SizedBox.shrink(),
                        error: (_, __) => const SizedBox.shrink(),
                        data:
                            (penance) => _buildPenanceSection(
                              context,
                              l10n,
                              theme,
                              penance,
                            ),
                      ),
                      const SizedBox(height: 16),
                      // Items header
                      Text(
                        l10n.itemsConfessed(widget.confession.items.length),
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Confession items
                      ...widget.confession.items.asMap().entries.map((entry) {
                        final index = entry.key;
                        final item = entry.value;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${index + 1}.',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  item.content,
                                  style: theme.textTheme.bodyLarge,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildPenanceSection(
    BuildContext context,
    AppLocalizations l10n,
    ThemeData theme,
    Penance? penance,
  ) {
    if (penance == null) {
      // No penance - show add button
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withValues(
            alpha: 0.5,
          ),
          borderRadius: BorderRadius.circular(AppRadius.tile),
          border: Border.all(
            color: theme.colorScheme.outlineVariant,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.checklist,
                  size: 20,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.penance,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _showAddPenanceDialog(context, l10n),
                icon: const Icon(Icons.add),
                label: Text(l10n.addPenance),
              ),
            ),
          ],
        ),
      );
    }

    // Has penance - show it
    final dateFormat = DateFormat.yMMMd(
      Localizations.localeOf(context).toString(),
    );
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            penance.isCompleted
                ? theme.colorScheme.primaryContainer.withValues(alpha: 0.3)
                : theme.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.5,
                ),
        borderRadius: BorderRadius.circular(AppRadius.tile),
        border: Border.all(
          color:
              penance.isCompleted
                  ? theme.colorScheme.primary.withValues(alpha: 0.3)
                  : theme.colorScheme.outlineVariant,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                penance.isCompleted ? Icons.task_alt : Icons.checklist,
                size: 20,
                color:
                    penance.isCompleted
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Text(
                l10n.penance,
                style: theme.textTheme.titleSmall?.copyWith(
                  color:
                      penance.isCompleted
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              if (penance.isCompleted)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(AppRadius.tile),
                  ),
                  child: Text(
                    l10n.completed,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(penance.description, style: theme.textTheme.bodyMedium),
          if (penance.isCompleted && penance.completedAt != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.completedOn(dateFormat.format(penance.completedAt!)),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                IconButton(
                  onPressed:
                      () => _showEditPenanceDialog(context, l10n, penance),
                  icon: Icon(
                    Icons.edit,
                    size: 18,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  tooltip: l10n.editPenance,
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ],
          if (!penance.isCompleted) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () => _completePenance(penance.id, l10n),
                    icon: const Icon(Icons.check, size: 18),
                    label: Text(l10n.markAsComplete),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed:
                      () => _showEditPenanceDialog(context, l10n, penance),
                  icon: const Icon(Icons.edit, size: 20),
                  tooltip: l10n.editPenance,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Future<void> _showAddPenanceDialog(
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    final controller = TextEditingController();

    final result = await showDialog<String?>(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Row(
              children: [
                Icon(
                  Icons.checklist,
                  color: Theme.of(dialogContext).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(l10n.addPenance),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.penanceDescription,
                  style: Theme.of(dialogContext).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(dialogContext).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: l10n.penanceHint,
                    border: const OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  textCapitalization: TextCapitalization.sentences,
                  autofocus: true,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text(l10n.cancel),
              ),
              FilledButton(
                onPressed:
                    () => Navigator.pop(dialogContext, controller.text.trim()),
                child: Text(l10n.savePenance),
              ),
            ],
          ),
    );

    if (result != null && result.isNotEmpty && context.mounted) {
      await ref
          .read(penanceRepositoryProvider)
          .addPenance(widget.confession.confession.id, result);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.penanceAdded)));
      }
    }
  }

  Future<void> _showEditPenanceDialog(
    BuildContext context,
    AppLocalizations l10n,
    Penance penance,
  ) async {
    final controller = TextEditingController(text: penance.description);

    final result = await showDialog<String?>(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text(l10n.editPenance),
            content: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: l10n.penanceDescription,
                border: const OutlineInputBorder(),
              ),
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text(l10n.cancel),
              ),
              FilledButton(
                onPressed:
                    () => Navigator.pop(dialogContext, controller.text.trim()),
                child: Text(l10n.updateButton),
              ),
            ],
          ),
    );

    if (result != null && result.isNotEmpty && context.mounted) {
      await ref
          .read(penanceRepositoryProvider)
          .updatePenance(penance.id, result);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.penanceUpdated)));
      }
    }
  }

  Future<void> _completePenance(int penanceId, AppLocalizations l10n) async {
    HapticUtils.mediumImpact();
    await ref.read(penanceRepositoryProvider).completePenance(penanceId);
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.penanceCompleted)));
    }
  }

  Future<void> _showEditDatePicker(
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    final theme = Theme.of(context);
    final now = DateTime.now();

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _currentDate,
      firstDate: DateTime(2000),
      lastDate: now, // Cannot select future dates
      helpText: l10n.confessionDate,
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
              primary: theme.colorScheme.primary,
              onPrimary: theme.colorScheme.onPrimary,
              surface: theme.colorScheme.surface,
              onSurface: theme.colorScheme.onSurface,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != _currentDate && context.mounted) {
      final dateFormat = DateFormat.yMMMMd(
        Localizations.localeOf(context).toString(),
      );
      final formattedDate = dateFormat.format(pickedDate);

      final confirmed = await showDialog<bool>(
        context: context,
        builder:
            (dialogContext) => AlertDialog(
              title: Text(l10n.changeDateConfirmTitle),
              content: Text(l10n.changeDateConfirmMessage(formattedDate)),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext, false),
                  child: Text(l10n.cancel),
                ),
                FilledButton(
                  onPressed: () => Navigator.pop(dialogContext, true),
                  child: Text(l10n.updateButton),
                ),
              ],
            ),
      );

      if (confirmed == true && context.mounted) {
        await ref
            .read(confessionRepositoryProvider)
            .updateConfessionDate(widget.confession.confession.id, pickedDate);

        setState(() {
          _currentDate = pickedDate;
        });

        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(l10n.dateUpdated)));
        }
      }
    }
  }
}
