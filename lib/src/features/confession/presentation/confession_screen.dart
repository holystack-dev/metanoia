import 'package:confessionapp/src/core/database/database_provider.dart';
import 'package:confessionapp/src/core/services/in_app_review_service.dart';
import 'package:confessionapp/src/core/theme/app_showcase.dart';
import 'package:confessionapp/src/core/tutorial/tutorial_controller.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/features/confession/data/confession_analytics_repository.dart';
import 'package:confessionapp/src/features/confession/data/confession_repository.dart';
import 'package:confessionapp/src/features/confession/data/penance_repository.dart';
import 'package:confessionapp/src/features/settings/presentation/settings_screen.dart'
    show keepHistorySettingsProvider;
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:showcaseview/showcaseview.dart';

part 'confession_screen.g.dart';

class ConfessionScreen extends StatelessWidget {
  const ConfessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return ShowCaseWidget(
      blurValue: 1,
      enableAutoScroll: true,
      builder: (context) => const _ConfessionScreenContent(),
    );
  }
}

class _ConfessionScreenContent extends ConsumerStatefulWidget {
  const _ConfessionScreenContent();

  @override
  ConsumerState<_ConfessionScreenContent> createState() =>
      _ConfessionScreenContentState();
}

class _ConfessionScreenContentState
    extends ConsumerState<_ConfessionScreenContent> {
  final GlobalKey _penanceKey = GlobalKey();
  final GlobalKey _insightsKey = GlobalKey();
  final GlobalKey _historyKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowTutorial();
    });
  }

  Future<void> _checkAndShowTutorial() async {
    final controller = ref.read(tutorialControllerProvider.notifier);
    final shouldShow = await controller.shouldShowConfessionTutorial();

    if (shouldShow && mounted) {
      // ignore: deprecated_member_use
      ShowCaseWidget.of(context).startShowCase([
        _penanceKey,
        _insightsKey,
        _historyKey,
      ]);
      await controller.markConfessionTutorialShown();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final confessionData = ref.watch(activeConfessionProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.confessTitle),
        actions: [
          AppShowcase(
            showcaseKey: _penanceKey,
            title: l10n.penance,
            description: l10n.tutorialPenanceDesc,
            currentStep: 1,
            totalSteps: 3,
            shapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final screenWidth = MediaQuery.of(context).size.width;
                final showLabel = screenWidth > 360;

                if (showLabel) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: FilledButton.tonalIcon(
                      onPressed: () {
                        HapticUtils.lightImpact();
                        context.go('/confess/penance');
                      },
                      icon: const Icon(Icons.health_and_safety, size: 18),
                      label: Text(l10n.penance),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                  );
                }
                return IconButton(
                  icon: const Icon(Icons.health_and_safety),
                  tooltip: l10n.penanceTracker,
                  onPressed: () {
                    HapticUtils.lightImpact();
                    context.go('/confess/penance');
                  },
                );
              },
            ),
          ),
          AppShowcase(
            showcaseKey: _insightsKey,
            title: l10n.insights,
            description: l10n.tutorialInsightsDesc,
            currentStep: 2,
            totalSteps: 3,
            child: IconButton(
              icon: const Icon(Icons.insights),
              tooltip: l10n.insights,
              onPressed: () {
                HapticUtils.lightImpact();
                context.go('/confess/insights');
              },
            ),
          ),
          AppShowcase(
            showcaseKey: _historyKey,
            title: l10n.viewHistory,
            description: l10n.tutorialHistoryDesc,
            currentStep: 3,
            totalSteps: 3,
            child: IconButton(
              icon: const Icon(Icons.history),
              tooltip: l10n.viewHistory,
              onPressed: () {
                HapticUtils.lightImpact();
                context.go('/confess/history');
              },
            ),
          ),
        ],
      ),
      body: confessionData.when(
        data: (data) {
          if (data == null || data.items.isEmpty) {
            return _EmptyConfessionView(l10n: l10n);
          }

          final items = data.items;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Card(
                          elevation: 0,
                          margin: const EdgeInsets.only(bottom: 12),
                          color: Theme.of(context).colorScheme.surface,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                              color:
                                  Theme.of(context).colorScheme.outlineVariant,
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(
                                          context,
                                        ).colorScheme.secondaryContainer,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    '${index + 1}',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleSmall?.copyWith(
                                      color:
                                          Theme.of(
                                            context,
                                          ).colorScheme.onSecondaryContainer,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      item.content,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(delay: (100 * index).ms)
                        .slideX(begin: 0.1, end: 0);
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: () => _showFinishConfessionSheet(
                        context,
                        ref,
                        data,
                        l10n,
                      ),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.check),
                      label: Text(l10n.finishConfession),
                    ),
                  ),
                ),
              ).animate().fadeIn(delay: 500.ms).moveY(begin: 20, end: 0),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('${l10n.error}: $error')),
      ),
    );
  }

  void _showFinishConfessionSheet(
    BuildContext context,
    WidgetRef ref,
    ConfessionWithItems data,
    AppLocalizations l10n,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => _FinishConfessionSheet(
        l10n: l10n,
        onComplete: (penanceText) async {
          Navigator.pop(sheetContext);

          final keepHistory = await ref.read(
            keepHistorySettingsProvider.future,
          );
          await ref
              .read(confessionRepositoryProvider)
              .markConfessionAsFinished(
                data.confession.id,
                keepHistory: keepHistory,
              );

          // Save penance if provided
          if (penanceText != null && penanceText.isNotEmpty) {
            await ref
                .read(penanceRepositoryProvider)
                .addPenance(data.confession.id, penanceText);
            ref.invalidate(pendingPenancesProvider);
          }

          // Refresh state
          ref.invalidate(activeConfessionProvider);
          ref.invalidate(activeExaminationDraftProvider);
          ref.invalidate(lastFinishedConfessionProvider);

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.confessionCompletedMessage)),
            );
            _checkAndRequestReview(context);
          }
        },
        onDelete: () async {
          // Show delete confirmation
          final confirm = await showDialog<bool>(
            context: sheetContext,
            builder: (dialogContext) => AlertDialog(
              title: Text(l10n.deleteConfession),
              content: Text(l10n.deleteConfessionContent),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext, false),
                  child: Text(l10n.cancel),
                ),
                FilledButton(
                  onPressed: () => Navigator.pop(dialogContext, true),
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(dialogContext).colorScheme.error,
                  ),
                  child: Text(l10n.deleteConfession),
                ),
              ],
            ),
          );

          if (confirm == true) {
            HapticUtils.heavyImpact();
            await ref
                .read(confessionRepositoryProvider)
                .deleteConfession(data.confession.id);
            ref.invalidate(activeConfessionProvider);
            if (sheetContext.mounted) {
              Navigator.pop(sheetContext);
            }
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.confessionDeleted)),
              );
            }
          }
        },
      ),
    );
  }

  Future<void> _checkAndRequestReview(BuildContext context) async {
    final reviewService = InAppReviewService();
    final shouldPrompt = await reviewService.trackConfessionCompletion();

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
}

