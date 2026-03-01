import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:confessionapp/src/features/onboarding/presentation/widgets/mystical_background.dart';
import 'package:flutter/material.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';

class MetanoiaIntroPage extends StatefulWidget {
  final VoidCallback onNext;

  const MetanoiaIntroPage({super.key, required this.onNext});

  @override
  State<MetanoiaIntroPage> createState() => _MetanoiaIntroPageState();
}

class _MetanoiaIntroPageState extends State<MetanoiaIntroPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation1;
  late Animation<double> _fadeAnimation2;
  late Animation<double> _fadeAnimation3;
  late Animation<double> _fadeAnimation4;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _fadeAnimation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.25, curve: Curves.easeIn),
      ),
    );
    _fadeAnimation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 0.5, curve: Curves.easeIn),
      ),
    );
    _fadeAnimation3 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.75, curve: Curves.easeIn),
      ),
    );
    _fadeAnimation4 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.75, 1.0, curve: Curves.easeIn),
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return MysticalBackground(
      showStars: true,
      starDensity: 0.4,
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(flex: 2),

                    // 1. Title: Metanoia
                    SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.appTitle,
                              style: TextStyle(
                                fontFamily: AppTheme.fontFamilyEBGaramond,
                                fontSize: 62,
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.primary,
                                letterSpacing: 0.5,
                                height: 1.0,
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Greek origin
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(
                                      color: theme.colorScheme.primary
                                          .withValues(alpha: 0.2),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    l10n.greekLabel,
                                    style: TextStyle(
                                      fontFamily: AppTheme.fontFamilyLato,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: theme.colorScheme.primary,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'μετάνοια',
                                  style: TextStyle(
                                    fontFamily: AppTheme.fontFamilyEBGaramond,
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic,
                                    color: theme.colorScheme.onSurface
                                        .withValues(alpha: 0.5),
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // 2. Phonetic
                    FadeTransition(
                      opacity: _fadeAnimation2,
                      child: Text(
                        '/ˌmɛtəˈnɔɪə/',
                        style: TextStyle(
                          fontFamily: AppTheme.fontFamilyEBGaramond,
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.5,
                          ),
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 3. Definition
                    FadeTransition(
                      opacity: _fadeAnimation3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.secondary.withValues(
                                alpha: 0.15,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              l10n.nounLabel,
                              style: TextStyle(
                                fontFamily: AppTheme.fontFamilyLato,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.secondary,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 28),
                          Text(
                            l10n.metanoiaDefinition,
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamilyLato,
                              fontSize: 20,
                              height: 1.7,
                              color: theme.colorScheme.onSurface,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(flex: 3),

                    // 4. Tagline / Button
                    FadeTransition(
                      opacity: _fadeAnimation4,
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              l10n.turnBackToGrace,
                              style: TextStyle(
                                fontFamily: AppTheme.fontFamilyEBGaramond,
                                fontSize: 20,
                                color: theme.colorScheme.onSurfaceVariant
                                    .withValues(alpha: 0.8),
                                fontStyle: FontStyle.italic,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 40),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: theme.colorScheme.primary
                                        .withValues(alpha: 0.4),
                                    blurRadius: 24,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: IconButton.filled(
                                onPressed: () {
                                  HapticUtils.mediumImpact();
                                  widget.onNext();
                                },
                                icon: const Icon(Icons.arrow_forward_rounded),
                                iconSize: 28,
                                style: IconButton.styleFrom(
                                  backgroundColor: theme.colorScheme.primary,
                                  foregroundColor: theme.colorScheme.onPrimary,
                                  padding: const EdgeInsets.all(20),
                                ),
                                tooltip: l10n.nextButton,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
