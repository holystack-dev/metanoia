import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/theme/app_showcase.dart';
import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:confessionapp/src/core/tutorial/tutorial_controller.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/core/widgets/animated_count.dart';
import 'package:confessionapp/src/features/confession/data/confession_repository.dart';
import 'package:confessionapp/src/features/confession/presentation/confession_screen.dart';
import 'package:confessionapp/src/features/examination/data/examination_repository.dart';
import 'package:confessionapp/src/features/examination/data/user_custom_sins_repository.dart';
import 'package:confessionapp/src/features/examination/presentation/examination_controller.dart';
import 'package:confessionapp/src/features/examination/presentation/widgets/contemplative_entry.dart';
import 'package:confessionapp/src/features/examination/presentation/widgets/custom_sin_dialog.dart';
import 'package:confessionapp/src/features/examination/presentation/widgets/examination_mode_selector.dart';
import 'package:confessionapp/src/features/examination/presentation/widgets/focused_examination_view.dart';
import 'package:confessionapp/src/features/examination/presentation/widgets/guided_examination_view.dart';
import 'package:confessionapp/src/features/examination/presentation/widgets/examination_summary_sheet.dart';
import 'package:confessionapp/src/features/settings/presentation/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

class ExaminationScreen extends StatefulWidget {
  const ExaminationScreen({super.key});

  @override
  State<ExaminationScreen> createState() => _ExaminationScreenState();
}

class _ExaminationScreenState extends State<ExaminationScreen> {
  final GlobalKey<_ExaminationContentState> _contentKey = GlobalKey();
  static const int _totalShowcaseSteps = 5;

  void _onShowcaseStepComplete(int index) {
    // Only show dialog after the last showcase step (0-indexed, so last is 4)
    if (index == _totalShowcaseSteps - 1) {
      _contentKey.currentState?.showInvitationDialogIfNeeded();
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return ShowCaseWidget(
      blurValue: 1,
      enableAutoScroll: true,
      onComplete: (index, key) {
        if (index != null) {
          _onShowcaseStepComplete(index);
        }
      },
      builder: (context) => _ExaminationContent(key: _contentKey),
    );
  }
}

class _ExaminationContent extends ConsumerStatefulWidget {
  const _ExaminationContent({super.key});

  @override
  ConsumerState<_ExaminationContent> createState() => _ExaminationContentState();
}

class _ExaminationContentState extends ConsumerState<_ExaminationContent> {
  bool _hasShownRestoreSnackbar = false;
  bool _hasCheckedTutorial = false;
  bool _hasCheckedInvitationDialog = false;
  bool _hasCheckedModeSelection = false;

  // Mode management
  ExaminationMode? _selectedMode;
  bool _showContemplativeEntry = false;

  static const String _invitationDontShowKey = 'invitation_dialog_dont_show';

