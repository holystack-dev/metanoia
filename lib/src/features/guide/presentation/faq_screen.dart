import 'package:confessionapp/src/core/constants/content_markers.dart';
import 'package:confessionapp/src/core/constants/app_constants.dart';
import 'package:confessionapp/src/core/localization/content_language_provider.dart';
import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/theme/app_radius.dart';
import 'package:confessionapp/src/core/theme/app_theme.dart';
import 'package:confessionapp/src/core/utils/localized_asset_loader.dart';
import 'package:confessionapp/src/core/widgets/app_back_button.dart';
import 'package:confessionapp/src/core/widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Model for FAQ item
class FaqItem {
  final String heading;
  final String icon;
  final String title;
  final String content;

  FaqItem({
    required this.heading,
    required this.icon,
    required this.title,
    required this.content,
  });

  factory FaqItem.fromJson(Map<String, dynamic> json) {
    return FaqItem(
      heading: json['heading'] as String,
      icon: json['icon'] as String? ?? 'help_outline',
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }
}

/// Provider for FAQ content based on content language
final faqContentProvider = FutureProvider.autoDispose<List<FaqItem>>((
  ref,
) async {
  final contentLanguage = await ref.watch(
    contentLanguageControllerProvider.future,
  );
  final langKey = LanguageConfig.contentKeyFromLocale(contentLanguage);

  final jsonList = await loadLocalizedJsonArray(
    langKey,
    (key) => 'assets/data/faqs/faqs_$key.json',
  );
  return jsonList
      .map((item) => FaqItem.fromJson(item as Map<String, dynamic>))
      .toList();
});

class FaqScreen extends ConsumerWidget {
  const FaqScreen({super.key});

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'favorite_outline':
        return Icons.favorite_outline;
      case 'healing_outlined':
        return Icons.healing_outlined;
      case 'lock_open_outlined':
        return Icons.lock_open_outlined;
      case 'church_outlined':
        return Icons.church_outlined;
      case 'person_outline':
        return Icons.person_outline;
      case 'security_outlined':
        return Icons.security_outlined;
      case 'event_repeat_outlined':
        return Icons.event_repeat_outlined;
      case 'psychology_outlined':
        return Icons.psychology_outlined;
      case 'favorite_border_outlined':
        return Icons.favorite_border_outlined;
      case 'autorenew_outlined':
        return Icons.autorenew_outlined;
      case 'record_voice_over_outlined':
        return Icons.record_voice_over_outlined;
      case 'help_outline':
        return Icons.help_outline;
      case 'groups_outlined':
        return Icons.groups_outlined;
      case 'volunteer_activism_outlined':
        return Icons.volunteer_activism_outlined;
      case 'celebration_outlined':
        return Icons.celebration_outlined;
      case 'spa_outlined':
        return Icons.spa_outlined;
      case 'local_fire_department_outlined':
        return Icons.local_fire_department_outlined;
      case 'quiz_outlined':
        return Icons.quiz_outlined;
      case 'diversity_3_outlined':
        return Icons.diversity_3_outlined;
      case 'balance_outlined':
        return Icons.balance_outlined;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final isDark = theme.brightness == Brightness.dark;
    final contentAsync = ref.watch(faqContentProvider);

    // Use content language for FAQ title
    final contentLanguageAsync = ref.watch(contentLanguageControllerProvider);
    final contentLocale = contentLanguageAsync.valueOrNull;
    final contentL10n =
        contentLocale != null ? lookupAppLocalizations(contentLocale) : l10n;

