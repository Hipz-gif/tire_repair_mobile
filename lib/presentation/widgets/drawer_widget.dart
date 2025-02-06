import 'package:flutter/material.dart';
import 'package:tire_repair_mobile/resources/color.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 40,
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            backgroundColor: ColorsGlobal.themeApp,
          ),
          _buildDrawerItem('Thông tin cá nhân', context),
          _buildDrawerItem('Liên hệ', context),
          _buildDrawerItem('Chính sách bảo mật', context),
          _buildDrawerItem('Đăng xuất', context),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(String title, BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