  // Showcase keys
  final GlobalKey _swipeKey = GlobalKey();
  final GlobalKey _selectKey = GlobalKey();
  final GlobalKey _counterKey = GlobalKey();
  final GlobalKey _menuKey = GlobalKey();
  final GlobalKey _finishKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    // Show snackbar after first frame if draft was restored
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = ref.read(examinationControllerProvider.notifier);
      final l10n = AppLocalizations.of(context)!;
      if (controller.isDraftRestored && !_hasShownRestoreSnackbar) {
        _hasShownRestoreSnackbar = true;
        final count = ref.read(examinationControllerProvider).length;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.draftRestored(count)),
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: l10n.clear,
              onPressed: () async {
                await controller.clearDraft();
              },
            ),
          ),
        );
      }

      _checkAndShowInvitationDialog();
      _checkAndShowModeSelection();
    });
  }

  Future<void> _checkAndShowModeSelection() async {
    if (_hasCheckedModeSelection) return;
    _hasCheckedModeSelection = true;

    // Get saved preference from provider
    final modePreference = await ref.read(examinationModeSettingsProvider.future);

    // Check if there's a draft in progress
    final controller = ref.read(examinationControllerProvider.notifier);
    final hasDraft = controller.isDraftRestored;

    switch (modePreference) {
      case ExaminationModePreference.quickReview:
        setState(() {
          _selectedMode = ExaminationMode.quickReview;
        });
        break;
      case ExaminationModePreference.deepReflection:
        setState(() {
          _selectedMode = ExaminationMode.deepReflection;
          if (!hasDraft) {
            _showContemplativeEntry = true;
          }
        });
        break;
      case ExaminationModePreference.askEveryTime:
        if (!hasDraft && mounted) {
          await Future.delayed(const Duration(milliseconds: 300));
          if (mounted) {
            _showModeSelector();
          }
        } else {
          // Has draft, default to quick review
          setState(() {
            _selectedMode = ExaminationMode.quickReview;
          });
        }
        break;
    }
  }

  void _showModeSelector() {
    ExaminationModeSelector.show(
      context,
      onModeSelected: (mode) {
        setState(() {
          _selectedMode = mode;
          if (mode == ExaminationMode.deepReflection) {
            _showContemplativeEntry = true;
          }
        });
      },
    );
  }

  void _onContemplativeEntryComplete() {
    setState(() {
      _showContemplativeEntry = false;
    });
  }

  Future<void> _checkAndShowInvitationDialog() async {
    if (_hasCheckedInvitationDialog) return;
    _hasCheckedInvitationDialog = true;

    // Check if tutorial will be shown first
    final tutorialController = ref.read(tutorialControllerProvider.notifier);
    final tutorialWillShow = await tutorialController.shouldShowExaminationTutorial();

    // If tutorial will be shown, don't show invitation dialog now
    // It will be shown after tutorial completes via showInvitationDialogIfNeeded()
    if (tutorialWillShow) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final dontShow = prefs.getBool(_invitationDontShowKey) ?? false;

    // Show dialog unless user opted out
    if (!dontShow && mounted) {
      // Small delay to let the screen settle
      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        _showInvitationDialog();
      }
    }
  }

  /// Called from parent when showcase completes
  Future<void> showInvitationDialogIfNeeded() async {
    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    final dontShow = prefs.getBool(_invitationDontShowKey) ?? false;

    // Show dialog unless user opted out
    if (!dontShow && mounted) {
      // Small delay to let the screen settle after showcase
      await Future.delayed(const Duration(milliseconds: 300));

      if (mounted) {
        _showInvitationDialog();
      }
    }
  }

  void _showInvitationDialog() {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    bool dontShowAgain = false;

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: theme.colorScheme.surface,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
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
            l10n.invitationDialogTitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontFamily: AppTheme.fontFamilyEBGaramond,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.invitationDialogContent,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.6,
                  fontFamily: AppTheme.fontFamilyLato,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: dontShowAgain,
                      activeColor: theme.colorScheme.primary,
                      onChanged: (value) {
                        HapticUtils.selectionClick();
                        setDialogState(() {
                          dontShowAgain = value ?? false;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        HapticUtils.selectionClick();
                        setDialogState(() {
                          dontShowAgain = !dontShowAgain;
                        });
                      },
                      child: Text(
                        l10n.invitationDialogDontShowAgain,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontFamily: AppTheme.fontFamilyLato,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actionsPadding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          actions: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FilledButton.icon(
                  onPressed: () async {
                    HapticUtils.lightImpact();
                    if (dontShowAgain) {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool(_invitationDontShowKey, true);
                    }
                    if (dialogContext.mounted) {
                      Navigator.pop(dialogContext);
                      // Navigate to invitation screen
                      context.push('/guide/invitation');
                    }
                  },
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.favorite_outline),
                  label: Text(
                    l10n.invitationDialogYes,
                    style: const TextStyle(
                      fontFamily: AppTheme.fontFamilyLato,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () async {
                    HapticUtils.lightImpact();
                    if (dontShowAgain) {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool(_invitationDontShowKey, true);
                    }
                    if (dialogContext.mounted) {
                      Navigator.pop(dialogContext);
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                  child: Text(
                    l10n.invitationDialogNo,
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamilyLato,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _checkAndShowTutorial() async {
    if (_hasCheckedTutorial) return;
    _hasCheckedTutorial = true;

    final tutorialController = ref.read(tutorialControllerProvider.notifier);
    final shouldShow = await tutorialController.shouldShowExaminationTutorial();
    if (shouldShow && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          // ignore: deprecated_member_use
          ShowCaseWidget.of(context).startShowCase([
            _swipeKey,
            _selectKey,
            _counterKey,
            _menuKey,
            _finishKey,
          ]);
        }
      });
      await tutorialController.markExaminationTutorialShown();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final examinationDataAsync = ref.watch(examinationDataProvider);
    final selectedQuestions = ref.watch(examinationControllerProvider);

    // Check tutorial after the widget is built (only for quick review mode)
    if (_selectedMode == ExaminationMode.quickReview) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkAndShowTutorial();
      });
    }

    // Show contemplative entry for deep reflection mode
    if (_showContemplativeEntry) {
      return ContemplativeEntry(
        onReady: _onContemplativeEntryComplete,
        onSkip: _onContemplativeEntryComplete,
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(l10n.examinationTitle),
          actions: [
            // Mode switcher button
            IconButton(
              icon: Icon(
                _selectedMode == ExaminationMode.deepReflection
                    ? Icons.center_focus_strong_rounded
                    : Icons.list_alt_rounded,
              ),
              tooltip: _selectedMode == ExaminationMode.deepReflection
                  ? l10n.deepReflectionMode
                  : l10n.quickReviewMode,
              onPressed: () {
                HapticUtils.lightImpact();
                _showModeSelector();
              },
            ),
            // Only show counter in AppBar for quick review mode
            // Deep reflection mode shows it in the progress header
            if (_selectedMode != ExaminationMode.deepReflection)
              AppShowcase(
                showcaseKey: _counterKey,
                title: l10n.counter,
                description: l10n.tutorialCounterDesc,
                currentStep: 3,
                totalSteps: 5,
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: selectedQuestions.isNotEmpty
                      ? AnimatedCountBadge(
                          count: selectedQuestions.length,
                          label: l10n.selected(selectedQuestions.length),
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          textColor:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          textStyle:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                                fontWeight: FontWeight.bold,
                              ),
                        ).animate().fadeIn().scale()
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '0 ${l10n.selectedLabel}',
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                ),
              ),
            // Finish button - visible when there are selections
            if (selectedQuestions.isNotEmpty)
              IconButton(
                icon: const Icon(Icons.done_all_rounded),
                tooltip: l10n.finishExamination,
                onPressed: () {
                  HapticUtils.lightImpact();
                  _finishExaminationWithSummary(context, ref);
                },
              ),
            AppShowcase(
              showcaseKey: _menuKey,
              title: l10n.quickActions,
              description: l10n.tutorialMenuDesc,
              currentStep: 4,
              totalSteps: 5,
              child: PopupMenuButton<String>(
              onSelected: (value) async {
                HapticUtils.selectionClick();
                if (value == 'clear') {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: Text(l10n.clearDraftTitle),
                          content: Text(l10n.clearDraftMessage),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text(l10n.cancel),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: Text(l10n.clear),
                            ),
                          ],
                        ),
                  );
                  if (confirmed == true && context.mounted) {
                    HapticUtils.heavyImpact();
                    await ref.read(examinationControllerProvider.notifier).clearDraft();
                  }
                } else if (value == 'custom_sins') {
                  context.push('/examine/custom-sins');
                }
              },
              itemBuilder: (context) {
              final theme = Theme.of(context);
              return [
                PopupMenuItem(
                  value: 'custom_sins',
                  child: Row(
                    children: [
                      Icon(
                        Icons.note_add_outlined,
                        color: theme.colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(l10n.manageCustomSins),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'clear',
                  enabled: selectedQuestions.isNotEmpty,
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete_outline,
                        color: selectedQuestions.isEmpty
                            ? theme.disabledColor
                            : theme.colorScheme.error,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        l10n.clearDraft,
                        style: selectedQuestions.isEmpty
                            ? TextStyle(color: theme.disabledColor)
                            : TextStyle(color: theme.colorScheme.error),
                      ),
                    ],
                  ),
                ),
              ];
            },
            ),
            ),
          ],
        ),
        body: examinationDataAsync.when(
          data: (data) => _selectedMode == ExaminationMode.deepReflection
              ? FocusedExaminationView(
                  data: data,
                  onFinish: () => _finishExamination(context, ref),
                )
              : GuidedExaminationView(
                  data: data,
                  onFinish: () => _finishExamination(context, ref),
                  onAddCustomSin: (commandmentCode) =>
                      _showAddCustomSinDialog(context, commandmentCode),
                  swipeShowcaseKey: _swipeKey,
                  selectShowcaseKey: _selectKey,
                  finishShowcaseKey: _finishKey,
                ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('${l10n.error}: $error')),
        ),
      );
  }

  Future<void> _finishExamination(BuildContext context, WidgetRef ref) async {
    final controller = ref.read(examinationControllerProvider.notifier);
    await controller.saveConfession();
    // Invalidate providers so home screen refreshes
    ref.invalidate(activeConfessionProvider);
    ref.invalidate(activeExaminationDraftProvider);
    if (context.mounted) {
      context.go('/confess');
      // Clear the examination state after navigation
      await controller.clearAfterSave();
    }
  }

  void _finishExaminationWithSummary(BuildContext context, WidgetRef ref) {
    final examinationDataAsync = ref.read(examinationDataProvider);

    examinationDataAsync.whenData((data) {
      final selectedQuestions = ref.read(examinationControllerProvider);
      _showSummarySheet(context, ref, data, selectedQuestions);
    });
  }

  void _showSummarySheet(
    BuildContext context,
    WidgetRef ref,
    List<CommandmentWithQuestions> data,
    Map<String, String> selectedQuestions,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ExaminationSummarySheet(
        data: data,
        selectedQuestions: selectedQuestions,
        onConfirm: () {
          Navigator.pop(context);
          _finishExamination(context, ref);
        },
        onCancel: () => Navigator.pop(context),
      ),
    );
  }

  Future<void> _showAddCustomSinDialog(
    BuildContext context,
    String? commandmentCode,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    final result = await showDialog<UserCustomSinsCompanion>(
      context: context,
      builder: (context) => CustomSinDialog(
        initialCommandmentCode: commandmentCode,
      ),
    );

    if (result != null && mounted) {
      try {
        final repository = ref.read(userCustomSinsRepositoryProvider);

        // Use the commandment code from the dialog result (user's selection)
        await repository.insertCustomSin(result);

        if (mounted) {
          scaffoldMessenger.showSnackBar(
            SnackBar(content: Text(l10n.customSinAdded)),
          );
          // Refresh the examination data
          ref.invalidate(examinationDataProvider);
        }
      } catch (e) {
        if (mounted) {
          scaffoldMessenger.showSnackBar(
            SnackBar(content: Text('${l10n.error}: $e')),
          );
        }
      }
    }
  }
}