    return Scaffold(
      body: contentAsync.when(
        data: (faqs) {
          if (faqs.isEmpty) {
            return EmptyState(
              icon: Icons.help_outline,
              title: l10n.noFaqContent,
              subtitle: l10n.noFaqContentDesc,
            ).animate().fadeIn().scale();
          }

          return _buildContent(context, faqs, theme, isDark, contentL10n);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('${l10n.error}: $error')),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    List<FaqItem> faqs,
    ThemeData theme,
    bool isDark,
    AppLocalizations l10n,
  ) {
    // Group FAQs by heading
    final groupedFaqs = <String, List<FaqItem>>{};
    for (final faq in faqs) {
      if (!groupedFaqs.containsKey(faq.heading)) {
        groupedFaqs[faq.heading] = [];
      }
      groupedFaqs[faq.heading]!.add(faq);
    }

    return CustomScrollView(
      slivers: [
        // App Bar
        SliverAppBar(
          floating: false,
          pinned: true,
          scrolledUnderElevation: 1,
          backgroundColor: theme.scaffoldBackgroundColor,
          surfaceTintColor: theme.colorScheme.primary,
          leading: const AppBackButton(fallbackLocation: '/guide'),
        ),

        // Header section
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
                    Icons.menu_book_rounded,
                    size: 48,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.faqSubtitle,
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

        // FAQ sections
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, sectionIndex) {
              final heading = groupedFaqs.keys.elementAt(sectionIndex);
              final sectionFaqs = groupedFaqs[heading]!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section heading
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 16, left: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 24,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(AppRadius.bar),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            heading,
                            style: TextStyle(
                              fontFamily: AppTheme.fontFamilyEBGaramond,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 150.ms),

                  // FAQ cards in this section
                  ...sectionFaqs.asMap().entries.map((entry) {
                    final faq = entry.value;
                    final globalIndex = faqs.indexOf(faq);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildFaqCard(context, faq, theme, globalIndex),
                    );
                  }),

                  // Add spacing between sections
                  if (sectionIndex < groupedFaqs.length - 1)
                    const SizedBox(height: 16),
                ],
              );
            }, childCount: groupedFaqs.length),
          ),
        ),

        // Bottom padding
        const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
      ],
    );
  }

  Widget _buildFaqCard(
    BuildContext context,
    FaqItem faq,
    ThemeData theme,
    int index,
  ) {
    return Card(
      elevation: 0,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.card),
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
                    borderRadius: BorderRadius.circular(AppRadius.tile),
                  ),
                  child: Icon(
                    _getIconData(faq.icon),
                    size: 24,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    faq.title,
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
            _buildFormattedContent(faq.content, theme),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 150.ms);
  }

  Widget _buildFormattedContent(String content, ThemeData theme) {
    final paragraphs = content.split('\n\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          paragraphs.asMap().entries.map((entry) {
            final raw = entry.value;
            final isLast = entry.key == paragraphs.length - 1;

            // Scripture and saint quotes are tagged in the content. The
            // heuristics below are a fallback for untagged Malayalam content
            // and only match English and Malayalam patterns.
            final isMarkedScripture = raw.contains(kScriptureMarker);
            final isMarkedSaint = raw.contains(kSaintMarker);
            final isMarked = isMarkedScripture || isMarkedSaint;

            final paragraph =
                raw
                    .replaceAll(kScriptureMarker, '')
                    .replaceAll(kSaintMarker, '')
                    .trim();

            final isScripture =
                isMarked
                    ? isMarkedScripture
                    : raw.contains('—') && _looksLikeScripture(raw);

            final isSaintQuote =
                isMarked ? isMarkedSaint : _looksLikeSaintQuote(raw);

            if (isScripture) {
              return Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer.withValues(
                      alpha: 0.3,
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.tile),
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
                    color: theme.colorScheme.secondaryContainer.withValues(
                      alpha: 0.3,
                    ),
                    borderRadius: BorderRadius.circular(AppRadius.tile),
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
                  children:
                      items.map((item) {
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
            } else if (_looksLikeNumberedList(paragraph)) {
              // Numbered list (e.g., "1. Begin with...")
              final items = paragraph.split('\n');
              return Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      items.map((item) {
                        if (item.trim().isEmpty) return const SizedBox.shrink();
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
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
      'സങ്കീർത്തനം',
    ];
    return scripturePatterns.any((pattern) => text.contains(pattern));
  }

  bool _looksLikeSaintQuote(String text) {
    // Saint quote patterns
    final saintPatterns = [
      'St.',
      'Saint',
      'വി.',
      'Pope',
      'Thérèse',
      'Augustine',
      'Francis',
      'John Paul',
      'അഗസ്തിനോസ്',
      'ഫ്രാൻസിസ്',
      'ജോൺ പോൾ',
      'കൊച്ചുത്രേസ്യ',
    ];
    return text.contains('"') &&
        saintPatterns.any((pattern) => text.contains(pattern));
  }

  bool _looksLikeNumberedList(String text) {
    return RegExp(r'^\d+\.').hasMatch(text.trim());
  }
}
