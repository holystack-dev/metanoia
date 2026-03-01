import 'package:flutter/material.dart';
import 'package:confessionapp/src/core/services/reminder_service.dart';

class NotificationPermissionPage extends StatelessWidget {
  final VoidCallback onComplete;

  const NotificationPermissionPage({super.key, required this.onComplete});

  Future<void> _requestPermission(BuildContext context) async {
    final reminderService = ReminderService();
    await reminderService.initialize();
    await reminderService.requestPermissions();
    onComplete();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),

            // Icon
            Icon(
              Icons.notifications_active_outlined,
              size: 100,
              color: theme.colorScheme.primary,
            ),

            const SizedBox(height: 40),

            // Title
            Text(
              'Stay on Track',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            // Description
            Text(
              'Enable notifications to receive reminders for regular confession',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // Features List
            const _FeatureItem(
              icon: Icons.schedule,
              title: 'Customizable Frequency',
              description: 'Weekly, bi-weekly, monthly, or quarterly reminders',
            ),
            const SizedBox(height: 16),
            const _FeatureItem(
              icon: Icons.calendar_today,
              title: 'Choose Your Day & Time',
              description: 'Pick the day of week and exact time for reminders',
            ),
            const SizedBox(height: 16),
            const _FeatureItem(
              icon: Icons.alarm,
              title: 'Advance Notice',
              description: 'Get reminded 1-7 days before confession day',
            ),

            const SizedBox(height: 32),

            Text(
              'You can configure all reminder details in Settings',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            // Enable Button
            FilledButton(
              onPressed: () => _requestPermission(context),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text('Enable Notifications'),
            ),

            const SizedBox(height: 12),

            // Skip Button
            TextButton(
              onPressed: onComplete,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Skip for Now'),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: theme.colorScheme.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
