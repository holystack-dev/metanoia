import 'dart:ui' as ui;

import 'package:confessionapp/src/core/constants/app_constants.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/preferences/preferences_provider.dart';
import 'package:confessionapp/src/core/router/app_router.dart';
import 'package:confessionapp/src/core/utils/erase_local_data.dart';
import 'package:confessionapp/src/core/theme/app_text_scaler.dart';
import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:confessionapp/src/core/theme/theme_provider.dart';
import 'package:confessionapp/src/core/theme/font_size_provider.dart';
import 'package:confessionapp/src/core/localization/language_provider.dart';
import 'package:confessionapp/src/features/authentication/domain/models/auth_settings.dart';
import 'package:confessionapp/src/features/authentication/presentation/providers/auth_provider.dart';
import 'package:confessionapp/src/features/authentication/presentation/screens/lock_screen.dart';
import 'package:confessionapp/src/features/onboarding/presentation/onboarding_controller.dart';
import 'package:confessionapp/src/features/settings/data/reminder_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Offline-only app with no crash reporter: log uncaught errors at least.
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    debugPrint('Uncaught Flutter error: ${details.exception}');
  };
  ui.PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('Uncaught platform error: $error\n$stack');
    return true;
  };

  // Loaded before the first frame so the theme and font-size controllers can
  // resolve synchronously and the first frame is drawn with the right settings.
  final preferences = await SharedPreferences.getInstance();

  runApp(AppRoot(preferences: preferences));
}

/// Hosts the [ProviderScope] and can rebuild it from scratch.
///
/// "Delete all data" restarts it so every provider is disposed and no screen
/// keeps serving cached rows from the deleted database.
class AppRoot extends StatefulWidget {
  const AppRoot({super.key, required this.preferences});

  final SharedPreferences preferences;

  /// A restart callback bound to the root, which keeps working after [context]
  /// itself has been unmounted.
  ///
  /// Capture this before any await that can unmount the caller: deleting all
  /// data flips the auth state and removes the lock screen from the tree.
  static VoidCallback restarterOf(BuildContext context) {
    final root = context.findAncestorStateOfType<_AppRootState>();
    return () => root?.restart();
  }

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  Key _scopeKey = UniqueKey();

  void restart() {
    if (!mounted) return;
    setState(() => _scopeKey = UniqueKey());
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      key: _scopeKey,
      overrides: [
        sharedPreferencesProvider.overrideWithValue(widget.preferences),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Top up the notification schedule at launch, for users who never open
    // Settings.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(reminderSettingsProvider.notifier).refreshScheduleIfNeeded();
      ref
          .read(journalReminderSettingsProvider.notifier)
          .refreshScheduleIfNeeded();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Convert Flutter's AppLifecycleState to our auth AppLifecycleState
    final authLifecycleState = switch (state) {
      AppLifecycleState.resumed => AuthAppLifecycleState.resumed,
      AppLifecycleState.inactive => AuthAppLifecycleState.inactive,
      AppLifecycleState.paused => AuthAppLifecycleState.paused,
      AppLifecycleState.detached => AuthAppLifecycleState.detached,
      AppLifecycleState.hidden => AuthAppLifecycleState.hidden,
    };

    ref
        .read(authControllerProvider.notifier)
        .onAppLifecycleChange(authLifecycleState);
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(goRouterProvider);
    final themeMode = ref.watch(themeModeControllerProvider);
    final fontSizeScale = ref.watch(fontSizeControllerProvider);
    final languageState = ref.watch(languageControllerProvider);
    final authState = ref.watch(authControllerProvider);
    final onboardingCompleted = ref.watch(onboardingControllerProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Metanoia',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
      locale: languageState.valueOrNull,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) {
        // Applied over the live MediaQuery. A `MediaQueryData.fromView`
        // snapshot would freeze insets, rotation and brightness at startup.
        final media = MediaQuery.of(context);

        return MediaQuery(
          data: media.copyWith(
            // Composed with the system scaler, not substituted for it, so the
            // OS accessibility text size is still honoured.
            textScaler: AppTextScaler(
              system: media.textScaler,
              preference: fontSizeScale.scale,
            ),
          ),
          child: UpgradeAlert(
            navigatorKey: router.routerDelegate.navigatorKey,
            upgrader: Upgrader(
              storeController: UpgraderStoreController(
                onAndroid: () => UpgraderPlayStore(),
                oniOS: () => UpgraderAppStore(),
              ),
              minAppVersion: UpdateConfig.minAppVersion,
              durationUntilAlertAgain: const Duration(
                days: UpdateConfig.daysUntilAlertAgain,
              ),
            ),
            child: AppShell(
              authState: authState,
              onboardingCompleted: onboardingCompleted,
              content: child,
            ),
          ),
        );
      },
    );
  }
}

