import 'package:tire_repair_mobile/common/view/page_under_construction.dart';
import 'package:tire_repair_mobile/presentation/pages/application/application_view.dart';
import 'package:tire_repair_mobile/presentation/pages/home_page.dart';
import 'package:tire_repair_mobile/presentation/pages/login_page.dart';
import 'package:tire_repair_mobile/presentation/pages/register_page.dart';
import 'package:tire_repair_mobile/presentation/pages/splash_screen.dart';

import '../resources/routes.dart';

import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteName.splash:
      return _pageBuilder((_) => const SplashScreen(), settings: settings);

    case RouteName.login:
      return _pageBuilder((_) => const LoginPage(), settings: settings);

    case RouteName.register:
      return _pageBuilder((_) => const RegisterPage(), settings: settings);

    case RouteName.home:
      return _pageBuilder((_) => const HomePage(), settings: settings);
    case RouteName.application:
      return _pageBuilder((_) => const ApplicationView(), settings: settings);
    default:
      return _pageBuilder((_) => const PageUnderConstruction(),
          settings: settings);
  }
}

PageRouteBuilder<dynamic> _pageBuilder(Widget Function(BuildContext) page,
    {required RouteSettings settings}) {
  return PageRouteBuilder(
      settings: settings,
      transitionsBuilder: (_, animation, __, child) =>
          FadeTransition(opacity: animation, child: child),
      pageBuilder: (context, _, __) => page(context));
}
