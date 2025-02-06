// page_builder.dart
import 'package:flutter/material.dart';
import 'package:tire_repair_mobile/presentation/pages/chat/chat_page.dart';
import 'package:tire_repair_mobile/presentation/pages/home/home_page.dart';
import 'package:tire_repair_mobile/presentation/pages/request/request_page.dart';
import 'package:tire_repair_mobile/presentation/pages/workshop/workshop_page.dart';

class PageBuilder extends StatefulWidget {
  final int index;

  const PageBuilder({
    super.key,
    required this.index,
  });

  @override
  State<PageBuilder> createState() => _PageBuilderState();
}

class _PageBuilderState extends State<PageBuilder> {
  @override
  Widget build(BuildContext context) {
    return buildPage(widget.index);
  }

  Widget buildPage(int index) {
    List<Widget> widgetList = [
      const HomePage(),
      const RequestPage(),
      const WorkshopPage(),
      const ChatPage(),
    ];

    return widgetList[index];
  }
}
