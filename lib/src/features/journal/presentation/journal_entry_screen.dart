import 'package:confessionapp/src/core/database/app_database.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/theme/app_radius.dart';
import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:confessionapp/src/core/utils/date_utils.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/core/widgets/app_back_button.dart';
import 'package:confessionapp/src/features/confession/presentation/confession_day_mode_screen.dart'
    show actOfContritionProvider;
import 'package:confessionapp/src/features/confession/presentation/widgets/confession_day_text.dart'
    show stripPrayerMarkup;
import 'package:confessionapp/src/features/journal/data/journal_repository.dart';
import 'package:confessionapp/src/features/journal/domain/models/journal_models.dart';
import 'package:confessionapp/src/features/journal/presentation/journal_entry_controller.dart';
import 'package:confessionapp/src/features/journal/presentation/widgets/sin_quick_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// The daily Examen, prayed as five movements:
///
///   1. Presence & Gratitude — come into God's presence and thank Him
///   2. Ask for Light — a prayer to the Holy Spirit to see the day truly
///   3. Review with God — walk back through the day with the Lord; optionally
///      write, and bring sins to Him (they carry into a later confession)
///   4. Contrition — sorrow born of love, and the Act of Contrition
///   5. Hope & Resolution — rest in mercy, and a gift for tomorrow
///
/// Writing and sin-marking are optional aids to prayer. Every field autosaves
/// (debounced in [JournalEntryController]), so leaving at any point loses
/// nothing.
class JournalEntryScreen extends ConsumerStatefulWidget {
  const JournalEntryScreen({super.key, required this.day});

  final DateTime day;

  @override
  ConsumerState<JournalEntryScreen> createState() => _JournalEntryScreenState();
}

