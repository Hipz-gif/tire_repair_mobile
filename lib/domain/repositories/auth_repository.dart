import 'package:tire_repair_mobile/domain/entities/user.dart';

abstract class AuthRepository {
  Future<void> register(User user);
  Future<String> login(String email, String password);
}
