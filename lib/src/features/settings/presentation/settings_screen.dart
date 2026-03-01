import 'package:confessionapp/src/core/constants/app_constants.dart';
import 'package:confessionapp/src/core/services/package_info_service.dart';
import 'package:confessionapp/src/core/localization/language_provider.dart';
import 'package:confessionapp/src/core/localization/content_language_provider.dart';
import 'package:confessionapp/src/core/services/in_app_review_service.dart';
import 'package:confessionapp/src/core/services/reminder_service.dart';
import 'package:confessionapp/src/core/theme/theme_provider.dart';
import 'package:confessionapp/src/core/theme/font_size_provider.dart';
import 'package:confessionapp/src/core/tutorial/tutorial_controller.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

part 'settings_screen.g.dart';

@riverpod
class KeepHistorySettings extends _$KeepHistorySettings {
  @override
  Future<bool> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('keep_confession_history') ?? false;
  }

  Future<void> toggle(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('keep_confession_history', value);
    state = AsyncValue.data(value);
  }
}

enum ExaminationModePreference { askEveryTime, quickReview, deepReflection }

@riverpod
class ExaminationModeSettings extends _$ExaminationModeSettings {
  static const String _key = 'examination_mode_preference';

  @override
  Future<ExaminationModePreference> build() async {
    final prefs = await SharedPreferences.getInstance();
    final savedValue = prefs.getString(_key);
    if (savedValue == null) return ExaminationModePreference.askEveryTime;
    return ExaminationModePreference.values.firstWhere(
      (e) => e.name == savedValue,
      orElse: () => ExaminationModePreference.askEveryTime,
    );
  }

  Future<void> setMode(ExaminationModePreference mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, mode.name);
    state = AsyncValue.data(mode);
  }
}

enum ReminderFrequency { none, weekly, biweekly, monthly, quarterly }

@riverpod
class ReminderSettings extends _$ReminderSettings {
  @override
  Future<ReminderConfig> build() async {
    final prefs = await SharedPreferences.getInstance();
    final config = ReminderConfig(
      frequency: ReminderFrequency.values.firstWhere(
        (e) => e.name == (prefs.getString('reminder_frequency') ?? 'none'),
        orElse: () => ReminderFrequency.none,
      ),
      weekday: prefs.getInt('reminder_weekday') ?? DateTime.saturday,
      hour: prefs.getInt('reminder_hour') ?? 9,
      minute: prefs.getInt('reminder_minute') ?? 0,
      advanceDays: prefs.getInt('reminder_advance_days') ?? 0,
    );

    // On app startup, refresh notifications if running low
    if (config.frequency != ReminderFrequency.none) {
      final reminderService = ReminderService();
      await reminderService.initialize();
      await reminderService.refreshIfNeeded(
        weekday: config.weekday,
        hour: config.hour,
        minute: config.minute,
        advanceDays: config.advanceDays,
        isBiweekly: config.frequency == ReminderFrequency.biweekly,
        isMonthly: config.frequency == ReminderFrequency.monthly,
        isQuarterly: config.frequency == ReminderFrequency.quarterly,
      );
    }

    return config;
  }

  Future<void> updateConfig(ReminderConfig config) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('reminder_frequency', config.frequency.name);
    await prefs.setInt('reminder_weekday', config.weekday);
    await prefs.setInt('reminder_hour', config.hour);
    await prefs.setInt('reminder_minute', config.minute);
    await prefs.setInt('reminder_advance_days', config.advanceDays);

    state = AsyncValue.data(config);

    final reminderService = ReminderService();
    await reminderService.initialize();

    if (config.frequency == ReminderFrequency.none) {
      await reminderService.cancelAllReminders();
    } else {
      await reminderService.requestPermissions();
      await reminderService.scheduleReminder(
        weekday: config.weekday,
        hour: config.hour,
        minute: config.minute,
        advanceDays: config.advanceDays,
        isBiweekly: config.frequency == ReminderFrequency.biweekly,
        isMonthly: config.frequency == ReminderFrequency.monthly,
        isQuarterly: config.frequency == ReminderFrequency.quarterly,
      );
    }
  }
}

