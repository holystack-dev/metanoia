import 'dart:convert';

import 'package:confessionapp/src/core/constants/app_constants.dart';
import 'package:confessionapp/src/core/localization/content_language_provider.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:flutter/services.dart';
import 'package:confessionapp/src/core/utils/haptic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Model for confession guide content
class ConfessionGuideContent {
  final String title;
  final String subtitle;
  final List<ConfessionGuideSection> sections;
  final ConfessionGuideCallToAction callToAction;

  ConfessionGuideContent({
    required this.title,
    required this.subtitle,
    required this.sections,
    required this.callToAction,
  });

  factory ConfessionGuideContent.fromJson(Map<String, dynamic> json) {
    return ConfessionGuideContent(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      sections: (json['sections'] as List)
          .map((s) => ConfessionGuideSection.fromJson(s as Map<String, dynamic>))
          .toList(),
      callToAction: ConfessionGuideCallToAction.fromJson(
        json['callToAction'] as Map<String, dynamic>,
      ),
    );
  }
}

class ConfessionGuideSection {
  final String id;
  final String title;
  final String icon;
  final String content;

  ConfessionGuideSection({
    required this.id,
    required this.title,
    required this.icon,
    required this.content,
  });

  factory ConfessionGuideSection.fromJson(Map<String, dynamic> json) {
    return ConfessionGuideSection(
      id: json['id'] as String,
      title: json['title'] as String,
      icon: json['icon'] as String,
      content: json['content'] as String,
    );
  }
}

class ConfessionGuideCallToAction {
  final String primary;
  final String secondary;

  ConfessionGuideCallToAction({
    required this.primary,
    required this.secondary,
  });

  factory ConfessionGuideCallToAction.fromJson(Map<String, dynamic> json) {
    return ConfessionGuideCallToAction(
      primary: json['primary'] as String,
      secondary: json['secondary'] as String,
    );
  }
}

/// Provider for confession guide content based on content language
final confessionGuideContentProvider =
    FutureProvider.autoDispose<ConfessionGuideContent>((ref) async {
  final contentLanguage =
      await ref.watch(contentLanguageControllerProvider.future);
  final langKey = LanguageConfig.contentKeyFromLocale(contentLanguage);

  final jsonString = await rootBundle.loadString(
    'assets/data/confession_guide/confession_guide_$langKey.json',
  );
  final json = jsonDecode(jsonString) as Map<String, dynamic>;
  return ConfessionGuideContent.fromJson(json);
});

/// A step-by-step guide screen for making a good confession
class ConfessionGuideScreen extends ConsumerWidget {
  const ConfessionGuideScreen({super.key});

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'assignment_outlined':
        return Icons.assignment_outlined;
      case 'door_front_outlined':
        return Icons.meeting_room_outlined;
      case 'record_voice_over_outlined':
        return Icons.record_voice_over_outlined;
      case 'psychology_outlined':
        return Icons.psychology_outlined;
      case 'favorite_outline':
        return Icons.favorite_outline;
      case 'auto_awesome_outlined':
        return Icons.auto_awesome_outlined;
      case 'celebration_outlined':
        return Icons.celebration_outlined;
      case 'lightbulb_outlined':
        return Icons.lightbulb_outlined;
      case 'church_outlined':
        return Icons.church_outlined;
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final contentAsync = ref.watch(confessionGuideContentProvider);