class _JournalEntryScreenState extends ConsumerState<JournalEntryScreen>
    with WidgetsBindingObserver {
  static const _pageCount = 5;

  final PageController _pageController = PageController();
  final TextEditingController _gratitudeController = TextEditingController();
  final TextEditingController _reflectionController = TextEditingController();
  final TextEditingController _resolutionController = TextEditingController();

  int _currentPage = 0;
  bool _isLoading = true;

  DateTime get _day => startOfDay(widget.day);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _seedFromExistingEntry();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Backgrounding the app can be followed by the OS killing it without the
    // screen ever disposing, so flush any debounced text the moment we leave
    // the foreground rather than waiting for the debounce timer.
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
      ref.read(journalEntryControllerProvider(_day).notifier).flushPending();
    }
  }

  /// Fills the fields from the stored entry exactly once.
  ///
  /// Not a `watch`: re-seeding the controllers on every emission would fight
  /// the cursor while autosave writes the field being typed into.
  Future<void> _seedFromExistingEntry() async {
    final day = await ref.read(journalDayProvider(_day).future);
    if (!mounted) return;

    if (day != null) {
      _gratitudeController.text = day.entry.gratitude ?? '';
      _reflectionController.text = day.entry.reflection ?? '';
      _resolutionController.text = day.entry.resolution ?? '';
    }
    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pageController.dispose();
    _gratitudeController.dispose();
    _reflectionController.dispose();
    _resolutionController.dispose();
    super.dispose();
  }

  JournalEntryController get _controller =>
      ref.read(journalEntryControllerProvider(_day).notifier);

  void _goToPage(int page) {
    if (page < 0 || page >= _pageCount) return;
    HapticUtils.lightImpact();
    // Drop the keyboard when moving on: the light and contrition movements have
    // no text field, and a keyboard left open there covers the prayer.
    FocusScope.of(context).unfocus();
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _confirmDelete() async {
    final l10n = AppLocalizations.of(context)!;
    HapticUtils.lightImpact();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.journalDeleteEntry),
        content: Text(l10n.journalDeleteEntryConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.deleteButton),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await _controller.deleteDay();
    if (!mounted) return;

    _gratitudeController.clear();
    _reflectionController.clear();
    _resolutionController.clear();

    final messenger = ScaffoldMessenger.of(context);
    messenger.showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.journalEntryDeleted)),
    );
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final dayAsync = ref.watch(journalDayProvider(_day));
    final journalDay = dayAsync.valueOrNull;
    final status = ref.watch(journalEntryControllerProvider(_day));

    final localeName = Localizations.localeOf(context).toLanguageTag();
    final isToday = _day == startOfDay(DateTime.now());
    final title = isToday
        ? l10n.today
        : DateFormat.yMMMMd(localeName).format(_day);

    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(fallbackLocation: '/journal'),
        title: Text(title),
        actions: [
          if (journalDay != null)
            IconButton(
              onPressed: _confirmDelete,
              icon: const Icon(Icons.delete_outline),
              tooltip: l10n.journalDeleteEntry,
            ),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  _Progress(
                    currentPage: _currentPage,
                    pageCount: _pageCount,
                    status: status,
                  ),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (page) {
                        // Also unfocus on a swipe-driven change, not just the
                        // Next/Back buttons, so the keyboard never lingers over
                        // a wordless movement.
                        FocusScope.of(context).unfocus();
                        setState(() => _currentPage = page);
                      },
                      children: [
                        // 1 — Presence & Gratitude
                        _MovementPage(
                          icon: Icons.wb_twilight_outlined,
                          title: l10n.journalGratitudeTitle,
                          lead: l10n.journalPresenceLead,
                          verse: l10n.journalPresenceVerse,
                          reference: l10n.journalPresenceRef,
                          child: _WritingArea(
                            controller: _gratitudeController,
                            prompt: l10n.journalGratitudePrompt,
                            hint: l10n.journalGratitudeHint,
                            maxLines: 4,
                            onChanged: _controller.setGratitude,
                          ),
                        ),
                        // 2 — Ask for Light (a prayer to rest in; no writing)
                        _MovementPage(
                          icon: Icons.auto_awesome_outlined,
                          title: l10n.journalLightTitle,
                          lead: l10n.journalLightLead,
                          verse: l10n.journalLightVerse,
                        ),
                        // 3 — Review with God (optional writing, optional sins)
                        _MovementPage(
                          icon: Icons.auto_stories_outlined,
                          title: l10n.journalReviewTitle,
                          lead: l10n.journalReviewLead,
                          verse: l10n.journalReviewVerse,
                          reference: l10n.journalReviewRef,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // The fruit of the review, kept within reach:
                              // what to bring to God, right under the Scripture
                              // rather than buried below the writing field.
                              Text(
                                l10n.journalReviewBringSin,
                                style: theme.textTheme.titleSmall?.copyWith(
                                  color: scheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 12),
                              _MarkedSinsList(
                                day: _day,
                                marks: journalDay?.marks ?? const [],
                              ),
                              const SizedBox(height: 28),
                              // Optional: a few words to God about the day.
                              _WritingArea(
                                controller: _reflectionController,
                                hint: l10n.journalReviewHint,
                                minLines: 3,
                                maxLines: 6,
                                serif: true,
                                onChanged: _controller.setReflection,
                              ),
                            ],
                          ),
                        ),
                        // 4 — Contrition (sorrow, and the Act of Contrition)
                        _ContritionPage(
                          title: l10n.journalContritionTitle,
                          lead: l10n.journalContritionLead,
                          verse: l10n.journalContritionVerse,
                          reference: l10n.journalContritionRef,
                        ),
                        // 5 — Hope & Resolution
                        _MovementPage(
                          icon: Icons.wb_sunny_outlined,
                          title: l10n.journalResolutionTitle,
                          lead: l10n.journalResolutionLead,
                          verse: l10n.journalResolutionVerse,
                          reference: l10n.journalResolutionRef,
                          child: _WritingArea(
                            controller: _resolutionController,
                            prompt: l10n.journalResolutionPrompt,
                            hint: l10n.journalResolutionHint,
                            maxLines: 3,
                            onChanged: _controller.setResolution,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                    child: Row(
                      children: [
                        if (_currentPage > 0)
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => _goToPage(_currentPage - 1),
                              child: Text(l10n.back),
                            ),
                          ),
                        if (_currentPage > 0) const SizedBox(width: 12),
                        Expanded(
                          child: FilledButton(
                            onPressed: () {
                              if (_currentPage == _pageCount - 1) {
                                HapticUtils.mediumImpact();
                                Navigator.of(context).maybePop();
                              } else {
                                _goToPage(_currentPage + 1);
                              }
                            },
                            child: Text(
                              _currentPage == _pageCount - 1
                                  ? l10n.done
                                  : l10n.nextButton,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
      backgroundColor: scheme.surface,
    );
  }
}

class _Progress extends StatelessWidget {
  const _Progress({
    required this.currentPage,
    required this.pageCount,
    required this.status,
  });

  final int currentPage;
  final int pageCount;
  final JournalSaveStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
      child: Column(
        children: [
          Row(
            children: [
              for (var i = 0; i < pageCount; i++) ...[
                Expanded(
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: i <= currentPage
                          ? scheme.primary
                          : scheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(AppRadius.bar),
                    ),
                  ),
                ),
                if (i < pageCount - 1) const SizedBox(width: 4),
              ],
            ],
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 20,
            child: status == JournalSaveStatus.idle
                ? null
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        // A check, not a cloud: nothing leaves the device.
                        status == JournalSaveStatus.saved
                            ? Icons.check_circle_outline
                            : Icons.edit_outlined,
                        size: 14,
                        color: scheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        status == JournalSaveStatus.saved
                            ? l10n.journalSaved
                            : l10n.journalSaving,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

/// The devotional core of a movement: a plain one-line instruction, then the
/// Scripture (or traditional prayer) set large in EBGaramond, then its citation.
///
/// [verse] is always Scripture or a traditional prayer, never app-written
/// prose.
class _MovementBody extends StatelessWidget {
  const _MovementBody({
    required this.lead,
    required this.verse,
    this.reference,
  });

  final String lead;
  final String verse;

  /// The Scripture citation. Null for a traditional prayer (e.g. Come Holy
  /// Spirit), which needs no reference.
  final String? reference;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          lead,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: scheme.onSurfaceVariant,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          verse,
          style: theme.textTheme.titleLarge?.copyWith(
            fontFamily: AppTheme.fontFamilyEBGaramond,
            // Scripture, read gently — not the bold weight titleLarge carries.
            fontWeight: FontWeight.w400,
            height: 1.55,
            color: scheme.onSurface,
          ),
        ),
        if (reference != null && reference!.isNotEmpty) ...[
          const SizedBox(height: 10),
          Text(
            reference!,
            style: theme.textTheme.labelMedium?.copyWith(
              fontStyle: FontStyle.italic,
              color: scheme.primary,
            ),
          ),
        ],
      ],
    );
  }
}

/// One movement of the Examen: a small header, its Scripture/prayer, and an
/// optional aid below it (writing, or the marked sins).
class _MovementPage extends StatelessWidget {
  const _MovementPage({
    required this.icon,
    required this.title,
    required this.lead,
    required this.verse,
    this.reference,
    this.child,
  });

  final IconData icon;
  final String title;
  final String lead;
  final String verse;
  final String? reference;

  /// An optional aid to the prayer (a writing field, the marked sins). Null for
  /// the movements that are simply prayed and rested in.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          child: ConstrainedBox(
            // Fill the viewport so a short prayer sits centred and settled,
            // rather than clinging to the top over a screen of dead space —
            // and simply scrolls when it (or a large text scale) runs long.
            constraints: BoxConstraints(minHeight: constraints.maxHeight - 56),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _MovementHeader(icon: icon, title: title),
                const SizedBox(height: 20),
                _MovementBody(lead: lead, verse: verse, reference: reference),
                if (child != null) ...[const SizedBox(height: 28), child!],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MovementHeader extends StatelessWidget {
  const _MovementHeader({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: scheme.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: scheme.onPrimaryContainer),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: scheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}

/// The contrition movement: the invitation, the Act of Contrition (in the
/// user's content language), and one careful line on mercy.
///
/// The mercy line must point on to Confession and must never declare the soul
/// to be in a state of grace.
class _ContritionPage extends ConsumerWidget {
  const _ContritionPage({
    required this.title,
    required this.lead,
    required this.verse,
    required this.reference,
  });

  final String title;
  final String lead;
  final String verse;
  final String reference;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final prayerAsync = ref.watch(actOfContritionProvider);
    final prayer = prayerAsync.valueOrNull?.content;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight - 56),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _MovementHeader(icon: Icons.favorite_outline, title: title),
          const SizedBox(height: 20),
          _MovementBody(lead: lead, verse: verse, reference: reference),
          if (prayer != null && prayer.trim().isNotEmpty) ...[
            const SizedBox(height: 28),
            Text(
              l10n.journalContritionPray,
              style: theme.textTheme.titleSmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: scheme.primaryContainer.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(AppRadius.card),
                border: Border.all(color: scheme.outlineVariant),
              ),
              child: Text(
                stripPrayerMarkup(prayer),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontFamily: AppTheme.fontFamilyEBGaramond,
                  fontWeight: FontWeight.w400,
                  height: 1.6,
                  color: scheme.onSurface,
                ),
              ),
            ),
          ],
          const SizedBox(height: 24),
          // The mercy line, set apart and gentle.
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.church_outlined,
                size: 18,
                color: scheme.primary,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l10n.journalContritionMercy,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontFamily: AppTheme.fontFamilyEBGaramond,
                    fontStyle: FontStyle.italic,
                    height: 1.5,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// An optional writing aid: a gentle prompt above a soft, multiline field.
class _WritingArea extends StatelessWidget {
  const _WritingArea({
    required this.controller,
    required this.hint,
    required this.maxLines,
    required this.onChanged,
    this.prompt,
    this.minLines,
    this.serif = false,
  });

  final TextEditingController controller;
  final String? prompt;
  final String hint;
  final int maxLines;

  /// How tall the field is before any text is typed. Defaults to a single line
  /// for short prompts, and a taller box for the longer reflection.
  final int? minLines;
  final ValueChanged<String> onChanged;

  /// The review reflection is set in EBGaramond, for the feel of a written page.
  final bool serif;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final baseStyle = serif
        ? theme.textTheme.bodyLarge?.copyWith(
            fontFamily: AppTheme.fontFamilyEBGaramond,
            height: 1.6,
          )
        : theme.textTheme.bodyLarge;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (prompt != null) ...[
          Text(
            prompt!,
            style: theme.textTheme.titleMedium?.copyWith(
              fontFamily: AppTheme.fontFamilyEBGaramond,
              fontWeight: FontWeight.w500,
              color: scheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
        ],
        TextField(
          controller: controller,
          onChanged: onChanged,
          maxLines: maxLines,
          minLines: minLines ?? (maxLines > 4 ? 6 : null),
          keyboardType: TextInputType.multiline,
          textCapitalization: TextCapitalization.sentences,
          style: baseStyle?.copyWith(color: scheme.onSurface),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: baseStyle?.copyWith(color: scheme.onSurfaceVariant),
            filled: true,
            fillColor: scheme.surfaceContainerHighest.withValues(alpha: 0.4),
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.card),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

class _MarkedSinsList extends ConsumerWidget {
  const _MarkedSinsList({required this.day, required this.marks});

  final DateTime day;
  final List<JournalSinMark> marks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final resolver = ref.watch(sinTextResolverProvider).valueOrNull;
    final resolved = resolver == null
        ? const <ResolvedSinMark>[]
        : [for (final mark in marks) resolver.resolve(mark)];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final item in resolved)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              // A confessed sin is set apart, gently: it is no longer one of
              // the things weighing on the day.
              color: item.isAbsolved
                  ? scheme.primaryContainer.withValues(alpha: 0.35)
                  : scheme.surfaceContainerHighest.withValues(alpha: 0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.card),
                side: BorderSide(
                  color: item.isAbsolved
                      ? scheme.primary.withValues(alpha: 0.4)
                      : scheme.outlineVariant,
                ),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.fromLTRB(16, 4, 8, 4),
                title: Text(
                  // With confession history off, a confessed free-text sin has
                  // had its words cleared — say so, rather than showing an
                  // empty line.
                  item.text.isEmpty ? l10n.journalSinCleared : item.text,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: item.isAbsolved
                        ? scheme.onSurfaceVariant
                        : scheme.onSurface,
                    fontStyle: item.text.isEmpty
                        ? FontStyle.italic
                        : FontStyle.normal,
                  ),
                ),
                subtitle: item.isAbsolved
                    ? Text(
                        l10n.journalAbsolved,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: scheme.primary,
                        ),
                      )
                    : null,
                trailing: item.isAbsolved
                    ? Icon(
                        Icons.check_circle,
                        color: scheme.primary,
                        semanticLabel: l10n.journalAbsolved,
                      )
                    : IconButton(
                        icon: const Icon(Icons.close),
                        tooltip: l10n.journalRemoveSin,
                        color: scheme.onSurfaceVariant,
                        onPressed: () {
                          HapticUtils.lightImpact();
                          ref
                              .read(
                                journalEntryControllerProvider(day).notifier,
                              )
                              .removeMark(item.mark.id);
                        },
                      ),
              ),
            ),
          ),
        const SizedBox(height: 4),
        OutlinedButton.icon(
          onPressed: () {
            HapticUtils.lightImpact();
            showSinQuickPicker(context, day);
          },
          icon: const Icon(Icons.add),
          label: Text(l10n.journalAddSin),
        ),
      ],
    );
  }
}
