import 'package:confessionapp/src/core/localization/l10n/app_localizations.dart';
import 'package:confessionapp/src/core/widgets/gentle_prompt_card.dart';
import 'package:confessionapp/src/features/liturgical/data/liturgical_prompt_provider.dart';
import 'package:confessionapp/src/features/liturgical/domain/liturgical_calendar.dart';
import 'package:confessionapp/src/features/liturgical/domain/liturgical_prompt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// "Lent has begun." / "Christmas is near — prepare your heart."
///
/// Renders nothing at all unless the calendar has something worth saying today
/// (see [liturgicalPromptOn]), and nothing again once the user has dismissed
/// this season or feast.
class LiturgicalCard extends ConsumerWidget {
  const LiturgicalCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prompt = ref.watch(liturgicalPromptProvider);
    if (prompt == null) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context)!;

    // The gap lives with the card, so a silent day collapses to nothing at all
    // rather than leaving a hole in the home column.
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GentlePromptCard(
        icon: _iconFor(prompt),
        title: _titleFor(prompt, l10n),
        body: _bodyFor(prompt, l10n),
        onPrepare: () => context.go('/examine'),
        onDismiss: () => ref
            .read(liturgicalDismissalsProvider.notifier)
            .dismiss(prompt.dismissalKey),
      ),
    );
  }
}

IconData _iconFor(LiturgicalPrompt prompt) {
  return switch (prompt) {
    SeasonPrompt(season: LiturgicalSeason.advent) => Icons.brightness_2_outlined,
    SeasonPrompt() => Icons.eco_outlined,
    FeastPrompt(feast: Feast(id: FeastId.christmas)) => Icons.star_outline,
    FeastPrompt() => Icons.church_outlined,
  };
}

String _titleFor(LiturgicalPrompt prompt, AppLocalizations l10n) {
  return switch (prompt) {
    SeasonPrompt(season: LiturgicalSeason.lent) => l10n.liturgicalLentTitle,
    SeasonPrompt(season: LiturgicalSeason.holyWeek) =>
      l10n.liturgicalHolyWeekTitle,
    SeasonPrompt(season: LiturgicalSeason.advent) => l10n.liturgicalAdventTitle,
    // Only Lent, Holy Week and Advent raise a season prompt; the rest are
    // unreachable, but a season name is a sane thing to fall back to.
    SeasonPrompt(:final season) => seasonName(season, l10n),
    FeastPrompt(:final feast) =>
      l10n.liturgicalFeastNearTitle(feastName(feast.id, l10n)),
  };
}

String _bodyFor(LiturgicalPrompt prompt, AppLocalizations l10n) {
  return switch (prompt) {
    SeasonPrompt(season: LiturgicalSeason.lent) => l10n.liturgicalLentBody,
    SeasonPrompt(season: LiturgicalSeason.holyWeek) =>
      l10n.liturgicalHolyWeekBody,
    SeasonPrompt() => l10n.liturgicalAdventBody,
    FeastPrompt(:final daysUntil) => l10n.liturgicalFeastNearBody(daysUntil),
  };
}

/// The user's-language name of [season].
String seasonName(LiturgicalSeason season, AppLocalizations l10n) {
  return switch (season) {
    LiturgicalSeason.advent => l10n.seasonAdvent,
    LiturgicalSeason.christmas => l10n.seasonChristmas,
    LiturgicalSeason.lent => l10n.seasonLent,
    LiturgicalSeason.holyWeek => l10n.seasonHolyWeek,
    LiturgicalSeason.easter => l10n.seasonEaster,
    LiturgicalSeason.ordinaryTime => l10n.seasonOrdinaryTime,
  };
}

/// The user's-language name of [id].
String feastName(FeastId id, AppLocalizations l10n) {
  return switch (id) {
    FeastId.ashWednesday => l10n.feastAshWednesday,
    FeastId.palmSunday => l10n.feastPalmSunday,
    FeastId.easter => l10n.feastEaster,
    FeastId.pentecost => l10n.feastPentecost,
    FeastId.assumption => l10n.feastAssumption,
    FeastId.allSaints => l10n.feastAllSaints,
    FeastId.immaculateConception => l10n.feastImmaculateConception,
    FeastId.firstSundayOfAdvent => l10n.feastFirstSundayOfAdvent,
    FeastId.christmas => l10n.feastChristmas,
  };
}
