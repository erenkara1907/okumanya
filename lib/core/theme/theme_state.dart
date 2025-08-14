import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_state.freezed.dart';

/// States for theme management
@freezed
class ThemeState with _$ThemeState {
  /// Initial state (follows system theme)
  const factory ThemeState.initial() = Initial;
  
  /// Light theme state
  const factory ThemeState.light() = Light;
  
  /// Dark theme state
  const factory ThemeState.dark() = Dark;
}