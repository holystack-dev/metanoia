import 'package:confessionapp/src/core/utils/date_utils.dart';

/// The single thing the home screen asks the user to do next.
enum HomeCtaKind {
  /// Nothing is in flight: invite the user to examine their conscience.
  beginExamination,

  /// An examination draft was started today and has items in it.
  continueExamination,

  /// An examination draft with items was left behind on an earlier day: the
  /// preparation is done, what is left is to go to confession.
  readyToConfess,

  /// A penance was received and has not been completed.
  completePenance,
}

/// What the home screen should ask for next, and the count that goes with it.
///
/// [count] is the number of selected items ([HomeCtaKind.continueExamination],
/// [HomeCtaKind.readyToConfess]) or of pending penances
/// ([HomeCtaKind.completePenance]); it is 0 for [HomeCtaKind.beginExamination].
class HomeCta {
  const HomeCta(this.kind, {this.count = 0});

  final HomeCtaKind kind;
  final int count;

  @override
  bool operator ==(Object other) =>
      other is HomeCta && other.kind == kind && other.count == count;

  @override
  int get hashCode => Object.hash(kind, count);

  @override
  String toString() => 'HomeCta($kind, count: $count)';
}

/// Resolves the one call to action the home screen shows, from the app's live
/// state.
///
/// Precedence, highest first (what the user owes before what they started):
///
/// 1. A pending penance (`pendingPenancesProvider`).
/// 2. An examination draft started on an earlier day: the preparation is done,
///    so point at the confession list rather than back into the questions
///    (`activeExaminationDraftProvider`).
/// 3. An examination draft started today: resume it.
/// 4. Otherwise, begin an examination. A finished confession never produces a
///    call to action; it is shown in the stats row.
///
/// An empty draft (the row the examination screen creates on open) falls
/// through to [HomeCtaKind.beginExamination].
HomeCta resolveHomeCta({
  required int pendingPenanceCount,
  required int draftItemCount,
  DateTime? draftStartedAt,
  DateTime? now,
}) {
  if (pendingPenanceCount > 0) {
    return HomeCta(HomeCtaKind.completePenance, count: pendingPenanceCount);
  }

  if (draftItemCount > 0) {
    final startedOnAnEarlierDay =
        draftStartedAt != null &&
        startOfDay(draftStartedAt).isBefore(startOfDay(now ?? DateTime.now()));

    return HomeCta(
      startedOnAnEarlierDay
          ? HomeCtaKind.readyToConfess
          : HomeCtaKind.continueExamination,
      count: draftItemCount,
    );
  }

  return const HomeCta(HomeCtaKind.beginExamination);
}
