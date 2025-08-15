import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme_state.dart';

/// Cubit for managing theme state
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState.initial());

  /// Toggles between light and dark theme
  void toggleTheme() {
    state.when(
      initial: () => emit(const ThemeState.light()),
      light: () => emit(const ThemeState.dark()),
      dark: () => emit(const ThemeState.light()),
    );
  }

  /// Sets the theme to light mode
  void setLightTheme() {
    emit(const ThemeState.light());
  }

  /// Sets the theme to dark mode
  void setDarkTheme() {
    emit(const ThemeState.dark());
  }

  /// Sets theme based on system preference
  void setSystemTheme(Brightness systemBrightness) {
    if (systemBrightness == Brightness.dark) {
      emit(const ThemeState.dark());
    } else {
      emit(const ThemeState.light());
    }
  }

  /// Gets the current theme mode
  ThemeMode get themeMode {
    return state.when(
      initial: () => ThemeMode.system,
      light: () => ThemeMode.light,
      dark: () => ThemeMode.dark,
    );
  }

  /// Checks if current theme is dark
  bool get isDarkMode {
    return state.when(
      initial: () => false,
      light: () => false,
      dark: () => true,
    );
  }
}
