import 'package:flutter/material.dart';

class BottomNavItemModel {
  final IconData iconData;
  final String label;

  BottomNavItemModel({required this.iconData, required this.label});
}

var bottomTabs = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Trang chủ',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.add_circle),
    label: 'Yêu cầu',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.car_crash_sharp),
    label: 'Workshop',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.chat),
    label: 'Chat',
  ),
];
