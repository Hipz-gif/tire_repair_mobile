import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tire_repair_mobile/data/models/user_model.dart';
import 'package:tire_repair_mobile/presentation/blocs/auth_bloc.dart';
import 'package:tire_repair_mobile/resources/color.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsGlobal.themeApp,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png'),
                const Text(
                  'Đăng kí ngay',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildTextField(
                          controller: _fullNameController,
                          hintText: 'Tên đầy đủ'),
                      const SizedBox(height: 10),
                      _buildTextField(
                          controller: _phoneController,
                          hintText: 'Số điện thoại'),
                      const SizedBox(height: 10),
                      _buildTextField(
                          controller: _addressController, hintText: 'Địa chỉ'),
                      const SizedBox(height: 10),
                      _buildTextField(
                          controller: _emailController, hintText: 'Email'),
                      const SizedBox(height: 10),
                      _buildTextField(
                          controller: _passwordController,
                          hintText: 'Mật khẩu',
                          obscureText: true),
                      const SizedBox(height: 20),
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is AuthSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Đăng ký thành công!')),

                              // Sau khi đăng ký thành công, bạn có thể lưu token vào SharedPreferences
                            );
                          } else if (state is AuthFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is AuthLoading) {
                            return const CircularProgressIndicator();
                          }
                          return ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final userModel = UserModel(
                                  name: _fullNameController.text,
                                  phone: _phoneController.text,
                                  address: _addressController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                                context.read<AuthBloc>().add(RegisterUser(
                                    userModel)); // ✅ Đúng kiểu UserModel
                              }
                            },
                            child: const Text('Đăng ký'),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          // Quay lại trang đăng nhập
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Đã có tài khoản? Đăng nhập ngay',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: const Color.fromARGB(
            255, 218, 153, 199), // ✅ Màu vàng nhạt cho input
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) => value!.isEmpty ? 'Enter $hintText' : null,
    );
  }
}
