import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/theme/app_showcase.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/features/examination/data/examination_repository.dart';
import 'package:confessionapp/src/features/examination/presentation/examination_controller.dart'
    show examinationControllerProvider, kLastExaminationPageKey;
import 'package:confessionapp/src/features/examination/presentation/widgets/examination_summary_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Guided examination view - one commandment at a time with horizontal navigation
class GuidedExaminationView extends ConsumerStatefulWidget {
  final List<CommandmentWithQuestions> data;
  final VoidCallback onFinish;
  final Function(String?) onAddCustomSin;
  final GlobalKey? swipeShowcaseKey;
  final GlobalKey? selectShowcaseKey;
  final GlobalKey? finishShowcaseKey;

  const GuidedExaminationView({
    super.key,
    required this.data,
    required this.onFinish,
    required this.onAddCustomSin,
    this.swipeShowcaseKey,
    this.selectShowcaseKey,
    this.finishShowcaseKey,
  });

  @override
  ConsumerState<GuidedExaminationView> createState() =>
      _GuidedExaminationViewState();
}

class _GuidedExaminationViewState extends ConsumerState<GuidedExaminationView> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _loadLastPosition();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _loadLastPosition() async {
    final prefs = await SharedPreferences.getInstance();
    final lastPage = prefs.getInt(kLastExaminationPageKey) ?? 0;

    // Ensure the page is within bounds
    final validPage = lastPage.clamp(0, widget.data.length - 1);

