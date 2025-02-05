import 'package:tire_repair_mobile/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<void> register(UserModel user);
  Future<String> login(String email, String password);
}
