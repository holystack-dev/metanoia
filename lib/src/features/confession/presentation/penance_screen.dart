import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/services/in_app_review_service.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/core/widgets/empty_state.dart';
import 'package:confessionapp/src/features/confession/data/penance_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class PenanceScreen extends ConsumerWidget {
  const PenanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final pendingPenancesAsync = ref.watch(pendingPenancesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.penanceTracker,
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: pendingPenancesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('${l10n.error}: $error')),
        data: (penances) {
          if (penances.isEmpty) {
            return _buildEmptyState(context, l10n);
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: penances.length,
            itemBuilder: (context, index) {
              final item = penances[index];
              return _PenanceCard(
                penanceWithConfession: item,
                onComplete: () async {
                  HapticUtils.mediumImpact();
                  await ref
                      .read(penanceRepositoryProvider)
                      .completePenance(item.penance.id);
                  ref.invalidate(pendingPenancesProvider);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.penanceCompleted)),
                    );
                    // Check for review after penance completion (happy moment)
                    _checkAndRequestReview(context);
                  }
                },
                onEdit: () => _showEditDialog(context, ref, item),
                onDelete: () => _showDeleteConfirmation(context, ref, item),
              ).animate().fadeIn(delay: (100 * index).ms).slideX(begin: 0.1);
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppLocalizations l10n) {
    return EmptyState(
      icon: Icons.task_alt,
      title: l10n.noPendingPenances,
      subtitle: l10n.noPendingPenancesDesc,
    ).animate().fadeIn().scale();
  }

  Future<void> _checkAndRequestReview(BuildContext context) async {
    final reviewService = InAppReviewService();
    final shouldPrompt = await reviewService.trackPenanceCompletion();

    if (shouldPrompt && context.mounted) {
      _showReviewDialog(context, reviewService);
    }
  }

  void _showReviewDialog(BuildContext context, InAppReviewService reviewService) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.favorite,
            color: theme.colorScheme.primary,
            size: 32,
          ),
        ),
        title: Text(
          l10n.rateDialogTitle,
          textAlign: TextAlign.center,
        ),
        content: Text(
          l10n.rateDialogContent,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FilledButton.icon(
                onPressed: () async {
                  await reviewService.setOptOut(true);
                  if (context.mounted) Navigator.pop(context);
                  await reviewService.requestReview();
                },
                icon: const Icon(Icons.star),
                label: Text(l10n.rateDialogYes),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () async {
                  await reviewService.resetCounters();
                  if (context.mounted) Navigator.pop(context);
                },
                child: Text(l10n.rateDialogLater),
              ),
              TextButton(
                onPressed: () async {
                  await reviewService.setOptOut(true);
                  if (context.mounted) Navigator.pop(context);
                },
                child: Text(
                  l10n.rateDialogNo,
                  style: TextStyle(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showEditDialog(
    BuildContext context,
    WidgetRef ref,
    PenanceWithConfession item,
  ) {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) => _EditPenanceDialog(
        l10n: l10n,
        initialText: item.penance.description,
        onSave: (text) async {
          await ref
              .read(penanceRepositoryProvider)
              .updatePenance(item.penance.id, text);
          ref.invalidate(pendingPenancesProvider);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.penanceUpdated)),
            );
          }
        },
      ),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    WidgetRef ref,
    PenanceWithConfession item,
  ) {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteButton),
        content: const Text('Are you sure you want to delete this penance?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () async {
              await ref
                  .read(penanceRepositoryProvider)
                  .deletePenance(item.penance.id);
              ref.invalidate(pendingPenancesProvider);
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(l10n.deleteButton),
          ),
        ],
      ),
    );
  }
}

class _PenanceCard extends StatelessWidget {
  final PenanceWithConfession penanceWithConfession;
  final VoidCallback onComplete;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _PenanceCard({
    required this.penanceWithConfession,
    required this.onComplete,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final dateFormat = DateFormat('MMM dd, yyyy');
    final confessionDate =
        penanceWithConfession.confession.finishedAt ??
        penanceWithConfession.confession.date;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.checklist,
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.penance,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        l10n.assignedOn(dateFormat.format(confessionDate)),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      onEdit();
                    } else if (value == 'delete') {
                      onDelete();
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          const Icon(Icons.edit, size: 20),
                          const SizedBox(width: 8),
                          Text(l10n.editPenance),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 20, color: theme.colorScheme.error),
                          const SizedBox(width: 8),
                          Text(l10n.deleteButton, style: TextStyle(color: theme.colorScheme.error)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                penanceWithConfession.penance.description,
                style: theme.textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: onComplete,
                icon: const Icon(Icons.check),
                label: Text(l10n.markAsComplete),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EditPenanceDialog extends StatefulWidget {
  final AppLocalizations l10n;
  final String initialText;
  final Future<void> Function(String) onSave;

  const _EditPenanceDialog({
    required this.l10n,
    required this.initialText,
    required this.onSave,
  });

  @override
  State<_EditPenanceDialog> createState() => _EditPenanceDialogState();
}

class _EditPenanceDialogState extends State<_EditPenanceDialog> {
  late final TextEditingController _controller;
  bool _hasText = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
    _hasText = _controller.text.trim().isNotEmpty;
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final hasText = _controller.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    return AlertDialog(
      title: Text(l10n.editPenance),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: l10n.penanceDescription,
          border: const OutlineInputBorder(),
        ),
        maxLines: 3,
        textCapitalization: TextCapitalization.sentences,
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.pop(context),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: _hasText && !_isLoading
              ? () async {
                  setState(() => _isLoading = true);
                  await widget.onSave(_controller.text.trim());
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                }
              : null,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(l10n.updateButton),
        ),
      ],
    );
  }
}
