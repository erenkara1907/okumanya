import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'localization_state.freezed.dart';

/// States for localization management
@freezed
class LocalizationState with _$LocalizationState {
  /// Initial state
  const factory LocalizationState.initial() = Initial;

  /// Loaded state with current locale
  const factory LocalizationState.loaded({
    required Locale currentLocale,
  }) = Loaded;

  /// Changing locale state
  const factory LocalizationState.changing({
    required Locale newLocale,
  }) = Changing;

  /// Error state
  const factory LocalizationState.error({
    required String message,
    required Locale currentLocale,
  }) = LocalizationError;
}

/// Extension to provide convenient getters for LocalizationState
extension LocalizationStateX on LocalizationState {
  /// Returns the current locale
  Locale get currentLocale => when(
        initial: () => const Locale('tr', 'TR'), // Default locale
        loaded: (locale) => locale,
        changing: (newLocale) => newLocale,
        error: (_, locale) => locale,
      );

  /// Returns true if the state is changing
  bool get isChanging => maybeWhen(
        changing: (newLocale) => true,
        orElse: () => false,
      );

  /// Returns true if the state has an error
  bool get hasError => maybeWhen(
        error: (_, __) => true,
        orElse: () => false,
      );

  /// Returns the error message if available
  String? get errorMessage => maybeWhen(
        error: (message, _) => message,
        orElse: () => null,
      );
}
