import 'package:flutter/material.dart';
import 'package:tire_repair_mobile/resources/color.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor:
          ColorsGlobal.globalBlack, // Màu của label khi được chọn
      unselectedItemColor:
          ColorsGlobal.globalBlack, // Màu của label khi không được chọn
      showSelectedLabels: true, // Hiển thị label khi được chọn
      showUnselectedLabels: true, // Hiển thị label khi không được chọn
      type: BottomNavigationBarType.fixed, // Tắt animation focus
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: ColorsGlobal.globalBlack,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.request_page,
            color: ColorsGlobal.globalBlack,
          ),
          label: 'Request',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            color: ColorsGlobal.globalBlack,
          ),
          label: 'Workshop',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.chat,
            color: ColorsGlobal.globalBlack,
          ),
          label: 'Chat',
        ),
      ],
    );
  }
}
