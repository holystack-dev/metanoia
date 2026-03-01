import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/features/examination/data/examination_repository.dart';
import 'package:confessionapp/src/features/examination/presentation/examination_controller.dart';
import 'package:confessionapp/src/features/examination/presentation/widgets/examination_summary_sheet.dart';
import 'package:confessionapp/src/features/examination/presentation/widgets/question_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A single item representing a question with its context
class _QuestionItem {
  final String id;
  final String text;
  final String commandmentNumber; // e.g., "Commandment 1" or "General"
  final String commandmentTitle;  // e.g., "Love God with all your heart"
  final int sectionIndex;         // Index of the commandment section
  final bool isCustom;

  _QuestionItem({
    required this.id,
    required this.text,
    required this.commandmentNumber,
    required this.commandmentTitle,
    required this.sectionIndex,
    this.isCustom = false,
  });
}

/// Focused examination view - one question at a time with centered card
class FocusedExaminationView extends ConsumerStatefulWidget {
  final List<CommandmentWithQuestions> data;
  final VoidCallback onFinish;

  const FocusedExaminationView({
    super.key,
    required this.data,
    required this.onFinish,
  });

  @override
  ConsumerState<FocusedExaminationView> createState() =>
      _FocusedExaminationViewState();
}

class _FocusedExaminationViewState
    extends ConsumerState<FocusedExaminationView> {
  List<_QuestionItem> _allQuestions = [];
  int _currentIndex = 0;
  bool _isInitialized = false;
  Map<int, int> _sectionFirstQuestionIndex = {};
  late ScrollController _milestoneScrollController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _milestoneScrollController = ScrollController();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _milestoneScrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _buildQuestionList() {
    final l10n = AppLocalizations.of(context);
    _allQuestions = [];
    _sectionFirstQuestionIndex = {};

    for (int sectionIndex = 0; sectionIndex < widget.data.length; sectionIndex++) {
      final section = widget.data[sectionIndex];

      if (section.questions.isNotEmpty || section.customSins.isNotEmpty) {
        _sectionFirstQuestionIndex[sectionIndex] = _allQuestions.length;
      }

      // customTitle = "Commandment 1", content = "I am the Lord your God..."
      final commandmentNumber = section.isGeneral
          ? l10n?.general ?? 'General'
          : section.commandment?.customTitle ?? '${l10n?.commandment ?? 'Commandment'} ${section.commandment?.commandmentNo ?? ''}';

      final commandmentTitle = section.isGeneral
          ? ''
          : section.commandment?.content ?? '';

      for (final question in section.questions) {
        _allQuestions.add(_QuestionItem(
          id: question.id,
          text: question.question,
          commandmentNumber: commandmentNumber,
          commandmentTitle: commandmentTitle,
          sectionIndex: sectionIndex,
        ));
      }

      for (final customSin in section.customSins) {
        _allQuestions.add(_QuestionItem(
          id: 'custom-${customSin.id}',
          text: customSin.sinText,
          commandmentNumber: commandmentNumber,
          commandmentTitle: commandmentTitle,
          sectionIndex: sectionIndex,
          isCustom: true,
        ));
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Build question list here where context is available
    if (!_isInitialized) {
      _isInitialized = true;
      _buildQuestionList();
    }
  }

  void _handleAnswer(bool isYes) async {
    if (_currentIndex >= _allQuestions.length) return;

    HapticUtils.mediumImpact();

    final question = _allQuestions[_currentIndex];
    final controller = ref.read(examinationControllerProvider.notifier);

    if (isYes) {
      await controller.selectQuestion(question.id, question.text);
    }

    _advanceToNext();
  }

  void _handleSkip() {
    if (_currentIndex >= _allQuestions.length) return;

    HapticUtils.lightImpact();
    _advanceToNext();
  }

  void _onPageChanged(int index) {
    if (index == _currentIndex) return;

    HapticUtils.lightImpact();

    setState(() {
      _currentIndex = index;
    });
  }

  void _advanceToNext() {
    if (_currentIndex >= _allQuestions.length - 1) {
      final selections = ref.read(examinationControllerProvider);
      _showSummarySheet(context, selections);
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _jumpToSection(int sectionIndex) {
    final targetQuestionIndex = _sectionFirstQuestionIndex[sectionIndex];
    if (targetQuestionIndex == null) return;
    if (targetQuestionIndex == _currentIndex) return;

    HapticUtils.selectionClick();

    _pageController.animateToPage(
      targetQuestionIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToCurrentSection() {
    if (!_milestoneScrollController.hasClients) return;

    final currentSectionIndex = _allQuestions.isNotEmpty
        ? _allQuestions[_currentIndex].sectionIndex
        : 0;

    // Each chip is approximately 36px wide with 8px spacing
    const chipWidth = 36.0;
    const spacing = 8.0;
    final targetOffset = (currentSectionIndex * (chipWidth + spacing)) -
        (_milestoneScrollController.position.viewportDimension / 2) +
        (chipWidth / 2);

    _milestoneScrollController.animateTo(
      targetOffset.clamp(0.0, _milestoneScrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  int _getSelectedCountForSection(int sectionIndex, Map<String, String> selections) {
    return _allQuestions
        .where((q) => q.sectionIndex == sectionIndex && selections.containsKey(q.id))
        .length;
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

  Widget _buildMilestoneBar(ColorScheme colorScheme, Map<String, String> selections) {
    final currentSectionIndex = _allQuestions.isNotEmpty
        ? _allQuestions[_currentIndex].sectionIndex
        : 0;

    // Schedule scroll after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentSection();
    });

    return SizedBox(
      height: 40,
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.transparent,
              colorScheme.surface,
              colorScheme.surface,
              Colors.transparent,
            ],
            stops: const [0.0, 0.05, 0.95, 1.0],
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: ListView.separated(
          controller: _milestoneScrollController,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: widget.data.length,
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final section = widget.data[index];
            final hasSelections = _getSelectedCountForSection(index, selections) > 0;
            final isCurrent = index == currentSectionIndex;
            final isPast = index < currentSectionIndex;
            final isGeneral = section.isGeneral;
            final hasQuestions = _sectionFirstQuestionIndex.containsKey(index);

            final label = isGeneral
                ? 'G'
                : '${section.commandment?.commandmentNo ?? index + 1}';

            return _MilestoneChip(
              label: label,
              isCurrent: isCurrent,
              isPast: isPast,
              hasSelections: hasSelections,
              isDisabled: !hasQuestions,
              onTap: hasQuestions ? () => _jumpToSection(index) : null,
              colorScheme: colorScheme,
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    // Watch the selection state for the current question
    final selections = ref.watch(examinationControllerProvider);

    if (_allQuestions.isEmpty) {
      return Center(
        child: Text(
          l10n.noQuestionsInSection,
          style: theme.textTheme.bodyLarge,
        ),
      );
    }

    final currentQuestion = _allQuestions[_currentIndex];
    final progress = (_currentIndex + 1) / _allQuestions.length;
    final selectedCount = selections.length;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l10n.questionProgress(_currentIndex + 1, _allQuestions.length),
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamilyLato,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (selectedCount > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        l10n.selected(selectedCount),
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamilyLato,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),

        _buildMilestoneBar(colorScheme, selections),

        Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Column(
              key: ValueKey('cmd-${currentQuestion.commandmentNumber}'),
              children: [
                Text(
                  currentQuestion.commandmentNumber,
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamilyLato,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.primary,
                    letterSpacing: 0.5,
                  ),
                ),
                // Only show title if it's different from the commandment number
                if (currentQuestion.commandmentTitle.isNotEmpty &&
                    currentQuestion.commandmentTitle != currentQuestion.commandmentNumber) ...[
                  const SizedBox(height: 4),
                  Text(
                    currentQuestion.commandmentTitle,
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamilyEBGaramond,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ),

        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: _allQuestions.length,
            itemBuilder: (context, index) {
              final question = _allQuestions[index];
              final questionSelected = selections.containsKey(question.id);
              return Center(
                child: SingleChildScrollView(
                  child: QuestionCard(
                    questionText: question.text,
                    isSelected: questionSelected,
                  ),
                ),
              );
            },
          ),
        ),

        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
            child: Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    label: l10n.noThisDoesnt,
                    icon: Icons.close_rounded,
                    onPressed: () => _handleAnswer(false),
                    style: _ActionButtonStyle.outline,
                    colorScheme: colorScheme,
                  ),
                ),
                const SizedBox(width: 12),
                _ActionButton(
                  label: _currentIndex >= _allQuestions.length - 1
                      ? l10n.finishExamination
                      : l10n.skipQuestion,
                  icon: _currentIndex >= _allQuestions.length - 1
                      ? Icons.done_all_rounded
                      : Icons.arrow_forward_rounded,
                  onPressed: _handleSkip,
                  style: _ActionButtonStyle.text,
                  colorScheme: colorScheme,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _ActionButton(
                    label: l10n.yesThisApplies,
                    icon: Icons.check_rounded,
                    onPressed: () => _handleAnswer(true),
                    style: _ActionButtonStyle.filled,
                    colorScheme: colorScheme,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

enum _ActionButtonStyle { filled, outline, text }

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final _ActionButtonStyle style;
  final ColorScheme colorScheme;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.style,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case _ActionButtonStyle.filled:
        return FilledButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, size: 20),
          label: Text(label),
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        );
      case _ActionButtonStyle.outline:
        return OutlinedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, size: 20),
          label: Text(label),
          style: OutlinedButton.styleFrom(
            foregroundColor: colorScheme.onSurfaceVariant,
            side: BorderSide(color: colorScheme.outlineVariant),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        );
      case _ActionButtonStyle.text:
        return TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: colorScheme.onSurfaceVariant,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 20),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        );
    }
  }
}

/// Milestone chip for commandment navigation
class _MilestoneChip extends StatelessWidget {
  final String label;
  final bool isCurrent;
  final bool isPast;
  final bool hasSelections;
  final bool isDisabled;
  final VoidCallback? onTap;
  final ColorScheme colorScheme;

  const _MilestoneChip({
    required this.label,
    required this.isCurrent,
    required this.isPast,
    required this.hasSelections,
    required this.isDisabled,
    required this.onTap,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;
    Color borderColor;
    double borderWidth;

    if (isDisabled) {
      // Disabled - very muted
      backgroundColor = colorScheme.surfaceContainerLow;
      textColor = colorScheme.onSurface.withValues(alpha: 0.3);
      borderColor = colorScheme.outlineVariant.withValues(alpha: 0.3);
      borderWidth = 1.0;
    } else if (isCurrent) {
      // Current - prominent primary color
      backgroundColor = colorScheme.primary;
      textColor = colorScheme.onPrimary;
      borderColor = colorScheme.primary;
      borderWidth = 2.0;
    } else if (hasSelections) {
      // Has selections - highlighted with secondary color
      backgroundColor = colorScheme.secondaryContainer;
      textColor = colorScheme.onSecondaryContainer;
      borderColor = colorScheme.secondary;
      borderWidth = 1.5;
    } else if (isPast) {
      // Past without selections - muted
      backgroundColor = colorScheme.surfaceContainerHighest;
      textColor = colorScheme.onSurfaceVariant;
      borderColor = colorScheme.outline;
      borderWidth = 1.0;
    } else {
      // Future - outline only
      backgroundColor = colorScheme.surface;
      textColor = colorScheme.onSurfaceVariant;
      borderColor = colorScheme.outlineVariant;
      borderWidth = 1.0;
    }

    return GestureDetector(
      onTap: isDisabled ? null : () {
        HapticUtils.selectionClick();
        onTap?.call();
      },
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontFamily: AppTheme.fontFamilyLato,
            fontSize: 13,
            fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
