import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'localization_state.dart';

/// Cubit for managing localization state
class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(const LocalizationState.initial());

  /// Available locales in the app
  static const List<Locale> supportedLocales = [
    Locale('tr', 'TR'),
    Locale('en', 'US'),
    Locale('de', 'DE'),
    Locale('fr', 'FR'),
    Locale('es', 'ES'),
  ];

  /// Initialize with current locale
  void initialize(Locale currentLocale) {
    emit(LocalizationState.loaded(currentLocale: currentLocale));
  }

  /// Changes the app locale
  Future<void> changeLocale(BuildContext context, Locale locale) async {
    emit(LocalizationState.changing(newLocale: locale));

    try {
      await context.setLocale(locale);
      emit(LocalizationState.loaded(currentLocale: locale));
    } catch (e) {
      emit(LocalizationState.error(
        message: 'Failed to change language: ${e.toString()}',
        currentLocale: state.currentLocale,
      ));
    }
  }

  /// Gets the display name for a locale
  String getLocaleDisplayName(Locale locale) {
    switch (locale.languageCode) {
      case 'tr':
        return 'Türkçe';
      case 'en':
        return 'English';
      case 'de':
        return 'Deutsch';
      case 'fr':
        return 'Français';
      case 'es':
        return 'Español';
      default:
        return locale.languageCode.toUpperCase();
    }
  }

  /// Gets the flag emoji for a locale
  String getLocaleFlag(Locale locale) {
    switch (locale.countryCode) {
      case 'TR':
        return '🇹🇷';
      case 'US':
        return '🇺🇸';
      case 'DE':
        return '🇩🇪';
      case 'FR':
        return '🇫🇷';
      case 'ES':
        return '🇪🇸';
      default:
        return '🌐';
    }
  }

  /// Checks if a locale is currently selected
  bool isLocaleSelected(Locale locale) {
    return state.currentLocale.languageCode == locale.languageCode;
  }
}
