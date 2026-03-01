import 'package:confessionapp/src/core/localization/content_language_provider.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class GuideScreen extends ConsumerWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final contentLanguageAsync = ref.watch(contentLanguageControllerProvider);

    // Get content language localization for FAQ
    final contentLocale = contentLanguageAsync.valueOrNull;
    final contentL10n = contentLocale != null
        ? lookupAppLocalizations(contentLocale)
        : l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.guideTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Invitation card for those returning or anxious
          _buildInvitationCard(context, contentL10n, theme),
          const SizedBox(height: 16),
          // How to Make a Good Confession card
          _buildConfessionGuideCard(context, contentL10n, theme),
          const SizedBox(height: 16),
          // FAQ Card with content language
          _buildFaqCard(context, contentL10n, theme),
        ],
      ),
    );
  }

  Widget _buildInvitationCard(BuildContext context, AppLocalizations l10n, ThemeData theme) {
    return Card(
      elevation: 0,
      color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          HapticUtils.lightImpact();
          context.push('/guide/invitation');
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.favorite,
                  size: 24,
                  color: theme.colorScheme.primary,
                  semanticLabel: 'Encouragement',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.invitationTitle,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.invitationSubtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurfaceVariant,
                semanticLabel: 'Navigate',
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.05, end: 0);
  }

  Widget _buildConfessionGuideCard(BuildContext context, AppLocalizations l10n, ThemeData theme) {
    return Card(
      elevation: 0,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          HapticUtils.lightImpact();
          context.push('/guide/confession');
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.church_outlined,
                  size: 24,
                  color: theme.colorScheme.primary,
                  semanticLabel: 'Confession guide',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.confessionGuideTitle,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.confessionGuideSubtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurfaceVariant,
                semanticLabel: 'Navigate',
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.05, end: 0);
  }

  Widget _buildFaqCard(BuildContext context, AppLocalizations l10n, ThemeData theme) {
    return Card(
      elevation: 0,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          HapticUtils.lightImpact();
          context.push('/guide/faq');
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.question_answer,
                  size: 24,
                  color: theme.colorScheme.primary,
                  semanticLabel: 'Frequently asked questions',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.faqTitle,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.faqSubtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurfaceVariant,
                semanticLabel: 'Navigate',
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.05, end: 0);
  }
}
