import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tire_repair_mobile/presentation/blocs/auth_bloc.dart';
import 'package:tire_repair_mobile/presentation/widgets/login_form.dart';
import 'package:tire_repair_mobile/resources/color.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsGlobal.themeApp,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Đăng nhập thất bại: ${state.message}')),
              );
            }
            if (state is AuthSuccess) {
              Navigator.pushReplacementNamed(
                  context, '/home'); // Chuyển hướng đến trang chính
            }
          },
          child: Center(
            // Căn giữa toàn bộ nội dung trong body
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment
                    .center, // Căn giữa các widget trong Column
                children: [
                  const LoginForm(),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context,
                          '/register'); // Điều hướng sang trang đăng ký
                    },
                    child: const Text('Chưa có tài khoản? Đăng ký ngay'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
