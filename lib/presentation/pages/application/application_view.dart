import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tire_repair_mobile/data/models/application_model.dart';
import 'package:tire_repair_mobile/presentation/pages/application/application_index.dart';
import 'package:tire_repair_mobile/presentation/pages/application/page_builder.dart';
import 'package:tire_repair_mobile/resources/color.dart';
import 'package:tire_repair_mobile/resources/responsive.dart';

class ApplicationView extends StatefulWidget {
  const ApplicationView({super.key});

  @override
  State<ApplicationView> createState() => _ApplicationViewState();
}

class _ApplicationViewState extends State<ApplicationView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ApplicationIndex>(
      create: (context) => ApplicationIndex(),
      child: Consumer<ApplicationIndex>(
        builder: (context, viewModel, _) {
          return Scaffold(
            body: PageBuilder(index: viewModel.selectedIndex),
            bottomNavigationBar: Container(
              width: double.infinity,
              height: Responsive.screenHeight(context) * 0.1,
              decoration: BoxDecoration(
                color: ColorsGlobal.globalWhite,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 2,
                  )
                ],
              ),
              child: BottomNavigationBar(
                currentIndex: viewModel.selectedIndex,
                onTap: (index) {
                  viewModel.onItemTapped(index);
                },
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                selectedItemColor: viewModel.getColor(viewModel.selectedIndex),
                unselectedItemColor: ColorsGlobal.globalGrey,
                items: bottomTabs,
              ),
            ),
          );
        },
      ),
    );
  }
}
