// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'examination_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$examinationDataHash() => r'ff237ec1d709a6f84199c805fde135c9b023b496';

/// The commandments and questions of the current content language, with the
/// user's custom sins folded in.
///
/// Deliberately still a Future provider: commandments and questions are bundled
/// content that only changes when the app syncs new assets at startup. The one
/// part that changes while the screen is open — the custom sins — comes from
/// [customSinsGroupedProvider], a Drift stream, so this rebuilds on its own
/// whenever a custom sin is added, edited or deleted.
///
/// Copied from [examinationData].
@ProviderFor(examinationData)
final examinationDataProvider =
    AutoDisposeFutureProvider<List<CommandmentWithQuestions>>.internal(
      examinationData,
      name: r'examinationDataProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$examinationDataHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ExaminationDataRef =
    AutoDisposeFutureProviderRef<List<CommandmentWithQuestions>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
