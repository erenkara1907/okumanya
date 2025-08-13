import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:okumanya/src/resource/styles/app_colors.dart';
import '../shimmer/shimmer.dart';

class CommonScaffold extends StatelessWidget {
  const CommonScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation =
        FloatingActionButtonLocation.centerFloat,
    this.drawer,
    this.backgroundColor,
    this.hideKeyboardWhenTouchOutside = false,
    this.isFullScreen = false,
    this.enableShimmer = false,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final Color? backgroundColor;
  final bool hideKeyboardWhenTouchOutside;
  final bool isFullScreen;
  final bool enableShimmer;

  @override
  Widget build(BuildContext context) {
    Widget bodyWidget;
    
    if (isFullScreen) {
      bodyWidget = SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.defaultAppColor.primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(30.r)),
          ),
          margin: EdgeInsets.only(right: 10.w, left: 10.w),
          child: body,
        ),
      );
    } else {
      bodyWidget = Padding(
        padding: EdgeInsets.only(right: 25.w, left: 25.w, top: 10.h),
        child: SafeArea(
          child: body,
        ),
      );
    }
    
    // Only wrap with Shimmer if explicitly enabled
    if (enableShimmer) {
      bodyWidget = Shimmer(child: bodyWidget);
    }

    final scaffold = Scaffold(
      floatingActionButtonLocation: floatingActionButtonLocation,
      backgroundColor: backgroundColor ?? const Color(0xFF12A4B8),
      body: bodyWidget,
      appBar: appBar,
      drawer: drawer,
      floatingActionButton: floatingActionButton != null
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: floatingActionButton,
            )
          : null,
    );

    return hideKeyboardWhenTouchOutside
        ? GestureDetector(
            onTap: () {
              final currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus?.unfocus();
              }
            },
            child: scaffold,
          )
        : scaffold;
  }
}
