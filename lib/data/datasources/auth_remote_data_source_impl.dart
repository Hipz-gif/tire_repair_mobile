import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tire_repair_mobile/core/error/auth_error.dart';
import 'package:tire_repair_mobile/core/utils/api_constants.dart';
import 'package:tire_repair_mobile/data/datasources/auth_remote_data_source.dart';
import 'package:tire_repair_mobile/data/models/user_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<void> register(UserModel user) async {
    final url = Uri.parse('${ApiConstants.baseUrlAuth}/register');

    try {
      print('Sending request to $url with body: ${jsonEncode(user.toJson())}');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 201) {
        print('User registered successfully');
      } else {
        final errorMessage =
            jsonDecode(response.body)['message'] ?? AuthError.registrationError;
        throw Exception('Failed to register: $errorMessage');
      }
    } catch (e) {
      throw Exception('${AuthError.networkError}: $e');
    }
  }

  @override
  Future<String> login(String email, String password) async {
    final url = Uri.parse('${ApiConstants.baseUrlAuth}/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        return token;
      } else {
        final errorMessage = jsonDecode(response.body)['message'] ??
            AuthError.invalidCredentials;
        throw Exception('Đăng nhập thất bại: $errorMessage');
      }
    } catch (e) {
      throw Exception('${AuthError.networkError}: $e');
    }
  }
}
