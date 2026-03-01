import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/router/navigation_provider.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/features/confession/data/confession_repository.dart';
import 'package:confessionapp/src/features/confession/data/penance_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// A unified card that shows pending action items:
/// - Continue Examination (when there's an active draft)
/// - Pending Penances (when there are incomplete penances)
/// Returns empty space when no action items exist.
class ActionItemsCard extends ConsumerStatefulWidget {
  const ActionItemsCard({super.key});

  @override
  ConsumerState<ActionItemsCard> createState() => _ActionItemsCardState();
}

class _ActionItemsCardState extends ConsumerState<ActionItemsCard>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshProviders();
    }
  }

  void _refreshProviders() {
    ref.invalidate(activeExaminationDraftProvider);
    ref.invalidate(pendingPenancesProvider);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    // Listen to tab changes - refresh when returning to home tab
    ref.listen(currentTabIndexProvider, (previous, current) {
      if (current == 0 && previous != 0) {
        _refreshProviders();
      }
    });

    final draftAsync = ref.watch(activeExaminationDraftProvider);
    final penancesAsync = ref.watch(pendingPenancesProvider);

    // Collect action items
    final List<_ActionItem> actionItems = [];

    // Add draft examination if exists
    draftAsync.whenData((draft) {
      if (draft != null) {
        actionItems.add(_ActionItem(
          icon: Icons.edit_note_rounded,
          title: l10n.continueExamination,
          subtitle: l10n.examinationProgress(draft.itemCount),
          onTap: () {
            HapticUtils.lightImpact();
            context.go('/examine');
          },
        ));
      }
    });

    // Add pending penances if exist
    penancesAsync.whenData((penances) {
      if (penances.isNotEmpty) {
        actionItems.add(_ActionItem(
          icon: Icons.task_alt_rounded,
          title: l10n.pendingPenances,
          subtitle: penances.length == 1
              ? '1 ${l10n.penance.toLowerCase()}'
              : '${penances.length} ${l10n.penance.toLowerCase()}s',
          onTap: () {
            HapticUtils.lightImpact();
            context.push('/confess/penance');
          },
        ));
      }
    });

    // Don't show card if no action items
    if (actionItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return _ActionItemsCardContent(
      theme: theme,
      l10n: l10n,
      actionItems: actionItems,
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0);
  }
}

class _ActionItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
}

class _ActionItemsCardContent extends StatelessWidget {
  const _ActionItemsCardContent({
    required this.theme,
    required this.l10n,
    required this.actionItems,
  });

  final ThemeData theme;
  final AppLocalizations l10n;
  final List<_ActionItem> actionItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.checklist_rounded,
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  l10n.quickActions,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${actionItems.length}',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Action items
          ...actionItems.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isLast = index == actionItems.length - 1;

            return _ActionItemTile(
              item: item,
              theme: theme,
              showDivider: !isLast,
            );
          }),
        ],
      ),
    );
  }
}

class _ActionItemTile extends StatelessWidget {
  const _ActionItemTile({
    required this.item,
    required this.theme,
    required this.showDivider,
  });

  final _ActionItem item;
  final ThemeData theme;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: item.onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondaryContainer.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      item.icon,
                      color: theme.colorScheme.secondary,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.subtitle,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: theme.colorScheme.onSurfaceVariant,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            indent: 60,
            endIndent: 16,
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
      ],
    );
  }
}
