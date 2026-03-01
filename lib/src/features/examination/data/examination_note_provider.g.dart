// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'examination_note_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$examinationNoteControllerHash() =>
    r'c499e1f0978b5aebeaf6fba0cf20240bb8abcf9b';

/// Provider to manage the dismissible examination note state
/// Stores whether the user has permanently dismissed the note
///
/// Copied from [ExaminationNoteController].
@ProviderFor(ExaminationNoteController)
final examinationNoteControllerProvider =
    AutoDisposeAsyncNotifierProvider<ExaminationNoteController, bool>.internal(
      ExaminationNoteController.new,
      name: r'examinationNoteControllerProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$examinationNoteControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ExaminationNoteController = AutoDisposeAsyncNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