    return Scaffold(
      body: contentAsync.when(
        data: (content) => _buildContent(context, content, theme, l10n),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('${l10n.error}: $error'),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ConfessionGuideContent content,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    return CustomScrollView(
      slivers: [
        // App Bar
        SliverAppBar(
          floating: false,
          pinned: true,
          elevation: 0,
          scrolledUnderElevation: 1,
          backgroundColor: theme.scaffoldBackgroundColor,
          surfaceTintColor: theme.colorScheme.primary,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: theme.colorScheme.onSurface,
            ),
            onPressed: () {
              HapticUtils.lightImpact();
              context.pop();
            },
          ),
        ),

        // Header section with icon, subtitle, and title
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.church_rounded,
                    size: 48,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  content.subtitle,
                  style: TextStyle(
                    fontFamily: AppTheme.fontFamilyEBGaramond,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),

        // Content sections
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index < content.sections.length) {
                  final section = content.sections[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: _buildSectionCard(context, section, theme, index),
                  );
                } else {
                  // Call to action buttons
                  return _buildCallToAction(
                    context,
                    content.callToAction,
                    theme,
                  );
                }
              },
              childCount: content.sections.length + 1,
            ),
          ),
        ),

        // Bottom padding
        const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
      ],
    );
  }

  Widget _buildSectionCard(
    BuildContext context,
    ConfessionGuideSection section,
    ThemeData theme,
    int index,
  ) {
    return Card(
      elevation: 0,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getIconData(section.icon),
                    size: 24,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    section.title,
                    style: TextStyle(
                      fontFamily: AppTheme.fontFamilyLato,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Content with special formatting
            _buildFormattedContent(section.content, theme),
          ],
        ),
      ),
    ).animate().fadeIn(delay: (100 * index).ms).slideY(begin: 0.05, end: 0);
  }

  Widget _buildFormattedContent(String content, ThemeData theme) {
    final paragraphs = content.split('\n\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: paragraphs.asMap().entries.map((entry) {
        final paragraph = entry.value;
        final isLast = entry.key == paragraphs.length - 1;

        // Check for prayer blocks
        if (paragraph.contains('[PRAYER]')) {
          final prayerText = paragraph
              .replaceAll('[PRAYER]', '')
              .replaceAll('[/PRAYER]', '')
              .trim();
          return Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondaryContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                prayerText,
                style: TextStyle(
                  fontFamily: AppTheme.fontFamilyEBGaramond,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  height: 1.7,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          );
        }

        // Check for liturgical text blocks
        if (paragraph.contains('[LITURGICAL]')) {
          final liturgicalText = paragraph
              .replaceAll('[LITURGICAL]', '')
              .replaceAll('[/LITURGICAL]', '')
              .trim();
          return Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border(
                  left: BorderSide(
                    color: theme.colorScheme.primary,
                    width: 3,
                  ),
                ),
              ),
              child: Text(
                liturgicalText,
                style: TextStyle(
                  fontFamily: AppTheme.fontFamilyEBGaramond,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  height: 1.7,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          );
        }

        // Check if this is a Scripture quote (contains "—" followed by book reference)
        final isScripture =
            paragraph.contains('—') && _looksLikeScripture(paragraph);

        if (isScripture) {
          return Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border(
                  left: BorderSide(
                    color: theme.colorScheme.primary,
                    width: 3,
                  ),
                ),
              ),
              child: Text(
                paragraph,
                style: TextStyle(
                  fontFamily: AppTheme.fontFamilyEBGaramond,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  height: 1.7,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          );
        } else if (paragraph.startsWith('•') || paragraph.contains('\n•')) {
          // Bullet points
          final items = paragraph.split('\n');
          return Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items.map((item) {
                if (item.trim().isEmpty) return const SizedBox.shrink();
                final isBullet = item.trimLeft().startsWith('•');
                if (isBullet) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '• ',
                          style: TextStyle(
                            fontSize: 16,
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            item.replaceFirst('•', '').trim(),
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamilyLato,
                              fontSize: 16,
                              height: 1.6,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  // Non-bullet line in a bullet section
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      item,
                      style: TextStyle(
                        fontFamily: AppTheme.fontFamilyLato,
                        fontSize: 16,
                        height: 1.6,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  );
                }
              }).toList(),
            ),
          );
        } else {
          // Regular paragraph
          return Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
            child: Text(
              paragraph,
              style: TextStyle(
                fontFamily: AppTheme.fontFamilyLato,
                fontSize: 16,
                height: 1.7,
                color: theme.colorScheme.onSurface,
              ),
            ),
          );
        }
      }).toList(),
    );
  }

  bool _looksLikeScripture(String text) {
    // Common Scripture book indicators
    final scripturePatterns = [
      'Luke',
      'Matthew',
      'Mark',
      'John',
      'Romans',
      'Isaiah',
      'Psalm',
      'Genesis',
      'Exodus',
      'Corinthians',
      'James',
      'ലൂക്കാ',
      'മത്തായി',
      'മർക്കോസ്',
      'യോഹന്നാൻ',
      'റോമാ',
      'ഏശയ്യാ',
      'സങ്കീർത്തനം',
      'യാക്കോബ്',
    ];
    return scripturePatterns.any((pattern) => text.contains(pattern));
  }

  Widget _buildCallToAction(
    BuildContext context,
    ConfessionGuideCallToAction cta,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        // Primary button - Begin Examination
        FilledButton.icon(
          onPressed: () {
            HapticUtils.mediumImpact();
            context.go('/examine');
          },
          icon: const Icon(Icons.play_arrow_rounded),
          label: Text(cta.primary),
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(
              fontFamily: AppTheme.fontFamilyLato,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ).animate().fadeIn(delay: 300.ms).scale(begin: const Offset(0.95, 0.95)),

        const SizedBox(height: 12),

        // Secondary button - View Prayers
        OutlinedButton.icon(
          onPressed: () {
            HapticUtils.lightImpact();
            context.push('/guide/prayers');
          },
          icon: const Icon(Icons.auto_stories_outlined),
          label: Text(cta.secondary),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            textStyle: const TextStyle(
              fontFamily: AppTheme.fontFamilyLato,
              fontSize: 15,
            ),
          ),
        ).animate().fadeIn(delay: 400.ms),
      ],
    );
  }
}
