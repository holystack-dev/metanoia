import 'package:confessionapp/src/core/constants/app_constants.dart';

/// The invitation, if any, shown as a card at the bottom of the home screen.
enum SpreadTheWordKind {
  /// Ask for nothing: not yet earned, or snoozed after the user acted on or
  /// dismissed the card.
  none,

  /// Invite the user to share the app. The default ask.
  share,

  /// Invite the user to rate the app, once they have clearly benefited and
  /// have not already handled a rating. Opens the in-app star gate, not the
  /// store.
  rate,
}

/// Resolves which invitation the home screen shows, from the app's own usage.
///
/// 1. Snoozed → [SpreadTheWordKind.none] for [SpreadConfig.snoozeDays] after
///    the card is acted on or dismissed.
/// 2. Not yet earned → [SpreadTheWordKind.none]. Earned means at least one
///    completed confession or [SpreadConfig.minOpensToInvite] app opens.
/// 3. Not yet rated, and confessions have reached
///    [SpreadConfig.confessionsToAskRating] or Examens
///    [SpreadConfig.examensToAskRating] → [SpreadTheWordKind.rate].
/// 4. Otherwise → [SpreadTheWordKind.share].
///
/// Examens count toward the rating ask because confession is too infrequent a
/// signal on its own; a daily user would otherwise wait most of a year.
SpreadTheWordKind resolveSpreadTheWord({
  required int appOpenCount,
  required int completedConfessions,
  required bool ratingHandled,
  required bool snoozed,
}) {
  if (snoozed) return SpreadTheWordKind.none;

  final earned =
      completedConfessions >= 1 || appOpenCount >= SpreadConfig.minOpensToInvite;
  if (!earned) return SpreadTheWordKind.none;

  if (!ratingHandled &&
      completedConfessions >= SpreadConfig.confessionsToAskRating) {
    return SpreadTheWordKind.rate;
  }

  return SpreadTheWordKind.share;
}
