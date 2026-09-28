import 'dart:async';

import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/theme/app_radius.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/core/widgets/empty_state.dart';
import 'package:confessionapp/src/features/confession/data/confession_analytics_repository.dart';
import 'package:confessionapp/src/features/confession/data/confession_repository.dart';
import 'package:confessionapp/src/features/confession/data/penance_repository.dart';
import 'package:confessionapp/src/features/confession/presentation/widgets/confession_day_text.dart';
import 'package:confessionapp/src/features/guide/presentation/prayers_screen.dart'
    show PrayerItem, prayersContentProvider;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

/// The id of the Act of Contrition in `assets/data/prayers/prayers_{lang}.json`.
/// Present in every bundled language.
const String _actOfContritionId = 'act_of_contrition';

/// The Act of Contrition in the user's content language (not the UI language).
///
/// Reuses the prayers screen's loading path (`prayersContentProvider`), which
/// already goes through `loadLocalizedJsonObject` and therefore falls back to
/// English for a language whose prayers file is missing.
final actOfContritionProvider = FutureProvider.autoDispose<PrayerItem?>((
  ref,
) async {
  final content = await ref.watch(prayersContentProvider.future);
  for (final category in content.categories) {
    for (final prayer in category.prayers) {
      if (prayer.id == _actOfContritionId) return prayer;
    }
  }
  return null;
});

/// A distraction-free mode for the moments right before and inside the
/// confessional: the Act of Contrition, the sins of the active confession, and
/// a field to capture the penance the priest assigns — one step at a time, in
/// extra-large serif text, with the screen kept awake.
///
/// Pushed on the root navigator (no bottom navigation bar) and listed in the
/// router's `sensitiveRoutes`, because it displays the user's sins.
class ConfessionDayModeScreen extends ConsumerStatefulWidget {
  const ConfessionDayModeScreen({super.key});

  @override
  ConsumerState<ConfessionDayModeScreen> createState() =>
      _ConfessionDayModeScreenState();
}

class _ConfessionDayModeScreenState
    extends ConsumerState<ConfessionDayModeScreen> {
  static const int _stepCount = 5;

  final PageController _pageController = PageController();

  /// Reaches the penance field from the step controls below the `PageView`, so
  /// that leaving the mode can flush it.
  final GlobalKey<_PenanceStepState> _penanceStepKey =
      GlobalKey<_PenanceStepState>();

  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    unawaited(_setWakelock(true));
  }

  @override
  void dispose() {
    // Restore normal sleep behaviour: the wakelock is process-wide, so leaving
    // it on here would keep the phone awake for the rest of the session.
    unawaited(_setWakelock(false));
    _pageController.dispose();
    super.dispose();
  }

  /// Keeps the screen awake while this mode is open.
  ///
  /// Failures are swallowed: an unsupported platform (or a widget
  /// test, where the plugin channel is not registered) should degrade to "the
  /// screen may dim", never to a crash mid-confession.
  Future<void> _setWakelock(bool enable) async {
    try {
      await WakelockPlus.toggle(enable: enable);
    } catch (_) {
      // No wakelock available: normal sleep behaviour applies.
    }
  }

  void _goToStep(int step) {
    if (step < 0 || step >= _stepCount) return;
    HapticUtils.lightImpact();
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  /// Leaves the mode, keeping the penance.
  ///
  /// Both exits (Done and the close button) flush the penance field first,
  /// since "Done" is the likely tap after typing it. A failed write keeps the
  /// user here rather than dropping their text.
  Future<void> _leave() async {
    HapticUtils.lightImpact();

    final saved =
        await _penanceStepKey.currentState?.saveBeforeLeaving() ?? true;
    if (!saved || !mounted) return;

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    // The steps follow the order of the rite itself: the opening formula, the
    // confession of sins, the Act of Contrition (prayed after confessing),
    // the penance the priest assigns, and the thanksgiving at dismissal.
    final titles = [
      l10n.confessionDayOpeningTitle,
      l10n.confessionDaySinsTitle,
      l10n.actOfContrition,
      l10n.penance,
      l10n.confessionDayThanksgivingTitle,
    ];

    return Scaffold(
      // A calm, high-contrast surface: plain `surface`/`onSurface` reads well in
      // a dim confessional in dark mode and in daylight in light mode, with no
      // hard-coded colour anywhere.
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            _Header(
              title: titles[_currentStep],
              step: _currentStep,
              stepCount: _stepCount,
              onClose: _leave,
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentStep = index),
                children: [
                  const _OpeningStep(),
                  const _SinsStep(),
                  const _ActOfContritionStep(),
                  _PenanceStep(key: _penanceStepKey),
                  const _ThanksgivingStep(),
                ],
              ),
            ),
            _StepControls(
              step: _currentStep,
              stepCount: _stepCount,
              onBack: () => _goToStep(_currentStep - 1),
              onNext: () => _goToStep(_currentStep + 1),
              onDone: _leave,
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.title,
    required this.step,
    required this.stepCount,
    required this.onClose,
  });

  final String title;
  final int step;
  final int stepCount;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            tooltip: l10n.exitConfessionMode,
            onPressed: onClose,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  l10n.confessionDayStepOf(step + 1, stepCount),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var i = 0; i < stepCount; i++)
                Container(
                  width: i == step ? 20 : 8,
                  height: 8,
                  margin: const EdgeInsets.only(left: 4),
                  decoration: BoxDecoration(
                    color:
                        i == step
                            ? theme.colorScheme.primary
                            : theme.colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StepControls extends StatelessWidget {
  const _StepControls({
    required this.step,
    required this.stepCount,
    required this.onBack,
    required this.onNext,
    required this.onDone,
  });

  final int step;
  final int stepCount;
  final VoidCallback onBack;
  final VoidCallback onNext;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isLast = step == stepCount - 1;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: Row(
        children: [
          if (step > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: onBack,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(l10n.back),
              ),
            ),
          if (step > 0) const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: FilledButton(
              onPressed: isLast ? onDone : onNext,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.tile),
                ),
              ),
              child: Text(isLast ? l10n.done : l10n.next),
            ),
          ),
        ],
      ),
    );
  }
}

