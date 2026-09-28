import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/theme/app_radius.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:confessionapp/src/features/onboarding/presentation/onboarding_controller.dart';
import 'package:confessionapp/src/features/onboarding/presentation/pages/app_overview_page.dart';
import 'package:confessionapp/src/features/onboarding/presentation/pages/content_language_page.dart';
import 'package:confessionapp/src/features/onboarding/presentation/pages/metanoia_intro_page.dart';
import 'package:confessionapp/src/features/onboarding/presentation/pages/privacy_page.dart';
import 'package:confessionapp/src/features/onboarding/presentation/pages/ready_to_begin_page.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Metanoia, What this app does, Private by design, Language, Ready = 5
  static const int _totalPages = 5;
  static const int _lastPage = _totalPages - 1;

  void _nextPage() {
    HapticUtils.selectionClick();
    if (_currentPage < _lastPage) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    HapticUtils.selectionClick();
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _completeOnboarding() async {
    await ref
        .read(onboardingControllerProvider.notifier)
        .markOnboardingComplete();
    if (mounted) {
      context.go('/');
    }
  }

  /// Jumps to the final page rather than completing onboarding, so the
  /// disclaimer is always shown.
  Future<void> _skipToLastPage() async {
    final theme = Theme.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return AlertDialog(
          backgroundColor: theme.colorScheme.surface,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.sheet),
          ),
          title: Text(
            l10n.skipOnboardingTitle,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            l10n.skipOnboardingMessage,
            style: theme.textTheme.bodyLarge,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(l10n.skip),
            ),
          ],
        );
      },
    );

    if (confirmed == true && mounted) {
      HapticUtils.selectionClick();
      await _pageController.animateToPage(
        _lastPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Skip jumps to the last page (Ready to Begin), so it is pointless there.
    final showSkip = _currentPage < _lastPage;
    final showBack = _currentPage > 0;

    return Scaffold(
      body: Stack(
        children: [
          // Pages (full screen, behind the top bar)
          Positioned.fill(
            child: PageView(
              controller: _pageController,
              physics: const ClampingScrollPhysics(),
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                // Page 0: What "Metanoia" means
                MetanoiaIntroPage(onNext: _nextPage),
                // Page 1: What this app does — Examine, Confess, Journal
                AppOverviewPage(onNext: _nextPage),
                // Page 2: Private by design (and a PIN is coming)
                PrivacyPage(onNext: _nextPage),
                // Page 3: Content language
                ContentLanguagePage(onNext: _nextPage),
                // Page 4: Ready to begin, with the disclaimer (final)
                ReadyToBeginPage(onComplete: _completeOnboarding),
              ],
            ),
          ),

          // Transparent top bar overlay (back, progress dots, skip)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 8.0,
                ),
                child: Row(
                  children: [
                    if (showBack)
                      IconButton(
                        onPressed: _previousPage,
                        icon: const Icon(Icons.arrow_back),
                        tooltip: l10n.back,
                      )
                    else
                      const SizedBox(width: 48),

                    Expanded(
                      child: _ProgressDots(
                        currentPage: _currentPage,
                        totalPages: _totalPages,
                      ),
                    ),

                    if (showSkip)
                      TextButton(
                        onPressed: _skipToLastPage,
                        child: Text(l10n.skip),
                      )
                    else
                      const SizedBox(width: 48),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Progress indicator dots
class _ProgressDots extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const _ProgressDots({required this.currentPage, required this.totalPages});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: index == currentPage ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color:
                index <= currentPage
                    ? theme.colorScheme.primary
                    : theme.colorScheme.outlineVariant,
            borderRadius: BorderRadius.circular(AppRadius.xs),
          ),
        ),
      ),
    );
  }
}
