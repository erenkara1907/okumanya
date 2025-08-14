import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/resources/styles/app_colors.dart';

class CommonElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color? buttonColor;
  final bool? isActive;
  final Widget? widget;
  const CommonElevatedButton({
    super.key,
    this.onPressed,
    required this.text,
    this.buttonColor,
    this.isActive,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0),
        foregroundColor: WidgetStateProperty.all(Colors.black),
        backgroundColor: WidgetStateProperty.all(
          buttonColor != null
              ? isActive == false
                  ? AppColors.defaultAppColor.secondaryTextColor
                  : buttonColor
              : AppColors.defaultAppColor.primaryColor,
        ),
        minimumSize: WidgetStateProperty.all(Size(double.infinity, 50.h)),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
      ),
      onPressed: isActive == false ? null : onPressed,
      child: widget ??
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  fontSize: 18.sp,
                ),
          ),
    );
  }
}

