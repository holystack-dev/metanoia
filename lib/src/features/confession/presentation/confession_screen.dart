import 'package:confessionapp/src/core/services/in_app_review_service.dart';
import 'package:confessionapp/src/core/services/spread_the_word_service.dart';
import 'package:confessionapp/src/core/widgets/rating_gate.dart';
import 'package:confessionapp/src/core/theme/app_radius.dart';
import 'package:confessionapp/src/core/theme/app_showcase.dart';
import 'package:confessionapp/src/core/tutorial/tutorial_controller.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/features/confession/data/confession_analytics_repository.dart';
import 'package:confessionapp/src/features/confession/data/confession_repository.dart';
import 'package:confessionapp/src/features/confession/data/penance_repository.dart';
import 'package:confessionapp/src/features/journal/data/journal_repository.dart'
    show journalRepositoryProvider;
import 'package:confessionapp/src/features/settings/presentation/settings_screen.dart'
    show keepHistorySettingsProvider;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:showcaseview/showcaseview.dart';

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
              borderRadius: BorderRadius.circular(AppRadius.tile),
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
                            borderRadius: BorderRadius.circular(AppRadius.card),
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
                        .fadeIn(duration: 150.ms);
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).colorScheme.shadow.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Entry point to Confession-day mode: the distraction-free,
                      // extra-large view meant to be opened in the confessional
                      // itself, right before the sins are read out.
                      OutlinedButton.icon(
                        onPressed: () {
                          HapticUtils.mediumImpact();
                          context.push('/confess/day-mode');
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.tile),
                          ),
                        ),
                        icon: const Icon(Icons.nightlight_round),
                        label: Text(l10n.confessionDayMode),
                      ),
                      const SizedBox(height: 12),
                      FilledButton.icon(
                        onPressed: () => _showFinishConfessionSheet(
                          context,
                          ref,
                          data,
                          l10n,
                        ),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppRadius.tile),
                          ),
                        ),
                        icon: const Icon(Icons.check),
                        label: Text(l10n.finishConfession),
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(delay: 150.ms).moveY(begin: 20, end: 0),
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
        confessionId: data.confession.id,
        onComplete: (penanceText, {required bool penanceEdited}) async {
          Navigator.pop(sheetContext);

          final keepHistory = await ref.read(
            keepHistorySettingsProvider.future,
          );

          // Stamp the journal marks this confession carried before finishing
          // it: with history off, finishing discards the items they are matched
          // against.
          await ref
              .read(journalRepositoryProvider)
              .markConfessedFromItems(
                data.confession.id,
                data.items,
                keepHistory: keepHistory,
              );

          await ref
              .read(confessionRepositoryProvider)
              .markConfessionAsFinished(
                data.confession.id,
                keepHistory: keepHistory,
              );

          // The field is seeded from any stored penance, so it is the whole
          // truth — but only once the user has touched it. An untouched empty
          // field means the seed had not arrived yet (the Drift stream emits a
          // frame or two after the sheet opens), not that the penance was
          // cleared, and deleting on that would throw away what the priest
          // assigned.
          final penanceRepository = ref.read(penanceRepositoryProvider);
          final stored = await penanceRepository.getPenanceForConfession(
            data.confession.id,
          );

          if (penanceText != null && penanceText.isNotEmpty) {
            if (penanceText != stored?.description) {
              await penanceRepository.addPenance(
                data.confession.id,
                penanceText,
              );
            }
          } else if (penanceEdited && stored != null) {
            await penanceRepository.deletePenance(stored.id);
          }

          // No invalidation: the confession, draft, penance and history
          // providers are Drift streams and have already re-emitted.

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
      // Ask inside the app first, with stars. A happy rating (4–5) is sent to
      // the store; an unhappy one is thanked privately and goes no further.
      final stars = await showRatingGate(context);
      // Both rating surfaces must be told, or they ask twice: this flow uses
      // `review_opt_out`, and the home card reads only `spread_rating_handled`.
      final spreadService = SpreadTheWordService();
      if (stars == null) {
        // Dismissed without choosing — leave the door open to ask again after
        // a couple more confessions rather than opting them out for good.
        await reviewService.resetCounters();
        await spreadService.snooze();
      } else {
        // They have been through the gate; do not ask again automatically.
        await reviewService.setOptOut(true);
        await spreadService.markRatingHandled();
      }
    }
  }
}

/// Bottom sheet for completing a confession, with the penance field seeded from
/// whatever is already stored for it — normally typed in confession-day mode,
/// in the confessional itself.
class _FinishConfessionSheet extends ConsumerStatefulWidget {
  final AppLocalizations l10n;
  final int confessionId;
  final Future<void> Function(String? penanceText, {required bool penanceEdited})
  onComplete;
  final Future<void> Function() onDelete;

