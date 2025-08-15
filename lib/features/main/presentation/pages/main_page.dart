import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/resources/styles/app_colors.dart';
import '../../../../core/widgets/curved_labeled_navigation_bar/curved_navigation_bar.dart';
import '../../../../core/widgets/curved_labeled_navigation_bar/curved_navigation_bar_item.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String role = "";

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomePage(),
      HomePage(),
      HomePage(),
      HomePage(),
      ProfilePage(),
    ];

    Widget buildNavItem(String icon, int index) {
      bool isSelected = _selectedIndex == index;
      return Container(
        height: 60.h,
        padding: isSelected
            ? EdgeInsets.symmetric(
                vertical: 10.h,
                horizontal: 5.w,
              )
            : null,
        decoration: isSelected
            ? BoxDecoration(
                color: AppColors.defaultAppColor.primaryColor,
                borderRadius: BorderRadius.circular(50.r),
              )
            : null,
        child: Image.asset(
          icon,
          height: 24.h,
        ),
      );
    }

    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xFF12A4B8),
        color: Color(0xFF12A4B8),
        height: 85.h,
        index: _selectedIndex,
        animationDuration: AppConstants.mediumAnimation,
        buttonBackgroundColor: AppColors.defaultAppColor.primaryColor,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          CurvedNavigationBarItem(
            child: buildNavItem('assets/images/library.png', 0),
            label: "Kütüphane",
            labelStyle: TextStyle(fontSize: 9.sp, color: Colors.white),
          ),
          CurvedNavigationBarItem(
            child: buildNavItem('assets/images/my-library.png', 1),
            label: "Kitaplığım",
            labelStyle: TextStyle(fontSize: 9.sp, color: Colors.white),
          ),
          CurvedNavigationBarItem(
            child: buildNavItem('assets/images/my-favorites.png', 2),
            label: "Favorilerim",
            labelStyle: TextStyle(fontSize: 9.sp, color: Colors.white),
          ),
          CurvedNavigationBarItem(
            child: buildNavItem('assets/images/responsibility.png', 3),
            label: "Sorumluluklarım",
            labelStyle: TextStyle(fontSize: 9.sp, color: Colors.white),
          ),
          CurvedNavigationBarItem(
            child: buildNavItem('assets/images/profile.png', 4),
            label: "Profilim",
            labelStyle: TextStyle(fontSize: 9.sp, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
