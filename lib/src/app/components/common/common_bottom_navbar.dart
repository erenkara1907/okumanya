import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:okumanya/src/resource/styles/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      padding: EdgeInsets.only(
        right: 10,
        left: 10,
        bottom: 20,
      ),
      decoration: BoxDecoration(
        color: Color(0xFF12A4B8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.library_books, "Kütüphane", 0),
          _buildNavItem(Icons.collections_bookmark, "Kitaplığım", 1),
          _buildNavItem(Icons.favorite, "Favorilerim", 2),
          _buildNavItem(Icons.task, "Sorumluluklarım", 3),
          _buildNavItem(Icons.person, "Profilim", 4),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onItemTapped(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? AppColors.defaultAppColor.primaryColor
                        : Color(0xFF12A4B8),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.r),
                      bottomRight: Radius.circular(30.r),
                    )),
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Icon(
                  icon,
                  color: selectedIndex == index ? Colors.white : Colors.grey,
                ),
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: selectedIndex == index ? Colors.white : Colors.grey,
                fontSize: 12.sp,
              ),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildProfileIcon(int index) {
  //   return GestureDetector(
  //     onTap: () => onItemTapped(index),
  //     child: CircleAvatar(
  //       radius: 18,
  //       backgroundImage: AssetImage("assets/profile.jpg"),
  //     ),
  //   );
  // }
}
