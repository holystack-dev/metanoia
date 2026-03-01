import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/router/navigation_provider.dart';

class ScaffoldWithNavBar extends ConsumerWidget {
  const ScaffoldWithNavBar({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index, WidgetRef ref) {
    // Update the provider with the new tab index
    ref.read(currentTabIndexProvider.notifier).setIndex(index);
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) => _goBranch(index, ref),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: l10n.homeTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.assignment_outlined),
            selectedIcon: const Icon(Icons.assignment),
            label: l10n.examineTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.church_outlined),
            selectedIcon: const Icon(Icons.church),
            label: l10n.confessTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.help_outline),
            selectedIcon: const Icon(Icons.help),
            label: l10n.guideTitle,
          ),
        ],
        backgroundColor: theme.colorScheme.surface,
        elevation: 3,
        shadowColor: Colors.black26,
        indicatorColor: theme.colorScheme.secondaryContainer,
      ),
    );
  }
}
