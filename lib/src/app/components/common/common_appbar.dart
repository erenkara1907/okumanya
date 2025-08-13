import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    this.title,
    this.backButtonEnable = false,
    this.backButton,
    this.action,
  });

  final String? title;
  final bool? backButtonEnable;
  final Widget? action;
  final Widget? backButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Image.asset(
        'assets/images/logo.png',
        height: kToolbarHeight * 0.75,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: backButtonEnable != false
          ? backButton
          : Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Image.asset(
                'assets/images/book2.png',
              ),
            ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 20.w),
          child: Row(
            children: [
              Image.asset(
                'assets/images/search-normal.png',
              ),
              SizedBox(width: 20),
              Image.asset(
                'assets/images/notification.png',
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
