import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tire_repair_mobile/di/service_locator.dart';
import 'package:tire_repair_mobile/presentation/blocs/auth_bloc.dart';
import 'package:tire_repair_mobile/presentation/blocs/spare_part_bloc.dart';
import 'package:tire_repair_mobile/presentation/blocs/banner_bloc.dart';
import 'package:tire_repair_mobile/domain/repositories/auth_repository.dart';
import 'package:tire_repair_mobile/domain/repositories/spare_part_repository.dart';
import 'package:tire_repair_mobile/domain/repositories/banner_repository.dart';
import 'package:tire_repair_mobile/resources/routes.dart';
import 'package:tire_repair_mobile/routes/app_routes.dart';

void main() {
  setupLocator();

  runApp(
    MultiBlocProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => locator<AuthRepository>(),
        ),
        RepositoryProvider<SparePartRepository>(
          create: (context) => locator<SparePartRepository>(),
        ),
        RepositoryProvider<BannerRepository>(
          create: (context) => locator<BannerRepository>(),
        ),
        BlocProvider<AuthBloc>(
          create: (context) =>
              AuthBloc(authRepository: locator<AuthRepository>()),
        ),
        BlocProvider<SparePartBloc>(
          create: (context) => SparePartBloc(
              sparePartRepository: locator<SparePartRepository>()),
        ),
        BlocProvider<BannerBloc>(
          create: (context) =>
              BannerBloc(bannerRepository: locator<BannerRepository>())
                ..add(FetchBanners()),
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:
          RouteName.splash, // Đặt màn hình SplashScreen làm màn hình đầu tiên
      onGenerateRoute:
          generateRoute, // Sử dụng hàm generateRoute từ app_routes.dart
    );
  }
}
