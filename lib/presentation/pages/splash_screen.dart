import 'package:flutter/material.dart';
import 'package:tire_repair_mobile/resources/color.dart';
import 'package:tire_repair_mobile/service/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final authService = AuthService();
    final token =
        await authService.getToken(); // Kiểm tra token từ SharedPreferences

    Future.delayed(const Duration(seconds: 2), () {
      if (token != null) {
        Navigator.pushReplacementNamed(
            // ignore: use_build_context_synchronously
            context,
            '/home'); // Nếu có token, chuyển sang HomePage
      } else {
        Navigator.pushReplacementNamed(
            // ignore: use_build_context_synchronously
            context,
            '/login'); // Nếu không có token, chuyển sang LoginPage
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsGlobal.themeApp, // Màu nền của SplashScreen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
