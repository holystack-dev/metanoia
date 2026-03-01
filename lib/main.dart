import 'package:confessionapp/src/core/constants/app_constants.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/router/app_router.dart';
import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:confessionapp/src/core/theme/theme_provider.dart';
import 'package:confessionapp/src/core/theme/font_size_provider.dart';
import 'package:confessionapp/src/core/localization/language_provider.dart';
import 'package:confessionapp/src/features/authentication/domain/models/auth_settings.dart';
import 'package:confessionapp/src/features/authentication/presentation/providers/auth_provider.dart';
import 'package:confessionapp/src/features/authentication/presentation/screens/lock_screen.dart';
import 'package:confessionapp/src/features/onboarding/presentation/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upgrader/upgrader.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
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

    ref.read(authControllerProvider.notifier).onAppLifecycleChange(authLifecycleState);
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(goRouterProvider);
    final themeMode = ref.watch(themeModeControllerProvider);
    final fontSizeScale = ref.watch(fontSizeControllerProvider);
    final languageState = ref.watch(languageControllerProvider);
    final authState = ref.watch(authControllerProvider);
    final onboardingCompleted = ref.watch(onboardingControllerProvider);

    return MediaQuery(
      data: MediaQueryData.fromView(View.of(context)).copyWith(
        textScaler: TextScaler.linear(fontSizeScale.scale),
      ),
      child: MaterialApp.router(
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
          return UpgradeAlert(
            navigatorKey: router.routerDelegate.navigatorKey,
            upgrader: Upgrader(
              storeController: UpgraderStoreController(
                onAndroid: () => UpgraderPlayStore(),
                oniOS: () => UpgraderAppStore(),
              ),
              minAppVersion: UpdateConfig.minAppVersion,
              durationUntilAlertAgain: const Duration(days: UpdateConfig.daysUntilAlertAgain),
            ),
            child: Stack(
              children: [
                child ?? const SizedBox.shrink(),
                // Lock screen overlay - only show for locked/lockedOut states
                // Don't show for pinSetupDeferred (user can browse home first)
                // Don't show if onboarding is not completed
                if (onboardingCompleted.valueOrNull == true &&
                    (authState.valueOrNull?.status == AuthStatus.locked ||
                        authState.valueOrNull?.status == AuthStatus.lockedOut))
                  Positioned.fill(
                    child: _LockScreenOverlay(parentContext: context),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Lock screen overlay widget that properly inherits theme and localizations
class _LockScreenOverlay extends StatelessWidget {
  const _LockScreenOverlay({required this.parentContext});

  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(parentContext);
    final locale = Localizations.localeOf(parentContext);
    final isDark = theme.brightness == Brightness.dark;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const LockScreen(),
    );
  }
}

