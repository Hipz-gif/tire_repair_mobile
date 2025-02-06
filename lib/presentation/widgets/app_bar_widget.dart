import 'package:flutter/material.dart';
import 'package:tire_repair_mobile/resources/color.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            bottom: MediaQuery.of(context).padding.bottom),
        child: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height * 0.1,
        ),
      ),
      backgroundColor: ColorsGlobal.themeApp,
      leading: IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
