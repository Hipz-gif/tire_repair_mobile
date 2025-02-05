import 'package:flutter/material.dart';
import 'package:tire_repair_mobile/resources/color.dart';
import 'package:tire_repair_mobile/service/auth_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final authService = AuthService();
    final token =
        await authService.getToken(); // Kiểm tra token từ SharedPreferences

    // Chờ 2 giây rồi điều hướng
    Future.delayed(Duration(seconds: 2), () {
      if (token != null) {
        Navigator.pushReplacementNamed(
            context, '/home'); // Nếu có token, chuyển sang HomePage
      } else {
        Navigator.pushReplacementNamed(
            context, '/login'); // Nếu không có token, chuyển sang LoginPage
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
