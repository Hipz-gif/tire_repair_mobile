// application_index.dart
import 'package:flutter/material.dart';
import 'package:tire_repair_mobile/resources/color.dart';

class ApplicationIndex with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  // Function returns the color of the icon based on the tab index
  Color getColor(int index) {
    return _selectedIndex == index ? ColorsGlobal.themeApp : Colors.grey;
  }

  // Handle when selecting a tab
  void onItemTapped(int index) {
    _selectedIndex = index;
    // Notify the listeners (widgets) that the state has changed
    notifyListeners();
  }
}
