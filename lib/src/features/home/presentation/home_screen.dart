import 'package:confessionapp/src/core/localization/content_language_provider.dart';
import 'package:confessionapp/src/core/theme/app_radius.dart';
import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:flutter/material.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:confessionapp/src/core/tutorial/tutorial_controller.dart';
import 'package:confessionapp/src/core/theme/app_showcase.dart';
import 'package:confessionapp/src/features/confession/presentation/widgets/anniversary_card.dart';
import 'package:confessionapp/src/features/home/presentation/providers/quote_provider.dart';
import 'package:confessionapp/src/core/services/spread_the_word_service.dart';
import 'package:confessionapp/src/features/home/presentation/widgets/primary_cta_card.dart';
import 'package:confessionapp/src/features/home/presentation/widgets/spread_the_word_card.dart';
import 'package:confessionapp/src/features/home/presentation/widgets/stats_card.dart';
import 'package:confessionapp/src/features/journal/presentation/widgets/streak_badge.dart';
import 'package:confessionapp/src/features/liturgical/presentation/widgets/liturgical_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return ShowCaseWidget(
      blurValue: 1,
      enableAutoScroll: true,
      builder: (context) => const _HomeContent(),
      autoPlayDelay: const Duration(seconds: 3),
    );
  }
}

/// The home screen, in priority order:
///
/// 1. the state-aware call to action ("what should I do now?"),
/// 2. the evening-reflection nudge,
/// 3. the liturgical and anniversary invitations (silent on an ordinary day),
/// 4. the daily quote,
/// 5. the stats row,
/// 6. a link into the guide,
/// 7. the share/rate invitation.
class _HomeContent extends ConsumerStatefulWidget {
  const _HomeContent();

