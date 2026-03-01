import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:confessionapp/src/features/onboarding/presentation/onboarding_controller.dart';
import 'package:confessionapp/src/features/onboarding/presentation/pages/content_language_page.dart';
import 'package:confessionapp/src/features/onboarding/presentation/pages/feature_page.dart';
import 'package:confessionapp/src/features/onboarding/presentation/pages/metanoia_intro_page.dart';
import 'package:confessionapp/src/features/onboarding/presentation/pages/ready_to_begin_page.dart';
import 'package:confessionapp/src/features/onboarding/presentation/pages/spiritual_journey_page.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Total pages: Intro, Welcome, 4 Features, Language, Ready = 8
  final int _totalPages = 8;

  void _nextPage() {
    HapticUtils.selectionClick();
    if (_currentPage < _totalPages - 1) {
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

  Future<void> _skipOnboarding() async {
    final theme = Theme.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return AlertDialog(
          backgroundColor: theme.colorScheme.surface,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
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

    if (confirmed == true) {
      await _completeOnboarding();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    // Show skip on all pages except the last page (language selection)
    final showSkip = _currentPage < _totalPages - 1;
    // Show back button except on first page
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
                // Page 0: Metanoia Intro
                MetanoiaIntroPage(onNext: _nextPage),
                // Page 1: Spiritual Journey (replaces Welcome)
                SpiritualJourneyPage(
                  onNext: _nextPage,
                  headline: l10n.metanoia,
                  subtitle: l10n.welcomeSubtitle,
                  buttonText: l10n.getStarted,
                ),
                // Pages 2-5: Features (flattened)
                FeaturePage(
                  icon: Icons.assignment_outlined,
                  title: l10n.examineTitle,
                  description: l10n.examineDescription,
                  color: theme.colorScheme.primary,
                  onNext: _nextPage,
                  buttonText: l10n.nextButton,
                ),
                FeaturePage(
                  icon: Icons.church_outlined,
                  title: l10n.confessTitle,
                  description: l10n.confessDescription,
                  color: theme.colorScheme.secondary,
                  onNext: _nextPage,
                  buttonText: l10n.nextButton,
                ),
                FeaturePage(
                  icon: Icons.menu_book_outlined,
                  title: l10n.prayersTitle,
                  description: l10n.prayersDescription,
                  color: theme.colorScheme.tertiary,
                  onNext: _nextPage,
                  buttonText: l10n.nextButton,
                ),
                FeaturePage(
                  icon: Icons.notifications_outlined,
                  title: l10n.reminders,
                  description: l10n.remindersDescription,
                  color: const Color(
                    0xFFE07B39,
                  ), // Warm orange - positive reminder association
                  onNext: _nextPage,
                  buttonText: l10n.nextButton,
                ),
                // Page 6: Language Selection
                ContentLanguagePage(onNext: _nextPage),
                // Page 7: Ready to Begin (Final)
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
                    // Back button
                    if (showBack)
                      IconButton(
                        onPressed: _previousPage,
                        icon: const Icon(Icons.arrow_back),
                        tooltip: l10n.back,
                      )
                    else
                      const SizedBox(width: 48),

                    // Progress dots (centered)
                    Expanded(
                      child: _ProgressDots(
                        currentPage: _currentPage,
                        totalPages: _totalPages,
                      ),
                    ),

                    // Skip button
                    if (showSkip)
                      TextButton(
                        onPressed: _skipOnboarding,
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
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
