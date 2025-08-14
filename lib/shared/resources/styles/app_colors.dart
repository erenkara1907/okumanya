import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_themes.dart';

class AppColors {
  const AppColors({
    required this.primaryColor,
    required this.secondaryColor,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.primaryGradient,
    required this.cardColor,
    required this.errorColor,
    required this.boxShadow,
  });

  static late AppColors current;

  final Color primaryColor;
  final Color secondaryColor;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final LinearGradient primaryGradient;
  final Color cardColor;
  final Color errorColor;
  final BoxShadow boxShadow;

  static final defaultAppColor = AppColors(
    primaryColor: const Color(0xFF042C71),
    secondaryColor: const Color(0xFF12A4B8),
    primaryTextColor: Colors.white,
    secondaryTextColor: const Color(0xFF7C849A),
    primaryGradient: const LinearGradient(colors: [Color(0xFFFFFFFF), Color(0xFFFE6C30)]),
    cardColor: const Color(0xFFE0E2E7),
    errorColor: const Color(0xFFFF6260),
    boxShadow: BoxShadow(
      color: const Color(0xFF000000).withValues(alpha: 0.15),
      offset: Offset(0, 4.h),
      blurRadius: 25.r,
      spreadRadius: 0,
    ),
  );

  static final darkThemeColor = AppColors(
    primaryColor: const Color(0xFF042C71),
    secondaryColor: const Color(0xFF12A4B8),
    primaryTextColor: Colors.white,
    secondaryTextColor: const Color(0xFF7C849A),
    primaryGradient: const LinearGradient(colors: [Color(0xFFFFFFFF), Color(0xFFFE6C30)]),
    cardColor: const Color(0xFFE0E2E7),
    errorColor: const Color(0xFFFF6260),
    boxShadow: BoxShadow(
      color: const Color(0xFF000000).withValues(alpha: 0.15),
      offset: Offset(0, 4.h),
      blurRadius: 25.r,
      spreadRadius: 0,
    ),
  );

  static AppColors of(BuildContext context) {
    final appColor = Theme.of(context).appColor;

    current = appColor;

    return current;
  }

  AppColors copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? primaryTextColor,
    Color? secondaryTextColor,
    LinearGradient? primaryGradient,
    Color? cardColor,
    Color? errorColor,
    BoxShadow? boxShadow,
  }) {
    return AppColors(
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      primaryTextColor: primaryTextColor ?? this.primaryTextColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      primaryGradient: primaryGradient ?? this.primaryGradient,
      cardColor: cardColor ?? this.cardColor,
      errorColor: errorColor ?? this.errorColor,
      boxShadow: boxShadow ?? this.boxShadow,
    );
  }
}