  @override
  ConsumerState<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends ConsumerState<_HomeContent> {
  final GlobalKey _ctaKey = GlobalKey();
  final GlobalKey _journalKey = GlobalKey();
  final GlobalKey _guideKey = GlobalKey();
  final GlobalKey _settingsKey = GlobalKey();

  /// Guards against showing the showcase more than once per "should show" state.
  bool _tutorialHandled = false;

  /// Ensures a `?tutorial_reset=true` navigation is consumed exactly once, even
  /// though [didChangeDependencies] re-runs on every theme/locale change.
  bool _tutorialResetHandled = false;

  @override
  void initState() {
    super.initState();
    // Counts launches for the "spread the word" invitation. Fire and forget.
    SpreadTheWordService().recordAppOpen();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _maybeShowTutorial();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // One-shot: the tutorial_reset query parameter stays in the route URI, so
    // without this guard any rebuild would replay it.
    if (_tutorialResetHandled) return;
    final state = GoRouterState.of(context);
    if (state.uri.queryParameters['tutorial_reset'] != 'true') return;

    _tutorialResetHandled = true;
    _tutorialHandled = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _maybeShowTutorial();
    });
  }

  Future<void> _maybeShowTutorial() async {
    if (_tutorialHandled) return;
    _tutorialHandled = true;

    final controller = ref.read(tutorialControllerProvider.notifier);
    final shouldShow = await controller.shouldShowHomeTutorial();

    if (shouldShow && mounted) {
      _startTutorial();
      // Mark it shown immediately so the showcase cannot fire again.
      await controller.markHomeTutorialShown();
    }
  }

  void _startTutorial() {
    if (!mounted) return;
    // ignore: deprecated_member_use
    ShowCaseWidget.of(context).startShowCase([
      _ctaKey,
      _journalKey,
      _guideKey,
      _settingsKey,
    ]);
  }

  Future<void> _onRefresh() async {
    HapticUtils.lightImpact();
    final contentLanguageAsync = ref.read(contentLanguageControllerProvider);
    final locale =
        contentLanguageAsync.valueOrNull ?? Localizations.localeOf(context);
    // Re-rolls the random quote.
    ref.invalidate(randomQuoteProvider(locale));
    // Keeps the refresh indicator visible long enough to register.
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final cardShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppRadius.sheet),
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.surface,
              theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
            ],
          ),
        ),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            color: theme.colorScheme.primary,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              l10n.appTitle,
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            AppShowcase(
                              showcaseKey: _settingsKey,
                              title: l10n.settingsTitle,
                              description: l10n.tutorialSettingsDesc,
                              shapeBorder: const CircleBorder(),
                              currentStep: 4,
                              totalSteps: 4,
                              child: IconButton(
                                icon: const Icon(Icons.settings_outlined),
                                onPressed: () {
                                  HapticUtils.lightImpact();
                                  context.push('/settings');
                                },
                                tooltip: l10n.settingsTitle,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // 1. What should I do now?
                        AppShowcase(
                          showcaseKey: _ctaKey,
                          title: l10n.examineTitle,
                          description: l10n.tutorialExamineDesc,
                          shapeBorder: cardShape,
                          currentStep: 1,
                          totalSteps: 4,
                          child: const PrimaryCtaCard(),
                        ),
                        const SizedBox(height: 16),
                        // 2. The evening reflection.
                        AppShowcase(
                          showcaseKey: _journalKey,
                          title: l10n.journalTitle,
                          description: l10n.tutorialJournalDesc,
                          shapeBorder: cardShape,
                          currentStep: 2,
                          totalSteps: 4,
                          child: const _JournalCard(),
                        ),
                        const SizedBox(height: 16),
                        // 3. Both render a `SizedBox.shrink()` on an ordinary
                        // day.
                        const LiturgicalCard(),
                        const AnniversaryCard(),
                        // 4. The quote.
                        const _DailyQuoteCard(),
                        const SizedBox(height: 16),
                        // 5. Stats.
                        const StatsCard(),
                        const SizedBox(height: 16),
                        // 6. The guide.
                        AppShowcase(
                          showcaseKey: _guideKey,
                          title: l10n.guideTitle,
                          description: l10n.tutorialGuideDesc,
                          shapeBorder: cardShape,
                          currentStep: 3,
                          totalSteps: 4,
                          child: const _GuideCard(),
                        ),
                        const SizedBox(height: 16),
                        // 7. The share/rate invitation; renders nothing until
                        // earned.
                        const SpreadTheWordCard(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Entry point to the daily journal, with the reflection streak.
///
/// Not wrapped in `.animate()`: it rebuilds whenever the streak stream emits,
/// which would replay the entrance animation as a flicker.
class _JournalCard extends StatelessWidget {
  const _JournalCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          HapticUtils.lightImpact();
          // The journal is a shell tab: switch branches rather than pushing a
          // copy on top of the shell.
          context.go('/journal');
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: scheme.primary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.nightlight_round,
                  color: scheme.primary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.journalHomeCardTitle,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: scheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.journalHomeCardSubtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontFamily: AppTheme.fontFamilyEBGaramond,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const StreakBadge(compact: true),
              const SizedBox(width: 4),
              Icon(
                Icons.chevron_right,
                color: scheme.onSurfaceVariant,
                semanticLabel: l10n.navigate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Link into the guide, which has no tab of its own. Kept low on the page
/// because the guide is read rarely.
class _GuideCard extends StatelessWidget {
  const _GuideCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          HapticUtils.lightImpact();
          context.push('/guide');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Icon(Icons.help_outline, color: scheme.onSurfaceVariant, size: 22),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.guideTitle,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: scheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.homeGuideCardSubtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: scheme.onSurfaceVariant,
                semanticLabel: l10n.navigate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The daily quote.
///
/// Clamped to four lines, tap to expand, so a long quote cannot push the call
/// to action below the fold. The decorative circles are static: a looping
/// animation here would repaint forever and block `pumpAndSettle`.
class _DailyQuoteCard extends ConsumerStatefulWidget {
  const _DailyQuoteCard();

  @override
  ConsumerState<_DailyQuoteCard> createState() => _DailyQuoteCardState();
}

class _DailyQuoteCardState extends ConsumerState<_DailyQuoteCard> {
  static const _collapsedLines = 4;

  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final contentLanguageAsync = ref.watch(contentLanguageControllerProvider);
    final locale =
        contentLanguageAsync.valueOrNull ?? Localizations.localeOf(context);
    final quoteAsync = ref.watch(randomQuoteProvider(locale));

    final isDark = theme.brightness == Brightness.dark;
    final onQuote = isDark ? scheme.onSurface : scheme.onPrimary;

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: isDark ? scheme.surfaceContainerHighest : scheme.primary,
        borderRadius: BorderRadius.circular(AppRadius.card),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            HapticUtils.lightImpact();
            setState(() => _expanded = !_expanded);
          },
          child: Stack(
            children: [
              // Static decoration; see the class doc.
              Positioned(
                top: -40,
                right: -30,
                child: _DecorativeCircle(size: 120, color: onQuote),
              ),
              Positioned(
                bottom: -30,
                left: -24,
                child: _DecorativeCircle(size: 80, color: onQuote),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: quoteAsync.when(
                  data: (quote) {
                    final quoteStyle = theme.textTheme.bodyMedium?.copyWith(
                      fontFamily: AppTheme.fontFamilyEBGaramond,
                      color: onQuote,
                      fontStyle: FontStyle.italic,
                      height: 1.4,
                    );
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        // Offer "Read more" only when the quote overflows the
                        // clamp, measured at the text's real width (row less
                        // the icon and its 10px gap) and text scale.
                        final overflows = _quoteExceedsClamp(
                          text: quote.quote,
                          style: quoteStyle,
                          maxWidth: (constraints.maxWidth - 32).clamp(
                            0.0,
                            double.infinity,
                          ),
                          maxLines: _collapsedLines,
                          textScaler: MediaQuery.textScalerOf(context),
                          textDirection: Directionality.of(context),
                        );
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.format_quote_rounded,
                                  color: onQuote.withValues(alpha: 0.5),
                                  size: 22,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    quote.quote,
                                    maxLines:
                                        _expanded ? null : _collapsedLines,
                                    overflow:
                                        _expanded
                                            ? TextOverflow.visible
                                            : TextOverflow.ellipsis,
                                    style: quoteStyle,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    quote.author.toUpperCase(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: onQuote.withValues(alpha: 0.85),
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2,
                                      fontFamily: AppTheme.fontFamilyLato,
                                    ),
                                  ),
                                ),
                                if (overflows) ...[
                                  const SizedBox(width: 8),
                                  Text(
                                    _expanded
                                        ? l10n.homeQuoteShowLess
                                        : l10n.homeQuoteReadMore,
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: onQuote.withValues(alpha: 0.85),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                  loading:
                      () => SizedBox(
                        height: 72,
                        child: Center(
                          child: CircularProgressIndicator(color: onQuote),
                        ),
                      ),
                  error:
                      (_, __) => Row(
                        children: [
                          Icon(
                            Icons.format_quote_rounded,
                            color: onQuote.withValues(alpha: 0.5),
                            size: 22,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              l10n.dailyQuoteError,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: onQuote,
                                fontFamily: AppTheme.fontFamilyLato,
                              ),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              HapticUtils.lightImpact();
                              ref.invalidate(randomQuoteProvider(locale));
                            },
                            icon: const Icon(Icons.refresh, size: 18),
                            label: Text(l10n.retry),
                            style: TextButton.styleFrom(
                              foregroundColor: onQuote,
                            ),
                          ),
                        ],
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

/// Whether [text] in [style] needs more than [maxLines] lines at [maxWidth],
/// laid out with the same [textScaler] the [Text] will use.
bool _quoteExceedsClamp({
  required String text,
  required TextStyle? style,
  required double maxWidth,
  required int maxLines,
  required TextScaler textScaler,
  required TextDirection textDirection,
}) {
  final painter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: maxLines,
    textScaler: textScaler,
    textDirection: textDirection,
  )..layout(maxWidth: maxWidth);
  return painter.didExceedMaxLines;
}

class _DecorativeCircle extends StatelessWidget {
  const _DecorativeCircle({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withValues(alpha: 0.05),
        ),
      ),
    );
  }
}