  const _FinishConfessionSheet({
    required this.l10n,
    required this.confessionId,
    required this.onComplete,
    required this.onDelete,
  });

  @override
  ConsumerState<_FinishConfessionSheet> createState() =>
      _FinishConfessionSheetState();
}

class _FinishConfessionSheetState
    extends ConsumerState<_FinishConfessionSheet> {
  final _penanceController = TextEditingController();
  final _scrollController = ScrollController();
  final _penanceFocusNode = FocusNode();
  bool _isLoading = false;
  double _bottomInset = 0;

  /// Whether the user has touched the field. Once they have, a later emission of
  /// the Drift stream must not seed over what they are typing.
  bool _dirty = false;

  @override
  void initState() {
    super.initState();
    _penanceFocusNode.addListener(_onFocusChange);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // The real keyboard height, from the live view insets.
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final wasVisible = _bottomInset > 0;
    _bottomInset = bottomInset;

    if (wasVisible && bottomInset == 0) {
      // Scroll back to top when the keyboard hides. Deferred: this runs during
      // build, and the scroll position is not attached yet on the first pass.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _scrollTo(0);
      });
    }
  }

  void _onFocusChange() {
    if (!_penanceFocusNode.hasFocus) return;

    // The keyboard animates in, so the scroll extent grows over a few frames;
    // nudge the field back into view as it does.
    for (final delay in [100, 300, 500]) {
      Future.delayed(Duration(milliseconds: delay), () {
        if (!mounted || !_scrollController.hasClients) return;
        _scrollTo(_scrollController.position.maxScrollExtent);
      });
    }
  }

  void _scrollTo(double offset) {
    if (!_scrollController.hasClients) return;
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
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

    final keyboardPadding = MediaQuery.viewInsetsOf(context).bottom;

    // Seed once from the stored penance, never over the user's own typing, and
    // never again once they have edited it — clearing it on purpose must stick.
    final storedPenance =
        ref.watch(penanceForConfessionProvider(widget.confessionId)).valueOrNull;
    final hasStoredPenance = storedPenance != null;
    if (!_dirty && hasStoredPenance && _penanceController.text.isEmpty) {
      _penanceController.text = storedPenance.description;
    }

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.sheet)),
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
                    borderRadius: BorderRadius.circular(AppRadius.bar),
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
                          // Already captured in the confessional: this is the
                          // penance, not an invitation to add one.
                          hasStoredPenance ? l10n.penance : l10n.addPenance,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (!hasStoredPenance) ...[
                          const SizedBox(width: 8),
                          Text(
                            '(${l10n.skipPenance.toLowerCase()})',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _penanceController,
                      focusNode: _penanceFocusNode,
                      onChanged: (_) {
                        if (!_dirty) setState(() => _dirty = true);
                      },
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
                                penanceEdited: _dirty,
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
                borderRadius: BorderRadius.circular(AppRadius.tile),
              ),
            ),
          ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1),
          const SizedBox(height: 24),

          // The three cards below are fed by Drift streams, so they are not
          // animated: an entrance fade on a stream-fed subtree replays on every
          // emission.

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
            // An inviting "begin an examination" glyph (matching the home CTA),
            // not a success check — nothing is done yet, there's nothing here.
            Icons.assignment_outlined,
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
          borderRadius: BorderRadius.circular(AppRadius.card),
          child: Card(
            elevation: 0,
            color: theme.colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.card),
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
                          // Calm "regular return" glyph, not a fire/streak flame.
                          icon: Icons.event_repeat,
                          value: '${analytics.currentStreakWeeks}',
                          label: l10n.currentStreak,
                          color: theme.colorScheme.secondary,
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
    );
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
          borderRadius: BorderRadius.circular(AppRadius.card),
          child: Card(
            elevation: 0,
            color: theme.colorScheme.errorContainer.withValues(alpha: 0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.card),
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
                          borderRadius: BorderRadius.circular(AppRadius.chip),
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
                              l10n.pendingCount(penances.length),
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
                      borderRadius: BorderRadius.circular(AppRadius.chip),
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
    );
  }

  Widget _buildRecentHistory(
    BuildContext context,
    ThemeData theme,
    List<ConfessionWithItems> history,
  ) {
    final recentHistory = history.take(3).toList();
    final dateFormat = DateFormat.yMMMd(
      Localizations.localeOf(context).toString(),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            HapticUtils.lightImpact();
            context.go('/confess/history');
          },
          borderRadius: BorderRadius.circular(AppRadius.card),
          child: Card(
            elevation: 0,
            color: theme.colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.card),
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
                        l10n.totalCount(history.length),
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
                            l10n.itemsCount(confession.items.length),
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
    );
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
            borderRadius: BorderRadius.circular(AppRadius.chip),
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
