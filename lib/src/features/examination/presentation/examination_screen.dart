import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/preferences/preferences_provider.dart';
import 'package:confessionapp/src/core/theme/app_showcase.dart';
import 'package:confessionapp/src/core/tutorial/tutorial_controller.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/core/widgets/gentle_prompt_card.dart';
import 'package:confessionapp/src/features/examination/data/examination_repository.dart';
import 'package:confessionapp/src/features/examination/data/user_custom_sins_repository.dart';
import 'package:confessionapp/src/features/examination/presentation/examination_controller.dart';
import 'package:confessionapp/src/features/examination/presentation/widgets/contemplative_entry.dart';
import 'package:confessionapp/src/features/examination/presentation/widgets/custom_sin_dialog.dart';
import 'package:confessionapp/src/features/examination/presentation/widgets/examination_mode_selector.dart';
import 'package:confessionapp/src/features/examination/presentation/widgets/focused_examination_view.dart';
import 'package:confessionapp/src/features/examination/presentation/widgets/guided_examination_view.dart';
import 'package:confessionapp/src/features/examination/presentation/widgets/journal_preload_banner.dart';
import 'package:confessionapp/src/features/examination/presentation/widgets/examination_summary_sheet.dart';
import 'package:confessionapp/src/features/settings/presentation/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:showcaseview/showcaseview.dart';

class ExaminationScreen extends StatefulWidget {
  const ExaminationScreen({super.key});

  @override
  State<ExaminationScreen> createState() => _ExaminationScreenState();
}

class _ExaminationScreenState extends State<ExaminationScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return ShowCaseWidget(
      blurValue: 1,
      enableAutoScroll: true,
      builder: (context) => const _ExaminationContent(),
    );
  }
}

class _ExaminationContent extends ConsumerStatefulWidget {
  const _ExaminationContent();

  @override
  ConsumerState<_ExaminationContent> createState() => _ExaminationContentState();
}

class _ExaminationContentState extends ConsumerState<_ExaminationContent> {
  bool _hasShownRestoreSnackbar = false;
  bool _hasCheckedTutorial = false;
  bool _hasCheckedModeSelection = false;

  // Mode management
  ExaminationMode _mode = ExaminationMode.quickReview;
  bool _showContemplativeEntry = false;

  /// Whether the dismissible encouragement card is shown. Honours the
  /// existing "don't show this again" preference key.
  bool _showInvitationPrompt = false;

  static const String _invitationDontShowKey = 'invitation_dialog_dont_show';