class ReminderConfig {
  final ReminderFrequency frequency;
  final int weekday;
  final int hour;
  final int minute;
  final int advanceDays;

  ReminderConfig({
    required this.frequency,
    required this.weekday,
    required this.hour,
    required this.minute,
    required this.advanceDays,
  });

  ReminderConfig copyWith({
    ReminderFrequency? frequency,
    int? weekday,
    int? hour,
    int? minute,
    int? advanceDays,
  }) {
    return ReminderConfig(
      frequency: frequency ?? this.frequency,
      weekday: weekday ?? this.weekday,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      advanceDays: advanceDays ?? this.advanceDays,
    );
  }
}

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final GlobalKey _remindersKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = GoRouterState.of(context);
      if (state.uri.queryParameters['scrollTo'] == 'reminders') {
        final reminderContext = _remindersKey.currentContext;
        if (reminderContext != null) {
          Scrollable.ensureVisible(
            reminderContext,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeModeControllerProvider);
    final fontSizeScale = ref.watch(fontSizeControllerProvider);
    final reminderConfig = ref.watch(reminderSettingsProvider);
    final languageState = ref.watch(languageControllerProvider);
    final keepHistory = ref.watch(keepHistorySettingsProvider);
    final examinationMode = ref.watch(examinationModeSettingsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
        title: Text(l10n.settingsTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Language settings
          _LanguagePickerCard(
            title: l10n.appLanguage,
            subtitle: l10n.appLanguageSubtitle,
            icon: Icons.language,
            selectedLabel: languageState.when(
              data: (locale) {
                if (locale == null) return l10n.system;
                final key = LanguageConfig.contentKeyFromLocale(locale);
                return LanguageConfig.supportedContentLanguages[key] ??
                    key;
              },
              loading: () => '...',
              error: (_, __) => l10n.error,
            ),
            onTap: () => _showAppLanguagePicker(context, ref, l10n),
          ),
          const SizedBox(height: 16),
          _LanguagePickerCard(
            title: l10n.contentLanguage,
            subtitle: l10n.contentLanguageSubtitle,
            icon: Icons.menu_book,
            selectedLabel: ref.watch(contentLanguageControllerProvider).when(
                  data: (contentLanguage) {
                    final key = LanguageConfig.contentKeyFromLocale(contentLanguage);
                    return LanguageConfig.supportedContentLanguages[key] ?? key;
                  },
                  loading: () => '...',
                  error: (_, __) => l10n.error,
                ),
            onTap: () => _showContentLanguagePicker(context, ref),
          ),
          const SizedBox(height: 16),
          // Appearance settings
          _SettingsCard(
            title: l10n.theme,
            subtitle: l10n.chooseTheme,
            icon:
                themeMode == ThemeMode.light
                    ? Icons.light_mode
                    : themeMode == ThemeMode.dark
                    ? Icons.dark_mode
                    : Icons.brightness_auto,
            child: SegmentedButton<ThemeMode>(
              segments: [
                ButtonSegment(
                  value: ThemeMode.system,
                  label: Text(l10n.system),
                  icon: const Icon(Icons.brightness_auto),
                ),
                ButtonSegment(
                  value: ThemeMode.light,
                  label: Text(l10n.light),
                  icon: const Icon(Icons.light_mode),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  label: Text(l10n.dark),
                  icon: const Icon(Icons.dark_mode),
                ),
              ],
              selected: {themeMode},
              onSelectionChanged: (Set<ThemeMode> newSelection) {
                HapticUtils.selectionClick();
                ref
                    .read(themeModeControllerProvider.notifier)
                    .setTheme(newSelection.first);
              },
            ),
          ),
          const SizedBox(height: 16),
          _SettingsCard(
            title: l10n.fontSize,
            subtitle: l10n.fontSizeSubtitle,
            icon: Icons.text_fields,
            child: _FontSizeSelector(
              currentScale: fontSizeScale,
              onChanged: (scale) {
                HapticUtils.selectionClick();
                ref
                    .read(fontSizeControllerProvider.notifier)
                    .setFontSize(scale);
              },
              l10n: l10n,
            ),
          ),
          const SizedBox(height: 16),
          _SettingsCard(
            title: l10n.examinationModeSettingTitle,
            subtitle: l10n.examinationModeSettingSubtitle,
            icon: Icons.checklist_rounded,
            child: examinationMode.when(
              data: (mode) => _ExaminationModeSelector(
                currentMode: mode,
                onChanged: (newMode) {
                  HapticUtils.selectionClick();
                  ref
                      .read(examinationModeSettingsProvider.notifier)
                      .setMode(newMode);
                },
                l10n: l10n,
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => Text(l10n.error),
            ),
          ),
          const SizedBox(height: 16),
          // Reminders
          _SettingsCard(
            key: _remindersKey,
            title: l10n.reminders,
            subtitle: l10n.getReminded,
            icon: Icons.notifications_outlined,
            child: reminderConfig.when(
              data: (config) {
                final isEnabled = config.frequency != ReminderFrequency.none;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            l10n.enableReminders,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        Switch(
                          value: isEnabled,
                          onChanged: (value) {
                            HapticUtils.selectionClick();
                            if (value) {
                              // Default to Weekly if turning on
                              ref
                                  .read(reminderSettingsProvider.notifier)
                                  .updateConfig(
                                    config.copyWith(
                                      frequency: ReminderFrequency.weekly,
                                    ),
                                  );
                            } else {
                              ref
                                  .read(reminderSettingsProvider.notifier)
                                  .updateConfig(
                                    config.copyWith(
                                      frequency: ReminderFrequency.none,
                                    ),
                                  );
                            }
                          },
                        ),
                      ],
                    ),
                    if (isEnabled) ...[
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final frequency in [
                            (ReminderFrequency.weekly, l10n.weekly),
                            (ReminderFrequency.biweekly, l10n.biweekly),
                            (ReminderFrequency.monthly, l10n.monthly),
                            (ReminderFrequency.quarterly, l10n.quarterly),
                          ])
                            _FrequencyChip(
                              label: frequency.$2,
                              isSelected: config.frequency == frequency.$1,
                              onSelected: (selected) {
                                if (selected) {
                                  ref
                                      .read(reminderSettingsProvider.notifier)
                                      .updateConfig(
                                        config.copyWith(
                                          frequency: frequency.$1,
                                        ),
                                      );
                                }
                              },
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _ConfigTile(
                              label: l10n.day,
                              value: _getDayName(context, config.weekday),
                              onTap: () => _showDayPicker(context, ref, config),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _ConfigTile(
                              label: l10n.time,
                              value: _formatTime(
                                context,
                                config.hour,
                                config.minute,
                              ),
                              onTap:
                                  () => _showTimePicker(context, ref, config),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _ConfigTile(
                        label: l10n.remindMe,
                        value:
                            config.advanceDays == 0
                                ? l10n.onTheDay
                                : l10n.daysBefore(config.advanceDays),
                        onTap: () => _showAdvancePicker(context, ref, config),
                      ),
                    ],
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => Text(l10n.error),
            ),
          ),
          const SizedBox(height: 16),
          // Privacy & Security
          _SettingsCard(
            title: l10n.keepHistory,
            subtitle: l10n.keepHistorySubtitle,
            icon: Icons.history,
            child: keepHistory.when(
              data:
                  (value) => Align(
                    alignment: Alignment.centerLeft,
                    child: Switch(
                      value: value,
                      onChanged: (newValue) {
                        HapticUtils.selectionClick();
                        ref
                            .read(keepHistorySettingsProvider.notifier)
                            .toggle(newValue);
                      },
                    ),
                  ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => Text(l10n.error),
            ),
          ),
          const SizedBox(height: 16),
          _SettingsCard(
            title: l10n.security,
            subtitle: l10n.securitySubtitle,
            icon: Icons.security_rounded,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l10n.pinAndBiometric),
              subtitle: Text(l10n.pinAndBiometricSubtitle),
              leading: const Icon(Icons.lock_outline_rounded),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                HapticUtils.lightImpact();
                context.push('/settings/security');
              },
            ),
          ),
          const SizedBox(height: 16),
          // Help & About
          _SettingsCard(
            title: l10n.replayTutorial,
            subtitle: l10n.replayTutorialDesc,
            icon: Icons.school_outlined,
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  HapticUtils.lightImpact();
                  await ref
                      .read(tutorialControllerProvider.notifier)
                      .resetTutorials();
                  if (context.mounted) {
                    // Navigate to home and force rebuild by using replace
                    context.go('/?tutorial_reset=true');
                  }
                },
                icon: const Icon(Icons.replay),
                label: Text(l10n.replayTutorial),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _SettingsCard(
            title: l10n.about,
            subtitle: l10n.aboutSubtitle,
            icon: Icons.info_outline,
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.rateApp),
                  subtitle: Text(l10n.rateAppSubtitle),
                  leading: const Icon(Icons.star_rate),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () async {
                    HapticUtils.lightImpact();
                    final reviewService = InAppReviewService();
                    await reviewService.openStoreListing();
                  },
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.shareApp),
                  subtitle: Text(l10n.shareAppSubtitle),
                  leading: const Icon(Icons.share),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    HapticUtils.lightImpact();
                    Share.share(AppUrls.shareMessage);
                  },
                ),
                const Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.about),
                  subtitle: Text(l10n.aboutSubtitle),
                  leading: const Icon(Icons.info),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.go('/settings/about'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Center(
            child: ref
                .watch(packageInfoProvider)
                .when(
                  data:
                      (info) => Text(
                        '${l10n.version} ${info.version} (${info.buildNumber})',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                  loading:
                      () => Text(
                        l10n.version,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                  error: (_, __) => const SizedBox.shrink(),
                ),
          ),
        ],
      ),
    );
  }

  String _getDayName(BuildContext context, int weekday) {
    final l10n = AppLocalizations.of(context)!;
    final days = [
      l10n.monday,
      l10n.tuesday,
      l10n.wednesday,
      l10n.thursday,
      l10n.friday,
      l10n.saturday,
      l10n.sunday,
    ];
    return days[weekday - 1];
  }

  String _formatTime(BuildContext context, int hour, int minute) {
    final use24Hour = MediaQuery.of(context).alwaysUse24HourFormat;
    final m = minute.toString().padLeft(2, '0');

    if (use24Hour) {
      final h = hour.toString().padLeft(2, '0');
      return '$h:$m';
    } else {
      final period = hour >= 12 ? 'PM' : 'AM';
      final h = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
      return '$h:$m $period';
    }
  }

  Future<void> _showDayPicker(
    BuildContext context,
    WidgetRef ref,
    ReminderConfig config,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: theme.colorScheme.surface,
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              l10n.selectDay,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children:
                  [1, 2, 3, 4, 5, 6, 7].map((day) {
                    final isSelected = config.weekday == day;
                    return ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      tileColor:
                          isSelected
                              ? theme.colorScheme.primaryContainer.withValues(
                                alpha: 0.5,
                              )
                              : null,
                      title: Text(
                        _getDayName(context, day),
                        style: TextStyle(
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? theme.colorScheme.primary : null,
                        ),
                      ),
                      trailing:
                          isSelected
                              ? Icon(
                                Icons.check,
                                color: theme.colorScheme.primary,
                              )
                              : null,
                      onTap: () {
                        ref
                            .read(reminderSettingsProvider.notifier)
                            .updateConfig(config.copyWith(weekday: day));
                        Navigator.pop(context);
                      },
                    );
                  }).toList(),
            ),
          ),
    );
  }

  Future<void> _showTimePicker(
    BuildContext context,
    WidgetRef ref,
    ReminderConfig config,
  ) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: config.hour, minute: config.minute),
    );
    if (time != null) {
      ref
          .read(reminderSettingsProvider.notifier)
          .updateConfig(config.copyWith(hour: time.hour, minute: time.minute));
    }
  }

  Future<void> _showAdvancePicker(
    BuildContext context,
    WidgetRef ref,
    ReminderConfig config,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final advanceOptions = [0, 1, 2, 3, 4, 7];

    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: theme.colorScheme.surface,
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              l10n.remindMe,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children:
                  advanceOptions.map((days) {
                    final isSelected = config.advanceDays == days;
                    return ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      tileColor:
                          isSelected
                              ? theme.colorScheme.primaryContainer.withValues(
                                alpha: 0.5,
                              )
                              : null,
                      title: Text(
                        days == 0 ? l10n.onTheDay : l10n.daysBefore(days),
                        style: TextStyle(
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? theme.colorScheme.primary : null,
                        ),
                      ),
                      trailing:
                          isSelected
                              ? Icon(
                                Icons.check,
                                color: theme.colorScheme.primary,
                              )
                              : null,
                      onTap: () {
                        ref
                            .read(reminderSettingsProvider.notifier)
                            .updateConfig(config.copyWith(advanceDays: days));
                        Navigator.pop(context);
                      },
                    );
                  }).toList(),
            ),
          ),
    );
  }
}

