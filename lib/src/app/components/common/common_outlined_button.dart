import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../resource/styles/app_colors.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    this.title,
    this.backButtonPressed,
    this.backButtonEnable,
    this.action,
  });

  final String? title;
  final void Function()? backButtonPressed;
  final bool? backButtonEnable;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        'assets/images/logo.png',
        height: kToolbarHeight * 0.75,
      ),
      // Text(
      //   title ?? '',
      //   style: Theme.of(context)
      //       .textTheme
      //       .headlineMedium!
      //       .copyWith(color: Colors.black),
      // ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: backButtonEnable == false
          ? const SizedBox.shrink()
          : IconButton(
              onPressed: backButtonPressed ?? () => context.router.canPop(),
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                size: 15.h,
                color: AppColors.defaultAppColor.primaryTextColor,
              ),
            ),
      actions: action != null ? [action!] : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