/// Bottom sheet for completing a confession with optional penance input
class _FinishConfessionSheet extends StatefulWidget {
  final AppLocalizations l10n;
  final Future<void> Function(String? penanceText) onComplete;
  final Future<void> Function() onDelete;

  const _FinishConfessionSheet({
    required this.l10n,
    required this.onComplete,
    required this.onDelete,
  });

  @override
  State<_FinishConfessionSheet> createState() => _FinishConfessionSheetState();
}

class _FinishConfessionSheetState extends State<_FinishConfessionSheet>
    with WidgetsBindingObserver {
  final _penanceController = TextEditingController();
  final _scrollController = ScrollController();
  final _penanceFocusNode = FocusNode();
  bool _isLoading = false;
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _penanceFocusNode.addListener(_onFocusChange);
  }

  @override
  void didChangeMetrics() {
    // Check keyboard visibility when metrics change
    final bottomInset = WidgetsBinding
        .instance.platformDispatcher.views.first.viewInsets.bottom;
    final keyboardVisible = bottomInset > 0;

    if (_isKeyboardVisible != keyboardVisible) {
      setState(() {
        _isKeyboardVisible = keyboardVisible;
      });

      if (!keyboardVisible) {
        // Scroll back to top when keyboard hides
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted && _scrollController.hasClients) {
            _scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
            );
          }
        });
      }
    }
  }

  void _onFocusChange() {
    if (_penanceFocusNode.hasFocus) {
      setState(() {
        _isKeyboardVisible = true;
      });
      // Delay to allow keyboard to appear, then scroll multiple times
      for (final delay in [100, 300, 500]) {
        Future.delayed(Duration(milliseconds: delay), () {
          if (mounted && _scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
            );
          }
        });
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _penanceFocusNode.removeListener(_onFocusChange);
    _penanceFocusNode.dispose();
    _scrollController.dispose();
    _penanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = widget.l10n;

    // Use fixed keyboard height estimate when focused (300px covers most keyboards)
    final keyboardPadding = _isKeyboardVisible ? 300.0 : 0.0;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        controller: _scrollController,
        padding: EdgeInsets.only(bottom: keyboardPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_circle,
                        color: theme.colorScheme.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.finishConfessionTitle,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.finishConfessionContent,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.checklist,
                          color: theme.colorScheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          l10n.addPenance,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '(${l10n.skipPenance.toLowerCase()})',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _penanceController,
                      focusNode: _penanceFocusNode,
                      decoration: InputDecoration(
                        hintText: l10n.penanceHint,
                        border: const OutlineInputBorder(),
                      ),
                      maxLines: 2,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FilledButton.icon(
                      onPressed: _isLoading
                          ? null
                          : () async {
                              setState(() => _isLoading = true);
                              await widget.onComplete(
                                _penanceController.text.trim().isEmpty
                                    ? null
                                    : _penanceController.text.trim(),
                              );
                            },
                      icon: _isLoading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: theme.colorScheme.onPrimary,
                              ),
                            )
                          : const Icon(Icons.check),
                      label: Text(l10n.finish),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _isLoading
                                ? null
                                : () => Navigator.pop(context),
                            child: Text(l10n.cancel),
                          ),
                        ),
                        const SizedBox(width: 12),
                        TextButton(
                          onPressed: _isLoading ? null : widget.onDelete,
                          style: TextButton.styleFrom(
                            foregroundColor: theme.colorScheme.error,
                          ),
                          child: Text(l10n.deleteConfession),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Bottom padding: safe area
              SizedBox(
                height: MediaQuery.of(context).padding.bottom + 16,
              ),
            ],
          ),
        ),
    );
  }
}