class _ConfigTile extends StatelessWidget {
  const _ConfigTile({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: Theme.of(context).colorScheme.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            const SizedBox(height: 16),
            SizedBox(width: double.infinity, child: child),
          ],
        ),
      ),
    );
  }
}

class _FrequencyChip extends StatelessWidget {
  const _FrequencyChip({
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  final String label;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: onSelected,
      showCheckmark: false,
      labelStyle: TextStyle(
        color:
            isSelected
                ? Theme.of(context).colorScheme.onPrimaryContainer
                : Theme.of(context).colorScheme.onSurfaceVariant,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      selectedColor: Theme.of(context).colorScheme.primaryContainer,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      side: BorderSide(
        color:
            isSelected
                ? Colors.transparent
                : Theme.of(context).colorScheme.outlineVariant,
      ),
    );
  }
}

class _FontSizeSelector extends StatelessWidget {
  const _FontSizeSelector({
    required this.currentScale,
    required this.onChanged,
    required this.l10n,
  });

  final FontSizeScale currentScale;
  final ValueChanged<FontSizeScale> onChanged;
  final AppLocalizations l10n;

  String _getLabel(FontSizeScale scale) {
    switch (scale) {
      case FontSizeScale.small:
        return l10n.fontSizeSmall;
      case FontSizeScale.medium:
        return l10n.fontSizeMedium;
      case FontSizeScale.large:
        return l10n.fontSizeLarge;
      case FontSizeScale.extraLarge:
        return l10n.fontSizeExtraLarge;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Font size options
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              FontSizeScale.values.map((scale) {
                final isSelected = currentScale == scale;
                return ChoiceChip(
                  label: Text(_getLabel(scale)),
                  selected: isSelected,
                  onSelected: (_) => onChanged(scale),
                  showCheckmark: false,
                  labelStyle: TextStyle(
                    color:
                        isSelected
                            ? theme.colorScheme.onSecondaryContainer
                            : theme.colorScheme.onSurfaceVariant,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  selectedColor: theme.colorScheme.secondaryContainer,
                  backgroundColor: theme.colorScheme.surfaceContainerLow,
                  side: BorderSide(
                    color:
                        isSelected
                            ? Colors.transparent
                            : theme.colorScheme.outlineVariant,
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}

class _LanguagePickerCard extends StatelessWidget {
  const _LanguagePickerCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selectedLabel,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String selectedLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.outlineVariant, width: 0.5),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: theme.colorScheme.primary, size: 20),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      selectedLabel,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSecondaryContainer,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Icon(
                      Icons.arrow_drop_down,
                      color: theme.colorScheme.onSecondaryContainer,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showAppLanguagePicker(
  BuildContext context,
  WidgetRef ref,
  AppLocalizations l10n,
) {
  final theme = Theme.of(context);
  final languages = LanguageConfig.supportedContentLanguages.entries.toList();
  final currentLocale = ref.read(languageControllerProvider).value;

  showModalBottomSheet(
    context: context,
    backgroundColor: theme.colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.appLanguage,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  _LanguageOptionTile(
                    label: l10n.system,
                    subtitle: l10n.appLanguageSubtitle,
                    isSelected: currentLocale == null,
                    onTap: () {
                      HapticUtils.selectionClick();
                      ref
                          .read(languageControllerProvider.notifier)
                          .setLanguage(null);
                      Navigator.pop(context);
                    },
                  ),
                  for (final lang in languages)
                    _LanguageOptionTile(
                      label: lang.value,
                      isSelected: currentLocale != null &&
                          LanguageConfig.contentKeyFromLocale(currentLocale) == lang.key,
                      onTap: () {
                        HapticUtils.selectionClick();
                        ref
                            .read(languageControllerProvider.notifier)
                            .setLanguage(LanguageConfig.localeFromContentKey(lang.key));
                        Navigator.pop(context);
                      },
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    },
  );
}

void _showContentLanguagePicker(BuildContext context, WidgetRef ref) {
  final theme = Theme.of(context);
  final l10n = AppLocalizations.of(context)!;
  final languages = LanguageConfig.supportedContentLanguages.entries.toList();
  final currentLocale = ref.read(contentLanguageControllerProvider).value;

  showModalBottomSheet(
    context: context,
    backgroundColor: theme.colorScheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.contentLanguage,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  for (final lang in languages)
                    _LanguageOptionTile(
                      label: lang.value,
                      isSelected: currentLocale != null &&
                          LanguageConfig.contentKeyFromLocale(currentLocale) == lang.key,
                      onTap: () {
                        HapticUtils.selectionClick();
                        ref
                            .read(contentLanguageControllerProvider.notifier)
                            .setLanguage(LanguageConfig.localeFromContentKey(lang.key));
                        Navigator.pop(context);
                      },
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    },
  );
}

class _LanguageOptionTile extends StatelessWidget {
  const _LanguageOptionTile({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.subtitle,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: isSelected
            ? theme.colorScheme.primaryContainer.withValues(alpha: 0.5)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: isSelected
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurface,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_rounded,
                    color: theme.colorScheme.primary,
                    size: 22,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ExaminationModeSelector extends StatelessWidget {
  const _ExaminationModeSelector({
    required this.currentMode,
    required this.onChanged,
    required this.l10n,
  });

  final ExaminationModePreference currentMode;
  final ValueChanged<ExaminationModePreference> onChanged;
  final AppLocalizations l10n;

  String _getLabel(ExaminationModePreference mode) {
    switch (mode) {
      case ExaminationModePreference.askEveryTime:
        return l10n.askEveryTime;
      case ExaminationModePreference.quickReview:
        return l10n.quickReviewMode;
      case ExaminationModePreference.deepReflection:
        return l10n.deepReflectionMode;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: ExaminationModePreference.values.map((mode) {
        final isSelected = currentMode == mode;
        return ChoiceChip(
          label: Text(_getLabel(mode)),
          selected: isSelected,
          onSelected: (_) => onChanged(mode),
          showCheckmark: false,
          labelStyle: TextStyle(
            color: isSelected
                ? theme.colorScheme.onSecondaryContainer
                : theme.colorScheme.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
          selectedColor: theme.colorScheme.secondaryContainer,
          backgroundColor: theme.colorScheme.surfaceContainerLow,
          side: BorderSide(
            color: isSelected
                ? Colors.transparent
                : theme.colorScheme.outlineVariant,
          ),
        );
      }).toList(),
    );
  }
}
