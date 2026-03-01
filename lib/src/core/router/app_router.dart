import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:confessionapp/src/features/authentication/domain/models/auth_settings.dart';
import 'package:confessionapp/src/features/authentication/presentation/providers/auth_provider.dart';
import 'package:confessionapp/src/features/authentication/presentation/screens/pin_setup_screen.dart';
import 'package:confessionapp/src/features/authentication/presentation/screens/security_settings_screen.dart';
import 'package:confessionapp/src/features/confession/presentation/confession_screen.dart';
import 'package:confessionapp/src/features/confession/presentation/confession_history_screen.dart';
import 'package:confessionapp/src/features/confession/presentation/insights_screen.dart';
import 'package:confessionapp/src/features/confession/presentation/penance_screen.dart';
import 'package:confessionapp/src/features/examination/presentation/examination_screen.dart';
import 'package:confessionapp/src/features/examination/presentation/custom_sins_screen.dart';
import 'package:confessionapp/src/features/guide/presentation/confession_guide_screen.dart';
import 'package:confessionapp/src/features/guide/presentation/faq_screen.dart';
import 'package:confessionapp/src/features/guide/presentation/guide_screen.dart';
import 'package:confessionapp/src/features/guide/presentation/invitation_screen.dart';
import 'package:confessionapp/src/features/guide/presentation/prayers_screen.dart';
import 'package:confessionapp/src/features/home/presentation/home_screen.dart';
import 'package:confessionapp/src/features/settings/presentation/settings_screen.dart';
import 'package:confessionapp/src/features/settings/presentation/about_screen.dart';
import 'package:confessionapp/src/features/onboarding/presentation/onboarding_screen.dart';
import 'package:confessionapp/src/features/onboarding/presentation/onboarding_controller.dart';
import 'package:confessionapp/src/core/router/scaffold_with_navbar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'app_router.g.dart';

@riverpod
GoRouter goRouter(Ref ref) {
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
  final examineNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'examine');
  final confessNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'confess');
  final guideNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'guide');

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    redirect: (context, state) async {
      final onboardingCompleted =
          await ref
              .read(onboardingControllerProvider.notifier)
              .hasCompletedOnboarding();
      final isOnOnboardingPage = state.matchedLocation == '/onboarding';
      final isOnPinSetupPage = state.matchedLocation == '/pin-setup';

      // If not completed and not on onboarding, redirect to onboarding
      if (!onboardingCompleted && !isOnOnboardingPage) {
        return '/onboarding';
      }

      // If completed and on onboarding, redirect to home
      if (onboardingCompleted && isOnOnboardingPage) {
        return '/';
      }

      // Sensitive routes that require PIN setup
      const sensitiveRoutes = [
        '/examine',
        '/confess',
        '/settings',
      ];

      // Check if navigating to a sensitive route without PIN set
      if (onboardingCompleted && !isOnPinSetupPage) {
        final authState = ref.read(authControllerProvider).valueOrNull;
        final isPinDeferred =
            authState?.status == AuthStatus.pinSetupDeferred ||
            authState?.status == AuthStatus.uninitialized;

        if (isPinDeferred) {
          // Check if trying to access sensitive routes
          final isSensitiveRoute = sensitiveRoutes.any(
            (route) => state.matchedLocation.startsWith(route),
          );

          if (isSensitiveRoute) {
            // Pass the intended destination as a query parameter
            return '/pin-setup?redirect=${Uri.encodeComponent(state.matchedLocation)}';
          }
        }
      }

      return null;
    },
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: homeNavigatorKey,
            routes: [
              GoRoute(
                path: '/',
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: HomeScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: examineNavigatorKey,
            routes: [
              GoRoute(
                path: '/examine',
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: ExaminationScreen()),
                routes: [
                  GoRoute(
                    path: 'custom-sins',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const CustomSinsScreen(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: confessNavigatorKey,
            routes: [
              GoRoute(
                path: '/confess',
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: ConfessionScreen()),
                routes: [
                  GoRoute(
                    path: 'history',
                    parentNavigatorKey: rootNavigatorKey,
                    builder:
                        (context, state) => const ConfessionHistoryScreen(),
                  ),
                  GoRoute(
                    path: 'penance',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const PenanceScreen(),
                  ),
                  GoRoute(
                    path: 'insights',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const InsightsScreen(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: guideNavigatorKey,
            routes: [
              GoRoute(
                path: '/guide',
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: GuideScreen()),
                routes: [
                  GoRoute(
                    path: 'faq',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const FaqScreen(),
                  ),
                  GoRoute(
                    path: 'prayers',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const PrayersScreen(),
                  ),
                  GoRoute(
                    path: 'invitation',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const InvitationScreen(),
                  ),
                  GoRoute(
                    path: 'confession',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) => const ConfessionGuideScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/settings',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const SettingsScreen(),
        routes: [
          GoRoute(
            path: 'about',
            parentNavigatorKey: rootNavigatorKey,
            builder: (context, state) => const AboutScreen(),
          ),
          GoRoute(
            path: 'security',
            parentNavigatorKey: rootNavigatorKey,
            builder: (context, state) => const SecuritySettingsScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/onboarding',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/pin-setup',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final redirect = state.uri.queryParameters['redirect'];
          return PinSetupScreen(redirectTo: redirect);
        },
      ),
    ],
  );
}