/// Step 1 — the opening formula. The Sign-of-the-Cross prompt, then
/// "Bless me, Father, for I have sinned. It has been [time] since my last
/// confession", with the interval filled in from the previous confession so
/// the penitent has the words ready.
///
/// With nothing on record the interval stays a fill-in-the-blank template
/// ("[days/weeks/months/years]"): a reinstall loses the history but not the
/// confession. With a record, the exact date follows in small text, since the
/// spoken line rounds it to a coarse phrase.
class _OpeningStep extends ConsumerWidget {
  const _OpeningStep();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final analytics = ref.watch(confessionAnalyticsProvider).valueOrNull;

    // Analytics counts only finished confessions, so this interval is the gap
    // since the previous one — never the confession being made right now.
    final hasPrevious =
        analytics != null &&
        analytics.hasData &&
        analytics.lastConfessionDate != null &&
        analytics.daysSinceLastConfession >= 1;
    final sinceLast =
        hasPrevious
            ? l10n.confessionDaySinceLast(
              _humanDuration(l10n, analytics.daysSinceLastConfession),
            )
            : l10n.confessionDaySinceLastUnknown;

    final lastConfessionDate = hasPrevious ? analytics.lastConfessionDate : null;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.confessionDayOpeningIntro,
            style: confessionDaySerif(
              context,
              scale: 1.2,
              height: 1.6,
              fontStyle: FontStyle.italic,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          // This line is not "Bless me, Father…" in every language. German and
          // Polish open with the greeting ("Gelobt sei Jesus Christus" / "Niech
          // będzie pochwalony Jezus Chrystus"), and the Korean 고해성사 has no
          // opening line at all — the penitent goes straight to how long it has
          // been. When the localized formula is empty, omit it (and its
          // spacing) rather than leaving a blank line.
          if (l10n.confessionDayOpeningFormula.isNotEmpty) ...[
            Text(
              l10n.confessionDayOpeningFormula,
              style: confessionDaySerif(context, scale: 1.6, height: 1.7),
            ),
            const SizedBox(height: 16),
          ],
          Text(
            sinceLast,
            style: confessionDaySerif(context, scale: 1.6, height: 1.7),
          ),
          // A prompt, not part of what is said aloud: the line above rounds to
          // "3 weeks", so this carries the exact date it hides.
          if (lastConfessionDate != null) ...[
            const SizedBox(height: 12),
            Text(
              '${l10n.lastConfession}: '
              '${DateFormat.yMMMMd(Localizations.localeOf(context).toString()).format(lastConfessionDate)}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Rounds an interval to the coarse phrase a penitent actually says aloud
/// ("3 weeks", "2 months") rather than an exact day count.
String _humanDuration(AppLocalizations l10n, int days) {
  if (days < 14) return l10n.daysCount(days);
  if (days < 60) return l10n.weeksCount((days / 7).round());
  if (days < 365) return l10n.monthsCount((days / 30).round());
  return l10n.yearsCount((days / 365).round());
}

/// Step 3 — the Act of Contrition, read-only, in large serif. Prayed after the
/// sins are confessed, as in the rite.
class _ActOfContritionStep extends ConsumerWidget {
  const _ActOfContritionStep();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final prayerAsync = ref.watch(actOfContritionProvider);

    return prayerAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error:
          (_, __) => EmptyState(
            icon: Icons.error_outline,
            title: l10n.actOfContritionUnavailable,
          ),
      data: (prayer) {
        final content = prayer?.content;
        if (content == null || content.trim().isEmpty) {
          return EmptyState(
            icon: Icons.auto_stories_outlined,
            title: l10n.actOfContritionUnavailable,
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Text(
            stripPrayerMarkup(content),
            style: confessionDaySerif(context, scale: 1.6, height: 1.7),
          ),
        );
      },
    );
  }
}

/// Step 2 — the sins of the active confession, read-only, one per line with
/// generous spacing so a single one can be found at a glance.
class _SinsStep extends ConsumerWidget {
  const _SinsStep();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final confessionAsync = ref.watch(activeConfessionProvider);

    return confessionAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error:
          (_, __) =>
              EmptyState(icon: Icons.error_outline, title: l10n.noSinsSelected),
      data: (data) {
        final items = data?.items ?? const [];
        if (items.isEmpty) {
          return EmptyState(
            icon: Icons.checklist_outlined,
            title: l10n.noSinsSelected,
            subtitle: l10n.startExaminationPrompt,
          );
        }

        return ListView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          children: [
            for (var index = 0; index < items.length; index++) ...[
              if (index > 0)
                Divider(
                  height: 32,
                  color:
                      theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
                ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  SizedBox(
                    width: 40,
                    child: Text(
                      '${index + 1}.',
                      style: confessionDaySerif(
                        context,
                        scale: 1.4,
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      items[index].content,
                      style:
                          confessionDaySerif(context, scale: 1.5, height: 1.7),
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 36),
            // The line the penitent says once the sins are told.
            Text(
              l10n.confessionDaySinsClosing,
              style: confessionDaySerif(
                context,
                scale: 1.4,
                height: 1.6,
                fontStyle: FontStyle.italic,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Step 4 — capture the penance the priest assigns, saved to the `Penances`
/// table of the active confession.
class _PenanceStep extends ConsumerStatefulWidget {
  const _PenanceStep({super.key});

  @override
  ConsumerState<_PenanceStep> createState() => _PenanceStepState();
}

class _PenanceStepState extends ConsumerState<_PenanceStep>
    with AutomaticKeepAliveClientMixin {
  // Not the last step, so keep this page alive: the typed text must survive
  // leaving the viewport, or "Done" on a later step would find a disposed
  // state and drop an unsaved penance.
  @override
  bool get wantKeepAlive => true;

  final TextEditingController _controller = TextEditingController();

  /// The text last written to the database (or seeded from it).
  ///
  /// What makes "Done" safe: the button saves only when the field differs from
  /// this, so leaving the mode without having touched the penance costs nothing,
  /// and leaving it with a penance typed but not explicitly saved still keeps it.
  String _savedText = '';

  /// Whether the user has started editing. Once they have, a late emission of
  /// the Drift stream must not seed over what they are typing.
  bool _dirty = false;
  bool _isSaving = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// True when there is text worth keeping that is not yet in the database.
  bool get hasUnsavedPenance {
    final text = _controller.text.trim();
    return text.isNotEmpty && text != _savedText;
  }

  /// Persists anything unsaved before the mode is left.
  ///
  /// Returns false only if the write failed, in which case the caller must not
  /// pop, or the penance would be lost.
  Future<bool> saveBeforeLeaving() async {
    if (!hasUnsavedPenance) return true;

    final confession =
        ref.read(activeConfessionProvider).valueOrNull?.confession;
    if (confession == null) return true;

    return _save(confession.id, silent: true);
  }

  /// Writes the penance, if there is anything to write.
  ///
  /// Returns false only when the write actually failed, so a caller that is
  /// about to leave the screen (the "Done" button) can stay put instead.
  ///
  /// `addPenance` is an upsert: a confession has exactly one penance, and
  /// re-entering this mode to correct it updates the row rather than adding a
  /// second one. No local id needs to be tracked for that.
  Future<bool> _save(int confessionId, {bool silent = false}) async {
    final text = _controller.text.trim();
    if (text.isEmpty || text == _savedText) return true;
    if (_isSaving) return true;

    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);
    final wasStored = _savedText.isNotEmpty;

    setState(() => _isSaving = true);
    HapticUtils.mediumImpact();

    try {
      await ref.read(penanceRepositoryProvider).addPenance(confessionId, text);
    } catch (_) {
      // A failed write must not be silent, or the penance looks saved when it
      // is not.
      if (!mounted) return false;
      setState(() => _isSaving = false);
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.penanceSaveFailed),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return false;
    }

    if (!mounted) return true;
    setState(() {
      _savedText = text;
      _isSaving = false;
    });

    if (!silent) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(wasStored ? l10n.penanceUpdated : l10n.penanceAdded),
        ),
      );
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // AutomaticKeepAliveClientMixin
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final confessionAsync = ref.watch(activeConfessionProvider);

    final confession = confessionAsync.valueOrNull?.confession;
    if (confession == null) {
      return confessionAsync.isLoading
          ? const Center(child: CircularProgressIndicator())
          : EmptyState(
            icon: Icons.church_outlined,
            title: l10n.noActiveConfession,
          );
    }

    // Seed the field from the stored penance, but never over the user's own
    // typing: the stream's emissions (the first often null) can land after they
    // have begun.
    final storedPenance =
        ref.watch(penanceForConfessionProvider(confession.id)).valueOrNull;
    if (!_dirty && storedPenance != null && _savedText.isEmpty) {
      _savedText = storedPenance.description;
      _controller.text = storedPenance.description;
    }

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        24,
        8,
        24,
        24 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.penanceDescription,
            style: confessionDaySerif(
              context,
              scale: 1.4,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _controller,
            minLines: 3,
            maxLines: 6,
            textCapitalization: TextCapitalization.sentences,
            style: confessionDaySerif(context, scale: 1.5),
            onChanged: (_) => setState(() => _dirty = true),
            decoration: InputDecoration(
              hintText: l10n.penanceHint,
              hintStyle: confessionDaySerif(
                context,
                scale: 1.5,
                color: theme.colorScheme.onSurfaceVariant.withValues(
                  alpha: 0.7,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.tile),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
          const SizedBox(height: 20),
          FilledButton.icon(
            onPressed:
                _isSaving || _controller.text.trim().isEmpty
                    ? null
                    : () => _save(confession.id),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.tile),
              ),
            ),
            icon: const Icon(Icons.check),
            label: Text(l10n.savePenance),
          ),
        ],
      ),
    );
  }
}

/// Step 5 — the thanksgiving at dismissal, after absolution: the priest's
/// versicle and the penitent's response, then a gentle word to carry out.
class _ThanksgivingStep extends StatelessWidget {
  const _ThanksgivingStep();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.confessionDayThanksgivingVersicle,
            style: confessionDaySerif(context, scale: 1.6, height: 1.7),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.confessionDayThanksgivingResponse,
            style: confessionDaySerif(
              context,
              scale: 1.6,
              height: 1.7,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 32),
          Text(
            l10n.confessionDayThanksgivingBody,
            style: confessionDaySerif(
              context,
              scale: 1.3,
              height: 1.7,
              fontStyle: FontStyle.italic,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
