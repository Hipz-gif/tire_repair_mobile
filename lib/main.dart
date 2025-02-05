import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tire_repair_mobile/di/service_locator.dart';
import 'package:tire_repair_mobile/presentation/blocs/auth_bloc.dart';
import 'package:tire_repair_mobile/presentation/blocs/spare_part_bloc.dart';
import 'package:tire_repair_mobile/presentation/blocs/banner_bloc.dart'; // Thêm BannerBloc
import 'package:tire_repair_mobile/presentation/pages/login_page.dart';
import 'package:tire_repair_mobile/presentation/pages/register_page.dart';
import 'package:tire_repair_mobile/presentation/pages/home_page.dart';
import 'package:tire_repair_mobile/presentation/pages/splash_screen.dart'; // Thêm SplashScreen
import 'package:tire_repair_mobile/domain/repositories/auth_repository.dart';
import 'package:tire_repair_mobile/domain/repositories/spare_part_repository.dart';
import 'package:tire_repair_mobile/domain/repositories/banner_repository.dart'; // Thêm BannerRepository

void main() {
  setupLocator();

  runApp(
    MultiBlocProvider(
      providers: [
        // Đăng ký AuthRepository
        RepositoryProvider<AuthRepository>(
          create: (context) => locator<AuthRepository>(),
        ),
        // Đăng ký SparePartRepository
        RepositoryProvider<SparePartRepository>(
          create: (context) => locator<SparePartRepository>(),
        ),
        // Đăng ký BannerRepository
        RepositoryProvider<BannerRepository>(
          create: (context) => locator<BannerRepository>(),
        ),
        // Đăng ký AuthBloc
        BlocProvider<AuthBloc>(
          create: (context) =>
              AuthBloc(authRepository: locator<AuthRepository>()),
        ),
        // Đăng ký SparePartBloc
        BlocProvider<SparePartBloc>(
          create: (context) => SparePartBloc(
              sparePartRepository: locator<SparePartRepository>()),
        ),
        // Đăng ký BannerBloc
        BlocProvider<BannerBloc>(
          create: (context) =>
              BannerBloc(bannerRepository: locator<BannerRepository>())
                ..add(FetchBanners()), // Gọi sự kiện FetchBanners
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:
          '/splash', // Đặt màn hình SplashScreen làm màn hình đầu tiên
      routes: {
        '/splash': (context) => SplashScreen(), // Thêm route cho SplashScreen
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
