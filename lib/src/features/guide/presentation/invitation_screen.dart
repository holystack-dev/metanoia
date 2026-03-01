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

/// Model for invitation content
class InvitationContent {
  final String subtitle;
  final List<InvitationSection> sections;
  final InvitationCallToAction callToAction;

  InvitationContent({
    required this.subtitle,
    required this.sections,
    required this.callToAction,
  });

  factory InvitationContent.fromJson(Map<String, dynamic> json) {
    return InvitationContent(
      subtitle: json['subtitle'] as String,
      sections: (json['sections'] as List)
          .map((s) => InvitationSection.fromJson(s as Map<String, dynamic>))
          .toList(),
      callToAction: InvitationCallToAction.fromJson(
        json['callToAction'] as Map<String, dynamic>,
      ),
    );
  }
}

class InvitationSection {
  final String id;
  final String title;
  final String icon;
  final String content;

  InvitationSection({
    required this.id,
    required this.title,
    required this.icon,
    required this.content,
  });

  factory InvitationSection.fromJson(Map<String, dynamic> json) {
    return InvitationSection(
      id: json['id'] as String,
      title: json['title'] as String,
      icon: json['icon'] as String,
      content: json['content'] as String,
    );
  }
}

class InvitationCallToAction {
  final String primary;
  final String secondary;
  final String tertiary;

  InvitationCallToAction({
    required this.primary,
    required this.secondary,
    required this.tertiary,
  });

  factory InvitationCallToAction.fromJson(Map<String, dynamic> json) {
    return InvitationCallToAction(
      primary: json['primary'] as String,
      secondary: json['secondary'] as String,
      tertiary: json['tertiary'] as String,
    );
  }
}

/// Provider for invitation content based on content language
final invitationContentProvider =
    FutureProvider.autoDispose<InvitationContent>((ref) async {
  final contentLanguage =
      await ref.watch(contentLanguageControllerProvider.future);
  final langKey = LanguageConfig.contentKeyFromLocale(contentLanguage);

  final jsonString = await rootBundle.loadString(
    'assets/data/invitation/invitation_$langKey.json',
  );
  final json = jsonDecode(jsonString) as Map<String, dynamic>;
  return InvitationContent.fromJson(json);
});

/// A spiritually rich invitation screen for those returning to confession
/// after many years or feeling anxious about the sacrament.
class InvitationScreen extends ConsumerWidget {
  const InvitationScreen({super.key});

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'favorite_outline':
        return Icons.favorite_outline;
      case 'home_outlined':
        return Icons.home_outlined;
      case 'healing_outlined':
        return Icons.healing_outlined;
      case 'person_outline':
        return Icons.person_outline;
      case 'psychology_outlined':
        return Icons.psychology_outlined;
      case 'check_circle_outline':
        return Icons.check_circle_outline;
      case 'local_fire_department_outlined':
        return Icons.local_fire_department_outlined;
      default:
        return Icons.light_mode_outlined;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final isDark = theme.brightness == Brightness.dark;
    final contentAsync = ref.watch(invitationContentProvider);

    return Scaffold(
      body: contentAsync.when(
        data: (content) => _buildContent(context, content, theme, isDark, l10n),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('${l10n.error}: $error'),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    InvitationContent content,
    ThemeData theme,
    bool isDark,
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
                      Icons.favorite,
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
    InvitationSection section,
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
            // Content with special formatting for Scripture
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

        // Check if this is a Scripture quote (contains "—" followed by book reference)
        final isScripture =
            paragraph.contains('—') && _looksLikeScripture(paragraph);

        // Check if this is a saint quote (contains quotes and attribution)
        final isSaintQuote =
            paragraph.startsWith('"') && paragraph.contains('"');

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
        } else if (isSaintQuote) {
          return Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color:
                    theme.colorScheme.secondaryContainer.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
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
        } else if (paragraph.startsWith('•')) {
          // Bullet points
          final items = paragraph.split('\n');
          return Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items.map((item) {
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
                          item.replaceFirst('• ', ''),
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
      'ലൂക്കാ',
      'മത്തായി',
      'മർക്കോസ്',
      'യോഹന്നാൻ',
      'റോമാ',
      'ഏശയ്യാ',
    ];
    return scripturePatterns.any((pattern) => text.contains(pattern));
  }

  Widget _buildCallToAction(
    BuildContext context,
    InvitationCallToAction cta,
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

        // Secondary button - Read Guide
        OutlinedButton.icon(
          onPressed: () {
            HapticUtils.lightImpact();
            context.pop(); // Go back to guide
          },
          icon: const Icon(Icons.menu_book_outlined),
          label: Text(cta.secondary),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            textStyle: const TextStyle(
              fontFamily: AppTheme.fontFamilyLato,
              fontSize: 15,
            ),
          ),
        ).animate().fadeIn(delay: 400.ms),

        const SizedBox(height: 8),

        // Tertiary button - View Prayers
        TextButton.icon(
          onPressed: () {
            HapticUtils.lightImpact();
            context.push('/guide/prayers');
          },
          icon: Icon(
            Icons.auto_stories_outlined,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          label: Text(
            cta.tertiary,
            style: TextStyle(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ).animate().fadeIn(delay: 500.ms),
      ],
    );
  }
}