@riverpod
Future<ConfessionWithItems?> activeConfession(Ref ref) async {
  final db = ref.watch(appDatabaseProvider);

  // Find the latest unfinished confession
  final confession =
      await (db.select(db.confessions)
            ..where((tbl) => tbl.isFinished.equals(false))
            ..orderBy([
              (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
            ])
            ..limit(1))
          .getSingleOrNull();

  if (confession == null) return null;

  final items =
      await (db.select(db.confessionItems)
        ..where((tbl) => tbl.confessionId.equals(confession.id))).get();

  return ConfessionWithItems(confession, items);
}

class _EmptyConfessionView extends ConsumerWidget {
  final AppLocalizations l10n;

  const _EmptyConfessionView({required this.l10n});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final analyticsAsync = ref.watch(confessionAnalyticsProvider);
    final penancesAsync = ref.watch(pendingPenancesProvider);
    final historyAsync = ref.watch(finishedConfessionsProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(context, theme),
          const SizedBox(height: 24),

          FilledButton.icon(
            onPressed: () {
              HapticUtils.mediumImpact();
              context.go('/examine');
            },
            icon: const Icon(Icons.assignment_outlined),
            label: Text(l10n.startExamination),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1),
          const SizedBox(height: 24),

          // Analytics Summary (only if has data)
          analyticsAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
            data: (analytics) {
              if (!analytics.hasData) return const SizedBox.shrink();
              return _buildAnalyticsSummary(context, theme, analytics);
            },
          ),

          penancesAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
            data: (penances) {
              if (penances.isEmpty) return const SizedBox.shrink();
              return _buildPendingPenances(context, theme, penances, ref);
            },
          ),

          historyAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
            data: (history) {
              if (history.isEmpty) return const SizedBox.shrink();
              return _buildRecentHistory(context, theme, history);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_circle_outline,
            size: 48,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          l10n.noActiveConfession,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.startExaminationPrompt,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ).animate().fadeIn().scale();
  }

  Widget _buildAnalyticsSummary(
    BuildContext context,
    ThemeData theme,
    ConfessionAnalytics analytics,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            HapticUtils.lightImpact();
            context.go('/confess/insights');
          },
          borderRadius: BorderRadius.circular(16),
          child: Card(
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
                      Icon(
                        Icons.insights,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n.insights,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.chevron_right,
                        color: theme.colorScheme.onSurfaceVariant,
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _StatItem(
                          icon: Icons.church,
                          value: analytics.totalConfessions.toString(),
                          label: l10n.totalConfessions,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      Expanded(
                        child: _StatItem(
                          icon: Icons.calendar_today,
                          value: analytics.daysSinceLastConfession.toString(),
                          label: l10n.daysSinceLastConfession,
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      Expanded(
                        child: _StatItem(
                          icon: Icons.local_fire_department,
                          value: '${analytics.currentStreakWeeks}',
                          label: l10n.currentStreak,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1);
  }

  Widget _buildPendingPenances(
    BuildContext context,
    ThemeData theme,
    List<PenanceWithConfession> penances,
    WidgetRef ref,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            HapticUtils.lightImpact();
            context.go('/confess/penance');
          },
          borderRadius: BorderRadius.circular(16),
          child: Card(
            elevation: 0,
            color: theme.colorScheme.errorContainer.withValues(alpha: 0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: theme.colorScheme.error.withValues(alpha: 0.3),
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
                          color: theme.colorScheme.error.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.checklist,
                          color: theme.colorScheme.error,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.pendingPenances,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${penances.length} pending',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.error,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: theme.colorScheme.onSurfaceVariant,
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            penances.first.penance.description,
                            style: theme.textTheme.bodyMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        FilledButton.tonal(
                          onPressed: () async {
                            HapticUtils.mediumImpact();
                            await ref
                                .read(penanceRepositoryProvider)
                                .completePenance(penances.first.penance.id);
                            ref.invalidate(pendingPenancesProvider);
                          },
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            visualDensity: VisualDensity.compact,
                          ),
                          child: const Icon(Icons.check, size: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1);
  }

  Widget _buildRecentHistory(
    BuildContext context,
    ThemeData theme,
    List<ConfessionWithItems> history,
  ) {
    final recentHistory = history.take(3).toList();
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            HapticUtils.lightImpact();
            context.go('/confess/history');
          },
          borderRadius: BorderRadius.circular(16),
          child: Card(
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
                      Icon(
                        Icons.history,
                        color: theme.colorScheme.secondary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n.viewHistory,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${history.length} total',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.chevron_right,
                        color: theme.colorScheme.onSurfaceVariant,
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...recentHistory.map((confession) {
                    final date = confession.confession.date;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check,
                              size: 12,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              dateFormat.format(date),
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                          Text(
                            '${confession.items.length} items',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ],
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1);
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