  // Showcase keys
  final GlobalKey _swipeKey = GlobalKey();
  final GlobalKey _selectKey = GlobalKey();
  final GlobalKey _menuKey = GlobalKey();
  final GlobalKey _finishKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // SharedPreferences is already loaded, so this is known on the first frame.
    final prefs = ref.read(sharedPreferencesProvider);
    _showInvitationPrompt = !(prefs.getBool(_invitationDontShowKey) ?? false);
    _initialize();
  }

  /// Waits for the persisted draft to be restored before deciding whether to
  /// show the "draft restored" snackbar and which examination mode to start in.
  /// Reading `isDraftRestored` any earlier races the async restore.
  Future<void> _initialize() async {
    final controller = ref.read(examinationControllerProvider.notifier);
    await controller.draftRestored;
    if (!mounted) return;

    _showDraftRestoredSnackbar(controller);
    _applySavedMode();
  }

  void _showDraftRestoredSnackbar(ExaminationController controller) {
    if (!controller.isDraftRestored || _hasShownRestoreSnackbar) return;
    _hasShownRestoreSnackbar = true;

    final l10n = AppLocalizations.of(context)!;
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

  /// Applies the mode saved in settings. "Ask every time" opens on the quick
  /// review with the inline mode toggle.
  Future<void> _applySavedMode() async {
    if (_hasCheckedModeSelection) return;
    _hasCheckedModeSelection = true;

    final modePreference = await ref.read(examinationModeSettingsProvider.future);
    if (!mounted) return;

    // Check if there's a draft in progress (the restore has already completed)
    final controller = ref.read(examinationControllerProvider.notifier);
    final hasDraft = controller.isDraftRestored;

    switch (modePreference) {
      case ExaminationModePreference.quickReview:
      case ExaminationModePreference.askEveryTime:
        _applyMode(ExaminationMode.quickReview);
        break;
      case ExaminationModePreference.deepReflection:
        _applyMode(
          ExaminationMode.deepReflection,
          showContemplativeEntry: !hasDraft,
        );
        break;
    }
  }

  void _applyMode(
    ExaminationMode mode, {
    bool showContemplativeEntry = false,
  }) {
    setState(() {
      _mode = mode;
      if (showContemplativeEntry) {
        _showContemplativeEntry = true;
      }
    });

    // Tutorial only applies to the quick review (guided) view, whose showcase
    // keys exist once that view is on screen.
    if (mode == ExaminationMode.quickReview) {
      _checkAndShowTutorial();
    }
  }

  /// The inline toggle. Session-only: it does not overwrite the default mode
  /// saved in Settings.
  void _onModeToggled(ExaminationMode mode) {
    if (mode == _mode) return;
    _applyMode(mode);
  }

  void _onContemplativeEntryComplete() {
    setState(() {
      _showContemplativeEntry = false;
    });
  }

  Future<void> _dismissInvitationPrompt() async {
    setState(() => _showInvitationPrompt = false);
    await ref
        .read(sharedPreferencesProvider)
        .setBool(_invitationDontShowKey, true);
  }

  Future<void> _acceptInvitationPrompt() async {
    await _dismissInvitationPrompt();
    if (mounted) {
      context.push('/guide/invitation');
    }
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
              currentStep: 3,
              totalSteps: 4,
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
          data: (data) => Column(
            children: [
              // Renders nothing unless the journal holds sins that have not yet
              // been carried into a confession.
              const JournalPreloadBanner(),
              if (_showInvitationPrompt)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                  child: GentlePromptCard(
                    icon: Icons.favorite_outline,
                    title: l10n.invitationCardTitle,
                    body: l10n.invitationDialogContent,
                    prepareLabel: l10n.invitationCardAction,
                    onPrepare: _acceptInvitationPrompt,
                    onDismiss: _dismissInvitationPrompt,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                child: ExaminationModeToggle(
                  mode: _mode,
                  onChanged: _onModeToggled,
                ),
              ),
              Expanded(
                child: _mode == ExaminationMode.deepReflection
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
              ),
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('${l10n.error}: $error')),
        ),
      );
  }

  Future<void> _finishExamination(BuildContext context, WidgetRef ref) async {
    final controller = ref.read(examinationControllerProvider.notifier);
    await controller.saveConfession();
    // Clear before navigating: afterwards the calling context (e.g. the
    // summary sheet) may already be gone.
    await controller.clearAfterSave();
    // The confess and home screens read the confession from Drift streams.
    if (context.mounted) {
      context.go('/confess');
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
      builder: (sheetContext) => ExaminationSummarySheet(
        data: data,
        selectedQuestions: selectedQuestions,
        onConfirm: () {
          Navigator.pop(sheetContext);
          // Use the screen's context, not the (now unmounted) sheet's context,
          // otherwise navigation to /confess is silently skipped.
          _finishExamination(context, ref);
        },
        onCancel: () => Navigator.pop(sheetContext),
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

        // Use the commandment code from the dialog result (user's selection),
        // stored language-neutral so it survives a content-language switch.
        await repository.insertCustomSin(withNeutralCommandmentCode(result));

        if (mounted) {
          scaffoldMessenger.showSnackBar(
            SnackBar(content: Text(l10n.customSinAdded)),
          );
          // The examination data follows the custom-sins stream.
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
