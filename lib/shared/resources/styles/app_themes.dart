import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

final lightTheme = ThemeData.light().copyWith(
  brightness: Brightness.light,
  splashColor: Colors.transparent,
  cardColor: AppColors.defaultAppColor.cardColor.withValues(alpha: 0.2),
  colorScheme: ColorScheme.light(
    primary: AppColors.defaultAppColor.primaryColor,
    secondary: AppColors.defaultAppColor.secondaryColor,
    surface: const Color(0xFFD9D9D9),
    error: AppColors.defaultAppColor.errorColor,
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.defaultAppColor.primaryTextColor,
    ),
    headlineMedium: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.defaultAppColor.primaryTextColor,
    ),
    headlineSmall: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.defaultAppColor.primaryTextColor,
    ),
    bodyLarge: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.defaultAppColor.primaryTextColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.defaultAppColor.primaryTextColor,
    ),
    bodySmall: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.defaultAppColor.primaryTextColor,
    ),
  ),
)..addAppColor(
    AppThemeType.light,
    AppColors.defaultAppColor,
  );

final darkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  splashColor: Colors.transparent,
  cardColor: AppColors.defaultAppColor.cardColor.withValues(alpha: 0.2),
  colorScheme: ColorScheme.dark(
    primary: AppColors.darkThemeColor.primaryColor,
    secondary: AppColors.darkThemeColor.secondaryColor,
    surface: const Color(0xFFFFFFFF),
    error: AppColors.defaultAppColor.errorColor,
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.defaultAppColor.primaryTextColor,
    ),
    headlineMedium: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.defaultAppColor.primaryTextColor,
    ),
    headlineSmall: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: AppColors.defaultAppColor.primaryTextColor,
    ),
    bodyLarge: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: AppColors.defaultAppColor.primaryTextColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.defaultAppColor.primaryTextColor,
    ),
    bodySmall: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.defaultAppColor.primaryTextColor,
    ),
  ),
)..addAppColor(
    AppThemeType.dark,
    AppColors.darkThemeColor,
  );

enum AppThemeType { light, dark }

extension ThemeDataExtensions on ThemeData {
  static final Map<AppThemeType, AppColors> _appColorMap = {};

  void addAppColor(AppThemeType type, AppColors appColor) {
    _appColorMap[type] = appColor;
  }

  AppColors get appColor {
    return _appColorMap[AppThemeSetting.currentAppThemeType] ??
        AppColors.defaultAppColor;
  }
}

class AppThemeSetting {
  const AppThemeSetting._();
  static AppThemeType currentAppThemeType = AppThemeType.light;
}