    if (validPage > 0 && mounted) {
      setState(() {
        _currentPage = validPage;
      });
      // Jump to the saved position after the widget is built
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_pageController.hasClients) {
          _pageController.jumpToPage(validPage);
        }
      });
    }
  }

  Future<void> _saveCurrentPosition() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(kLastExaminationPageKey, _currentPage);
  }

  void _goToPage(int page) {
    HapticUtils.lightImpact();
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _nextPage() {
    if (_currentPage < widget.data.length - 1) {
      _goToPage(_currentPage + 1);
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _goToPage(_currentPage - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final selectedQuestions = ref.watch(examinationControllerProvider);

    return Column(
      children: [
        // Progress indicator
        _buildProgressHeader(context, theme, l10n),

        // Page view with commandments
        Expanded(
          child: _buildPageViewWithShowcase(context, l10n, selectedQuestions),
        ),

        // Navigation buttons
        _buildNavigationBar(context, theme, l10n, selectedQuestions),
      ],
    );
  }

  Widget _buildProgressHeader(
    BuildContext context,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    final currentItem = widget.data[_currentPage];

    // Get selected count for current commandment
    final selectedQuestions = ref.watch(examinationControllerProvider);
    final selectedInSection = _getSelectedCountForItem(currentItem, selectedQuestions);
    final totalInSection = currentItem.questions.length + currentItem.customSins.length;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        children: [
          // Milestone progress bar with tappable dots
          _MilestoneProgressBar(
            totalSteps: widget.data.length,
            currentStep: _currentPage,
            selectedQuestions: selectedQuestions,
            data: widget.data,
            onStepTapped: _goToPage,
            getSelectedCountForItem: _getSelectedCountForItem,
            getTooltipForItem: (item) => _getTooltipForItem(item, l10n),
          ),
          const SizedBox(height: 12),

          // Commandment title and progress text
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentItem.isGeneral
                          ? l10n.noCommandment
                          : currentItem.commandment?.customTitle ??
                              '${l10n.commandment} ${currentItem.commandment?.commandmentNo}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    if (!currentItem.isGeneral &&
                        currentItem.commandment?.content != null &&
                        currentItem.commandment?.customTitle != currentItem.commandment?.content)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          currentItem.commandment!.content,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Progress badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  l10n.commandmentProgress(
                    _currentPage + 1,
                    widget.data.length,
                  ),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSecondaryContainer,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          // Selected count for this section
          if (selectedInSection > 0)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$selectedInSection / $totalInSection ${l10n.selectedLabel}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    ).animate().fadeIn();
  }

  Widget _buildPageViewWithShowcase(
    BuildContext context,
    AppLocalizations l10n,
    Map<String, String> selectedQuestions,
  ) {
    final pageView = PageView.builder(
      controller: _pageController,
      onPageChanged: (page) {
        setState(() {
          _currentPage = page;
        });
        _saveCurrentPosition();
        HapticUtils.lightImpact();
      },
      itemCount: widget.data.length,
      itemBuilder: (context, index) {
        final item = widget.data[index];
        return _buildCommandmentPage(
          context,
          item,
          selectedQuestions,
          index == 0, // isFirstPage - show select showcase on first page
        );
      },
    );

    // Wrap with swipe showcase if key is provided
    if (widget.swipeShowcaseKey != null) {
      return AppShowcase(
        showcaseKey: widget.swipeShowcaseKey!,
        title: l10n.examineTitle,
        description: l10n.tutorialSwipeDesc,
        currentStep: 1,
        totalSteps: 5,
        shapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: pageView,
      );
    }

    return pageView;
  }

  Widget _buildCommandmentPage(
    BuildContext context,
    CommandmentWithQuestions item,
    Map<String, String> selectedQuestions,
    bool isFirstPage,
  ) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final allItems = <Widget>[];

    // Standard questions
    for (int i = 0; i < item.questions.length; i++) {
      final q = item.questions[i];
      final isSelected = selectedQuestions.containsKey(q.id);

      Widget tile = _QuestionTile(
        question: q.question,
        isSelected: isSelected,
        isCustom: false,
        onTap: () {
          HapticUtils.selectionClick();
          final controller = ref.read(examinationControllerProvider.notifier);
          if (isSelected) {
            controller.unselectQuestion(q.id);
          } else {
            controller.selectQuestion(q.id, q.question);
          }
        },
      );

      // Wrap first question on first page with showcase
      if (i == 0 && isFirstPage && widget.selectShowcaseKey != null) {
        tile = AppShowcase(
          showcaseKey: widget.selectShowcaseKey!,
          title: l10n.examineTitle,
          description: l10n.tutorialSelectDesc,
          currentStep: 2,
          totalSteps: 5,
          shapeBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: tile,
        );
      }

      allItems.add(tile);
    }

    // Custom sins
    for (final customSin in item.customSins) {
      final customSinId = 'custom-${customSin.id}';
      final isSelected = selectedQuestions.containsKey(customSinId);
      allItems.add(
        _QuestionTile(
          question: customSin.sinText,
          isSelected: isSelected,
          isCustom: true,
          onTap: () {
            HapticUtils.selectionClick();
            final controller = ref.read(examinationControllerProvider.notifier);
            if (isSelected) {
              controller.unselectQuestion(customSinId);
            } else {
              controller.selectQuestion(customSinId, customSin.sinText);
            }
          },
        ),
      );
    }

    // Add your own (only for commandments 1-11)
    if (_shouldShowAddYourOwn(item)) {
      allItems.add(
        _AddYourOwnTile(
          onTap: () => widget.onAddCustomSin(
            item.isGeneral ? null : item.commandment?.code,
          ),
        ),
      );
    }

    // Empty state if no questions and no add option
    if (allItems.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 48,
                color: theme.colorScheme.primary.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 16),
              Text(
                l10n.noQuestionsInSection,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: allItems.length,
      itemBuilder: (context, index) {
        return allItems[index]
            .animate()
            .fadeIn(delay: (30 * index).ms)
            .slideX(begin: 0.05, end: 0);
      },
    );
  }

  bool _shouldShowAddYourOwn(CommandmentWithQuestions item) {
    if (item.isGeneral) return true;
    final commandmentNo = item.commandment?.commandmentNo;
    if (commandmentNo == null) return false;
    return commandmentNo <= 11;
  }

  Widget _buildNavigationBar(
    BuildContext context,
    ThemeData theme,
    AppLocalizations l10n,
    Map<String, String> selectedQuestions,
  ) {
    final isFirstPage = _currentPage == 0;
    final isLastPage = _currentPage == widget.data.length - 1;
    final hasSelections = selectedQuestions.isNotEmpty;

    return Container(
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
            // Previous button - icon on left (natural for "back")
            Expanded(
              child: OutlinedButton.icon(
                onPressed: isFirstPage ? null : _previousPage,
                icon: const Icon(Icons.chevron_left),
                label: Text(l10n.previousCommandment),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Next / Finish button - icon on right for "forward" direction
            Expanded(
              child: isLastPage
                  ? _buildFinishButton(context, l10n, hasSelections, selectedQuestions)
                  : FilledButton(
                      onPressed: _nextPage,
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(l10n.nextCommandment),
                          const SizedBox(width: 4),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinishButton(
    BuildContext context,
    AppLocalizations l10n,
    bool hasSelections,
    Map<String, String> selectedQuestions,
  ) {
    final button = FilledButton.icon(
      onPressed: hasSelections
          ? () => _showSummarySheet(context, selectedQuestions)
          : null,
      icon: const Icon(Icons.check),
      label: Text(l10n.finishExamination),
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );

    // Wrap with finish showcase if key is provided
    if (widget.finishShowcaseKey != null) {
      return AppShowcase(
        showcaseKey: widget.finishShowcaseKey!,
        title: l10n.finishExamination,
        description: l10n.tutorialFinishDesc,
        currentStep: 5,
        totalSteps: 5,
        shapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: button,
      );
    }

    return button;
  }

  int _getSelectedCountForItem(
    CommandmentWithQuestions item,
    Map<String, String> selectedQuestions,
  ) {
    int count = 0;
    // Count selected standard questions
    for (final q in item.questions) {
      if (selectedQuestions.containsKey(q.id)) count++;
    }
    // Count selected custom sins (custom-{id} format)
    for (final s in item.customSins) {
      if (selectedQuestions.containsKey('custom-${s.id}')) count++;
    }
    return count;
  }

  String _getTooltipForItem(CommandmentWithQuestions item, AppLocalizations l10n) {
    if (item.isGeneral) {
      return l10n.noCommandment;
    }
    return item.commandment?.customTitle ??
        '${l10n.commandment} ${item.commandment?.commandmentNo}';
  }

  void _showSummarySheet(BuildContext context, Map<String, String> selectedQuestions) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ExaminationSummarySheet(
        data: widget.data,
        selectedQuestions: selectedQuestions,
        onConfirm: () {
          Navigator.pop(context);
          widget.onFinish();
        },
        onCancel: () => Navigator.pop(context),
      ),
    );
  }
}

class _QuestionTile extends StatelessWidget {
  final String question;
  final bool isSelected;
  final bool isCustom;
  final VoidCallback onTap;

  const _QuestionTile({
    required this.question,
    required this.isSelected,
    required this.isCustom,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      color: isSelected
          ? (isCustom
              ? theme.colorScheme.secondaryContainer.withValues(alpha: 0.5)
              : theme.colorScheme.primaryContainer.withValues(alpha: 0.5))
          : theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected
              ? (isCustom
                  ? theme.colorScheme.secondary.withValues(alpha: 0.5)
                  : theme.colorScheme.primary.withValues(alpha: 0.5))
              : theme.colorScheme.outlineVariant,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                isSelected ? Icons.check_box : Icons.check_box_outline_blank,
                color: isSelected
                    ? (isCustom
                        ? theme.colorScheme.secondary
                        : theme.colorScheme.primary)
                    : theme.colorScheme.onSurfaceVariant,
                size: 24,
              ),
              const SizedBox(width: 12),
              if (isCustom) ...[
                Icon(
                  Icons.auto_awesome,
                  size: 16,
                  color: theme.colorScheme.secondary,
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  question,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isSelected
                        ? theme.colorScheme.onSurface
                        : theme.colorScheme.onSurfaceVariant,
                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
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

class _AddYourOwnTile extends StatelessWidget {
  final VoidCallback onTap;

  const _AddYourOwnTile({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      color: theme.colorScheme.secondaryContainer.withValues(alpha: 0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.secondary.withValues(alpha: 0.3),
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      child: InkWell(
        onTap: () {
          HapticUtils.lightImpact();
          onTap();
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Icon(
                Icons.add_circle_outline,
                color: theme.colorScheme.secondary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  l10n.addYourOwn,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.secondary,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.secondary.withValues(alpha: 0.7),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Milestone-style progress bar with scrollable numbered chips
/// Displays commandment numbers in a horizontal scrollable row
/// with clear visual states for current, completed, and pending items
class _MilestoneProgressBar extends StatefulWidget {
  final int totalSteps;
  final int currentStep;
  final Map<String, String> selectedQuestions;
  final List<CommandmentWithQuestions> data;
  final Function(int) onStepTapped;
  final int Function(CommandmentWithQuestions, Map<String, String>) getSelectedCountForItem;
  final String Function(CommandmentWithQuestions) getTooltipForItem;

  const _MilestoneProgressBar({
    required this.totalSteps,
    required this.currentStep,
    required this.selectedQuestions,
    required this.data,
    required this.onStepTapped,
    required this.getSelectedCountForItem,
    required this.getTooltipForItem,
  });

  @override
  State<_MilestoneProgressBar> createState() => _MilestoneProgressBarState();
}

class _MilestoneProgressBarState extends State<_MilestoneProgressBar> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentStep();
    });
  }

  @override
  void didUpdateWidget(_MilestoneProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentStep != widget.currentStep) {
      _scrollToCurrentStep();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCurrentStep() {
    if (!_scrollController.hasClients) return;

    // Each chip is approximately 36px wide with 8px spacing
    const chipWidth = 36.0;
    const spacing = 8.0;
    final targetOffset = (widget.currentStep * (chipWidth + spacing)) -
        (_scrollController.position.viewportDimension / 2) +
        (chipWidth / 2);

    _scrollController.animateTo(
      targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 40,
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.transparent,
              theme.colorScheme.surface,
              theme.colorScheme.surface,
              Colors.transparent,
            ],
            stops: const [0.0, 0.05, 0.95, 1.0],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: ListView.separated(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: widget.totalSteps,
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final hasSelections =
                widget.getSelectedCountForItem(widget.data[index], widget.selectedQuestions) > 0;
            final isCurrent = index == widget.currentStep;
            final isPast = index < widget.currentStep;
            final isGeneral = widget.data[index].isGeneral;

            return _MilestoneChip(
              label: isGeneral ? 'G' : '${widget.data[index].commandment?.commandmentNo ?? index + 1}',
              isCurrent: isCurrent,
              isPast: isPast,
              hasSelections: hasSelections,
              tooltip: widget.getTooltipForItem(widget.data[index]),
              onTap: () => widget.onStepTapped(index),
            );
          },
        ),
      ),
    );
  }
}

/// Individual milestone chip showing commandment number with status
class _MilestoneChip extends StatelessWidget {
  final String label;
  final bool isCurrent;
  final bool isPast;
  final bool hasSelections;
  final String tooltip;
  final VoidCallback onTap;

  const _MilestoneChip({
    required this.label,
    required this.isCurrent,
    required this.isPast,
    required this.hasSelections,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color backgroundColor;
    Color textColor;
    Color borderColor;
    double borderWidth;

    if (isCurrent) {
      // Current - prominent primary color
      backgroundColor = theme.colorScheme.primary;
      textColor = theme.colorScheme.onPrimary;
      borderColor = theme.colorScheme.primary;
      borderWidth = 2.0;
    } else if (hasSelections) {
      // Has selections - highlighted with secondary color
      backgroundColor = theme.colorScheme.secondaryContainer;
      textColor = theme.colorScheme.onSecondaryContainer;
      borderColor = theme.colorScheme.secondary;
      borderWidth = 1.5;
    } else if (isPast) {
      // Past without selections - muted
      backgroundColor = theme.colorScheme.surfaceContainerHighest;
      textColor = theme.colorScheme.onSurfaceVariant;
      borderColor = theme.colorScheme.outline;
      borderWidth = 1.0;
    } else {
      // Future - outline only
      backgroundColor = theme.colorScheme.surface;
      textColor = theme.colorScheme.onSurfaceVariant;
      borderColor = theme.colorScheme.outlineVariant;
      borderWidth = 1.0;
    }

    return Tooltip(
      message: tooltip,
      preferBelow: true,
      triggerMode: TooltipTriggerMode.longPress,
      child: GestureDetector(
        onTap: () {
          HapticUtils.lightImpact();
          onTap();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: borderColor,
              width: borderWidth,
            ),
            boxShadow: isCurrent
                ? [
                    BoxShadow(
                      color: theme.colorScheme.primary.withValues(alpha: 0.3),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: Stack(
            children: [
              // Commandment number
              Center(
                child: Text(
                  label,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: textColor,
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.w600,
                  ),
                ),
              ),
              // Selection indicator dot
              if (hasSelections && !isCurrent)
                Positioned(
                  top: 2,
                  right: 2,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: backgroundColor,
                        width: 1,
                      ),
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
