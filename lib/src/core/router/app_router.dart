import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:confessionapp/src/features/authentication/presentation/providers/auth_provider.dart';
import 'package:confessionapp/src/features/authentication/presentation/screens/pin_setup_screen.dart';
import 'package:confessionapp/src/features/authentication/presentation/screens/security_settings_screen.dart';
import 'package:confessionapp/src/features/confession/presentation/confession_day_mode_screen.dart';
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
import 'package:confessionapp/src/core/utils/date_utils.dart';
import 'package:confessionapp/src/features/home/presentation/home_screen.dart';
import 'package:confessionapp/src/features/journal/presentation/journal_entry_screen.dart';
import 'package:confessionapp/src/features/journal/presentation/journal_screen.dart';
import 'package:confessionapp/src/features/settings/presentation/settings_screen.dart';
import 'package:confessionapp/src/features/settings/presentation/about_screen.dart';
import 'package:confessionapp/src/features/onboarding/presentation/onboarding_screen.dart';
import 'package:confessionapp/src/features/onboarding/presentation/onboarding_controller.dart';
import 'package:confessionapp/src/core/router/route_guard.dart';
import 'package:confessionapp/src/core/router/scaffold_with_navbar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'app_router.g.dart';

@riverpod
GoRouter goRouter(Ref ref) {
  final rootNavigatorKey = GlobalKey<NavigatorState>();
  final homeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
  final journalNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'journal');
  final examineNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'examine');
  final confessNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'confess');

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/',
    redirect: (context, state) async {
      // Synchronous: preferences are preloaded in `main`.
      final onboardingCompleted = ref.read(onboardingControllerProvider);

      // Awaited, not valueOrNull: auth is still loading on a cold start, and
      // the PIN guard must still apply to a deep link.
      final authState = await ref.read(authControllerProvider.future);

      return resolveRedirect(
        onboardingCompleted: onboardingCompleted,
        authStatus: authState.status,
        location: state.matchedLocation,
      );
    },
    routes: [
      // Tabs: Home, Journal, Examine, Confess. The guide is a root route below.
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
            navigatorKey: journalNavigatorKey,
            routes: [
              GoRoute(
                // In `sensitiveRoutes`; the top-level `redirect` guards branch
                // routes too.
                path: '/journal',
                pageBuilder:
                    (context, state) =>
                        const NoTransitionPage(child: JournalScreen()),
                routes: [
                  GoRoute(
                    // ISO yyyy-MM-dd. Pushed on the root navigator, so the
                    // day's entry covers the bottom navigation bar.
                    path: ':date',
                    parentNavigatorKey: rootNavigatorKey,
                    builder: (context, state) {
                      return JournalEntryScreen(
                        day: journalDayFromPath(state.pathParameters['date']),
                      );
                    },
                  ),
                ],
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
                    // Confession-day mode: on the root navigator so it covers
                    // the bottom bar. Guarded by the `/confess` prefix in
                    // `sensitiveRoutes`.
                    path: 'day-mode',
                    parentNavigatorKey: rootNavigatorKey,
                    builder:
                        (context, state) => const ConfessionDayModeScreen(),
                  ),
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
        ],
      ),
      // The guide, on the root navigator like /settings. `push('/guide/...')`
      // builds the leaf page only.
      GoRoute(
        path: '/guide',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => const GuideScreen(),
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