/// Whether the app content must be covered.
///
/// Fails closed: content stays covered while auth is loading or errored.
/// Onboarding resolves synchronously from preloaded preferences, so it has no
/// unknown state.
///
/// A pure function so the state matrix can be tested. Every state that returns
/// `false` is one in which the user's data is on screen.
bool shouldBlockAppContent({
  required AsyncValue<AuthState> authState,
  required bool onboardingCompleted,
}) {
  // Nothing to protect before onboarding: there is no PIN yet.
  if (!onboardingCompleted) return false;

  if (authState.isLoading || authState.hasError) return true;

  final status = authState.valueOrNull?.status;
  return status == AuthStatus.locked || status == AuthStatus.lockedOut;
}

/// The routed app content, with the auth overlay stacked over it when locked.
///
/// The overlay is a [Stack] sibling rather than a route, so it provides the
/// isolation a [ModalRoute] would:
///
///  * pointer events, via the opaque [GestureDetector] in [_AuthGate];
///  * semantics, via [BlockSemantics], so a screen reader cannot read the
///    content painted underneath the lock screen.
class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.authState,
    required this.onboardingCompleted,
    required this.content,
  });

  final AsyncValue<AuthState> authState;
  final bool onboardingCompleted;
  final Widget? content;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        content ?? const SizedBox.shrink(),
        if (shouldBlockAppContent(
          authState: authState,
          onboardingCompleted: onboardingCompleted,
        ))
          Positioned.fill(
            child: BlockSemantics(child: _AuthGate(authState: authState)),
          ),
      ],
    );
  }
}

/// The blocking layer shown over app content.
///
/// Renders the lock screen when auth has resolved to a locked state, and an
/// opaque splash while it is still resolving or has failed — never a gap
/// through which the content below is visible or tappable.
///
/// A plain subtree inside the app's `builder`, so it inherits theme,
/// localizations and [MediaQuery] without its own [Navigator].
class _AuthGate extends StatelessWidget {
  const _AuthGate({required this.authState});

  final AsyncValue<AuthState> authState;

  @override
  Widget build(BuildContext context) {
    // Opaque hit testing stops pointer events reaching the content underneath.
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {},
      child: switch (authState) {
        // The keystore cannot be read, so the database key is gone (restored
        // backup, reset secure enclave, changed device security). Offer a way
        // out rather than an endless spinner.
        AsyncError() => const _UnrecoverableScreen(),
        AsyncLoading() => const _StartupShield(),
        _ => const LockScreen(),
      },
    );
  }
}

/// Shown when the database key is unrecoverable.
///
/// The encrypted data cannot be recovered, so the only option is to erase and
/// start again.
class _UnrecoverableScreen extends ConsumerStatefulWidget {
  const _UnrecoverableScreen();

  @override
  ConsumerState<_UnrecoverableScreen> createState() =>
      _UnrecoverableScreenState();
}

class _UnrecoverableScreenState extends ConsumerState<_UnrecoverableScreen> {
  bool _erasing = false;

  Future<void> _eraseAndStartOver() async {
    final l10n = AppLocalizations.of(context)!;

    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            title: Text(l10n.eraseAndStartOver),
            content: Text(l10n.eraseAndStartOverConfirm),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: Text(l10n.cancel),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(dialogContext).colorScheme.error,
                ),
                onPressed: () => Navigator.pop(dialogContext, true),
                child: Text(l10n.eraseAndStartOver),
              ),
            ],
          ),
    );

    if (confirmed != true || !mounted) return;

    // Captured before the await: erasing rebuilds the whole provider scope,
    // which unmounts this screen.
    final restartApp = AppRoot.restarterOf(context);
    setState(() => _erasing = true);

    await eraseAllLocalData();
    restartApp();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.lock_outline_rounded,
                  size: 56,
                  color: theme.colorScheme.error,
                ),
                const SizedBox(height: 24),
                Text(
                  l10n.dataUnrecoverableTitle,
                  style: theme.textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.dataUnrecoverableBody,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                if (_erasing)
                  CircularProgressIndicator(color: theme.colorScheme.primary)
                else
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: theme.colorScheme.error,
                    ),
                    onPressed: _eraseAndStartOver,
                    child: Text(l10n.eraseAndStartOver),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Opaque cover shown while auth state is unknown. Shows no content, since
/// auth may be broken.
class _StartupShield extends StatelessWidget {
  const _StartupShield();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Center(
        child: CircularProgressIndicator(color: colorScheme.primary),
      ),
    );
  }
}
