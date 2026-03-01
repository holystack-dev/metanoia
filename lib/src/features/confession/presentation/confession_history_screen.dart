import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/core/widgets/empty_state.dart';
import 'package:confessionapp/src/features/confession/data/confession_analytics_repository.dart';
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
  // Track pending deletions for undo functionality
  final Map<int, bool> _pendingDeletions = {};

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.confessionHistoryTitle,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            tooltip: l10n.deleteAll,
            onPressed: () => _showDeleteAllDialog(context),
          ),
        ],
      ),
      body: ref.watch(finishedConfessionsProvider).when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data: (confessions) {

          if (confessions.isEmpty) {
            return EmptyState(
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
            ).animate().fadeIn().scale();
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: confessions.length,
            itemBuilder: (context, index) {
              final confession = confessions[index];
              final dateFormat = DateFormat('MMM dd, yyyy • hh:mm a');

              return Dismissible(
                key: Key('confession_${confession.confession.id}'),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.error,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  _handleDeleteWithUndo(context, confession, l10n);
                },
                child: Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      elevation: 0,
                      color: Theme.of(context).colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
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
                        borderRadius: BorderRadius.circular(16),
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
                                          Theme.of(context).colorScheme.primary,
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
                                  '${confession.items.length} item${confession.items.length != 1 ? 's' : ''} confessed',
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
                    )
                    .animate()
                    .fadeIn(delay: (100 * index).ms)
                    .slideX(begin: 0.1, end: 0),
              );
            },
          );
        },
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

    // Mark as pending deletion
    _pendingDeletions[confessionId] = true;

    // Show snackbar with undo action
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.confessionDeleted),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: l10n.undo,
          onPressed: () {
            // Cancel deletion and restore item
            _pendingDeletions.remove(confessionId);
            ref.invalidate(finishedConfessionsProvider);
          },
        ),
      ),
    ).closed.then((reason) async {
      // If undo wasn't pressed and deletion is still pending, perform actual deletion
      if (_pendingDeletions.containsKey(confessionId)) {
        _pendingDeletions.remove(confessionId);
        await ref
            .read(confessionRepositoryProvider)
            .deleteConfession(confessionId);
      }
    });
  }

  void _showDeleteAllDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: const Text('Delete All Confessions?'),
            content: const Text(
              'This will permanently delete all your confession history. This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () async {
                  HapticUtils.heavyImpact();
                  Navigator.pop(dialogContext); // Close dialog
                  await ref
                      .read(confessionRepositoryProvider)
                      .deleteAllFinishedConfessions();
                  // Invalidate and pop back to confession screen
                  ref.invalidate(finishedConfessionsProvider);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('All confessions deleted')),
                    );
                    Navigator.pop(context); // Go back to confession screen
                  }
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(dialogContext).colorScheme.error,
                ),
                child: const Text('Delete All'),
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
      builder: (context) => _ConfessionDetailsSheet(
        confession: confession,
        onPenanceUpdated: () {
          ref.invalidate(pendingPenancesProvider);
        },
        onDateUpdated: () {
          ref.invalidate(finishedConfessionsProvider);
          ref.invalidate(lastFinishedConfessionProvider);
          ref.invalidate(confessionAnalyticsProvider);
        },
      ),
    );
  }
}

class _ConfessionDetailsSheet extends ConsumerStatefulWidget {
  final ConfessionWithItems confession;
  final VoidCallback onPenanceUpdated;
  final VoidCallback onDateUpdated;

  const _ConfessionDetailsSheet({
    required this.confession,
    required this.onPenanceUpdated,
    required this.onDateUpdated,
  });

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
    final dateFormat = DateFormat('MMMM dd, yyyy');
    final penanceAsync = ref.watch(
      penanceForConfessionProvider(widget.confession.confession.id),
    );

    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Icon(
                    Icons.church,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.confessionDate,
                          style: theme.textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
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
                    data: (penance) => _buildPenanceSection(
                      context,
                      l10n,
                      theme,
                      penance,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Items header
                  Text(
                    '${widget.confession.items.length} item${widget.confession.items.length != 1 ? 's' : ''} confessed',
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
          color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
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
    final dateFormat = DateFormat('MMM dd, yyyy');
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: penance.isCompleted
            ? theme.colorScheme.primaryContainer.withValues(alpha: 0.3)
            : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: penance.isCompleted
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
                color: penance.isCompleted
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Text(
                l10n.penance,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: penance.isCompleted
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
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Completed',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            penance.description,
            style: theme.textTheme.bodyMedium,
          ),
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
                  onPressed: () =>
                      _showEditPenanceDialog(context, l10n, penance),
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
                  onPressed: () =>
                      _showEditPenanceDialog(context, l10n, penance),
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
      builder: (dialogContext) => AlertDialog(
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
                    color:
                        Theme.of(dialogContext).colorScheme.onSurfaceVariant,
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
            onPressed: () =>
                Navigator.pop(dialogContext, controller.text.trim()),
            child: Text(l10n.savePenance),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty && context.mounted) {
      await ref
          .read(penanceRepositoryProvider)
          .addPenance(widget.confession.confession.id, result);
      ref.invalidate(
        penanceForConfessionProvider(widget.confession.confession.id),
      );
      widget.onPenanceUpdated();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.penanceAdded)),
        );
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
      builder: (dialogContext) => AlertDialog(
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
            onPressed: () =>
                Navigator.pop(dialogContext, controller.text.trim()),
            child: Text(l10n.updateButton),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty && context.mounted) {
      await ref.read(penanceRepositoryProvider).updatePenance(
            penance.id,
            result,
          );
      ref.invalidate(
        penanceForConfessionProvider(widget.confession.confession.id),
      );
      widget.onPenanceUpdated();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.penanceUpdated)),
        );
      }
    }
  }

  Future<void> _completePenance(int penanceId, AppLocalizations l10n) async {
    HapticUtils.mediumImpact();
    await ref.read(penanceRepositoryProvider).completePenance(penanceId);
    ref.invalidate(
      penanceForConfessionProvider(widget.confession.confession.id),
    );
    widget.onPenanceUpdated();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.penanceCompleted)),
      );
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
      final dateFormat = DateFormat('MMMM dd, yyyy');
      final formattedDate = dateFormat.format(pickedDate);

      final confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
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
        await ref.read(confessionRepositoryProvider).updateConfessionDate(
              widget.confession.confession.id,
              pickedDate,
            );

        setState(() {
          _currentDate = pickedDate;
        });

        widget.onDateUpdated();

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.dateUpdated)),
          );
        }
      }
    }
  }
}
