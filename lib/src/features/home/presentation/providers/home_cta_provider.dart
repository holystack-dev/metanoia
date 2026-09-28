import 'package:confessionapp/src/features/confession/data/confession_repository.dart';
import 'package:confessionapp/src/features/confession/data/penance_repository.dart';
import 'package:confessionapp/src/features/home/domain/home_cta.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_cta_provider.g.dart';

/// The one call to action the home screen shows.
///
/// Composed from Drift streams, so it stays current without invalidation. The
/// precedence lives in [resolveHomeCta].
///
/// While the streams load, this resolves to the invitation to begin, which
/// never points at an empty screen.
@riverpod
HomeCta homeCta(Ref ref) {
  final draft = ref.watch(activeExaminationDraftProvider).valueOrNull;
  final penances = ref.watch(pendingPenancesProvider).valueOrNull;

  return resolveHomeCta(
    pendingPenanceCount: penances?.length ?? 0,
    draftItemCount: draft?.itemCount ?? 0,
    draftStartedAt: draft?.confession.date,
  );
}
