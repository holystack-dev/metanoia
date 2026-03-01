import 'package:confessionapp/src/core/localization/content_language_provider.dart';
import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:confessionapp/src/core/tutorial/tutorial_controller.dart';
import 'package:confessionapp/src/core/theme/app_showcase.dart';
import 'package:confessionapp/src/features/home/presentation/providers/quote_provider.dart';
import 'package:confessionapp/src/features/home/presentation/widgets/action_items_card.dart';
import 'package:confessionapp/src/features/home/presentation/widgets/stats_card.dart';

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

class _HomeContent extends ConsumerStatefulWidget {
  const _HomeContent();

  @override
  ConsumerState<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends ConsumerState<_HomeContent> {
  final GlobalKey _examineKey = GlobalKey();
  final GlobalKey _confessKey = GlobalKey();
  final GlobalKey _prayersKey = GlobalKey();
  final GlobalKey _guideKey = GlobalKey();
  final GlobalKey _settingsKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowTutorial();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Handle tutorial reset navigation
    final state = GoRouterState.of(context);
    if (state.uri.queryParameters['tutorial_reset'] == 'true') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _startTutorial();
      });
    }
  }

  Future<void> _checkAndShowTutorial() async {
    final controller = ref.read(tutorialControllerProvider.notifier);
    final shouldShow = await controller.shouldShowHomeTutorial();

    if (shouldShow && mounted) {
      _startTutorial();
      await controller.markHomeTutorialShown();
    }
  }

  void _startTutorial() {
    if (!mounted) return;
    // ignore: deprecated_member_use
    ShowCaseWidget.of(context).startShowCase([
      _examineKey,
      _confessKey,
      _prayersKey,
      _guideKey,
      _settingsKey,
    ]);
  }

  Future<void> _onRefresh() async {
    HapticUtils.lightImpact();
    // Get the current content language
    final contentLanguageAsync = ref.read(contentLanguageControllerProvider);
    final locale =
        contentLanguageAsync.valueOrNull ?? Localizations.localeOf(context);
    // Invalidate the quote provider to fetch a new random quote
    ref.invalidate(randomQuoteProvider(locale));
    // Wait a bit for the animation to feel natural
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

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
                    padding: const EdgeInsets.all(24.0),
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
                              currentStep: 5,
                              totalSteps: 5,
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
                        ).animate().fadeIn(),
                        const SizedBox(height: 32),
                        _DailyQuoteCard(theme: theme),
                        const SizedBox(height: 24),
                        const ActionItemsCard(),
                        const SizedBox(height: 16),
                        const StatsCard(),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverGrid.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.1,
                    children: [
                      AppShowcase(
                        showcaseKey: _examineKey,
                        title: l10n.examineTitle,
                        description: l10n.tutorialExamineDesc,
                        shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        currentStep: 1,
                        totalSteps: 5,
                        child: _HomeCard(
                          icon: Icons.assignment_outlined,
                          label: l10n.examineTitle,
                          onTap: () => context.go('/examine'),
                          color: theme.colorScheme.primaryContainer,
                          textColor: theme.colorScheme.onPrimaryContainer,
                          delay: 300.ms,
                        ),
                      ),
                      AppShowcase(
                        showcaseKey: _confessKey,
                        title: l10n.confessTitle,
                        description: l10n.tutorialConfessDesc,
                        shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        currentStep: 2,
                        totalSteps: 5,
                        child: _HomeCard(
                          icon: Icons.church_outlined,
                          label: l10n.confessTitle,
                          onTap: () => context.go('/confess'),
                          color: theme.colorScheme.secondaryContainer,
                          textColor: theme.colorScheme.onSecondaryContainer,
                          delay: 400.ms,
                        ),
                      ),
                      AppShowcase(
                        showcaseKey: _prayersKey,
                        title: l10n.prayersTitle,
                        description: l10n.tutorialPrayersDesc,
                        shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        currentStep: 3,
                        totalSteps: 5,
                        child: _HomeCard(
                          icon: Icons.menu_book_outlined,
                          label: l10n.prayersTitle,
                          onTap: () => context.go('/guide/prayers'),
                          color: theme.colorScheme.tertiaryContainer,
                          textColor: theme.colorScheme.onTertiaryContainer,
                          delay: 500.ms,
                        ),
                      ),
                      AppShowcase(
                        showcaseKey: _guideKey,
                        title: l10n.guideTitle,
                        description: l10n.tutorialGuideDesc,
                        shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        currentStep: 4,
                        totalSteps: 5,
                        child: _HomeCard(
                          icon: Icons.help_outline,
                          label: l10n.guideTitle,
                          onTap: () => context.go('/guide'),
                          color: theme.colorScheme.surfaceContainerHighest,
                          textColor: theme.colorScheme.onSurfaceVariant,
                          delay: 600.ms,
                        ),
                      ),
                    ],
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DailyQuoteCard extends ConsumerWidget {
  const _DailyQuoteCard({required this.theme});

  final ThemeData theme;

  /// Returns dynamic font size based on quote length for better readability
  double _getQuoteFontSize(int length) {
    if (length <= 100) return 22; // Slightly larger for short quotes
    if (length <= 200) return 20;
    if (length <= 300) return 18;
    if (length <= 500) return 16;
    return 14;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contentLanguageAsync = ref.watch(contentLanguageControllerProvider);
    final locale =
        contentLanguageAsync.valueOrNull ?? Localizations.localeOf(context);
    final quoteAsync = ref.watch(randomQuoteProvider(locale));

    final isDark = theme.brightness == Brightness.dark;

    // Colors based on theme mode
    final gradient =
        isDark
            ? LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colorScheme.surfaceContainerHighest,
                Color.lerp(
                      theme.colorScheme.surfaceContainerHighest,
                      theme.colorScheme.primaryContainer,
                      0.3,
                    ) ??
                    theme.colorScheme.surfaceContainerHighest,
              ],
            )
            : null;

    final backgroundColor = isDark ? null : theme.colorScheme.primary;

    final textColor =
        isDark ? theme.colorScheme.onSurface : theme.colorScheme.onPrimary;
    final authorColor =
        isDark
            ? theme.colorScheme.onSurface.withValues(alpha: 0.75)
            : theme.colorScheme.onPrimary.withValues(alpha: 0.85);
    final iconColor =
        isDark
            ? theme.colorScheme.primary.withValues(alpha: 0.5)
            : theme.colorScheme.onPrimary.withValues(alpha: 0.5);

    return Container(
      clipBehavior: Clip.hardEdge, // Ensure decorations don't overflow
      decoration: BoxDecoration(
        color: backgroundColor,
        gradient: gradient,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color:
                isDark
                    ? Colors.black.withValues(alpha: 0.3)
                    : theme.colorScheme.primary.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
            spreadRadius: -5,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative Circle 1 (Top Right)
          Positioned(
            top: -50,
            right: -50,
            child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (isDark
                            ? theme.colorScheme.onSurface
                            : theme.colorScheme.onPrimary)
                        .withValues(alpha: 0.05),
                  ),
                )
                .animate(
                  onPlay: (controller) => controller.repeat(reverse: true),
                )
                .scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.2, 1.2),
                  duration: 4.seconds,
                  curve: Curves.easeInOut,
                )
                .move(
                  begin: const Offset(0, 0),
                  end: const Offset(-10, 10),
                  duration: 4.seconds,
                  curve: Curves.easeInOut,
                ),
          ),
          // Decorative Circle 2 (Bottom Left)
          Positioned(
            bottom: -30,
            left: -30,
            child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (isDark
                            ? theme.colorScheme.onSurface
                            : theme.colorScheme.onPrimary)
                        .withValues(alpha: 0.05),
                  ),
                )
                .animate(
                  onPlay: (controller) => controller.repeat(reverse: true),
                )
                .scale(
                  begin: const Offset(1, 1),
                  end: const Offset(1.3, 1.3),
                  duration: 5.seconds,
                  curve: Curves.easeInOut,
                )
                .move(
                  begin: const Offset(0, 0),
                  end: const Offset(10, -10),
                  duration: 5.seconds,
                  curve: Curves.easeInOut,
                ),
          ),

          // Main Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: quoteAsync.when(
              data:
                  (quote) => Column(
                    children: [
                      // Decorative Icon
                      Icon(
                        Icons.format_quote_rounded,
                        color: iconColor,
                        size: 40,
                      ),
                      const SizedBox(height: 20),
                      // Quote Text
                      Text(
                        quote.quote,
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamilyEBGaramond,
                          color: textColor,
                          fontSize: _getQuoteFontSize(quote.quote.length),
                          fontStyle: FontStyle.italic,
                          height: 1.4, // Improved line height
                          letterSpacing: 0.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      // Decorative Divider
                      Container(
                        width: 40,
                        height: 2,
                        decoration: BoxDecoration(
                          color:
                              isDark
                                  ? theme.colorScheme.primary.withValues(
                                    alpha: 0.3,
                                  )
                                  : theme.colorScheme.onPrimary.withValues(
                                    alpha: 0.4,
                                  ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Author Text
                      Text(
                        quote.author.toUpperCase(),
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: authorColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5, // Premium spacing
                          fontFamily: AppTheme.fontFamilyLato,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
              loading:
                  () => SizedBox(
                    height: 160,
                    child: Center(
                      child: CircularProgressIndicator(color: textColor),
                    ),
                  ),
              error: (_, __) => const SizedBox(),
            ),
          ),
        ],
      ),
    ).animate().fadeIn().scale(
      begin: const Offset(0.95, 0.95),
      curve: Curves.easeOutCubic,
    );
  }
}

class _HomeCard extends StatefulWidget {
  const _HomeCard({
    this.icon,
    this.customIcon,
    required this.label,
    required this.onTap,
    this.color,
    this.textColor,
    required this.delay,
  }) : assert(icon != null || customIcon != null);

  final IconData? icon;
  final Widget? customIcon;
  final String label;
  final VoidCallback onTap;
  final Color? color;
  final Color? textColor;
  final Duration delay;

  @override
  State<_HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<_HomeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    HapticUtils.lightImpact();
    widget.onTap();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor =
        widget.color ?? theme.colorScheme.surfaceContainerHighest;
    final foregroundColor =
        widget.textColor ?? theme.colorScheme.onSurfaceVariant;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(scale: _scaleAnimation.value, child: child);
        },
        child: Material(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          elevation: 0,
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration:
                    widget.customIcon != null
                        ? null
                        : BoxDecoration(
                          color: foregroundColor.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                child:
                    widget.customIcon ??
                    Icon(widget.icon, size: 32, color: foregroundColor),
              ),
              const SizedBox(height: 12),
              Text(
                widget.label,
                style: theme.textTheme.titleSmall?.copyWith(
                  color: foregroundColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: widget.delay).slideY(begin: 0.2, end: 0);
  }
}
