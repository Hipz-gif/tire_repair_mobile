import 'package:tire_repair_mobile/data/datasources/auth_remote_data_source.dart';
import 'package:tire_repair_mobile/data/models/user_model.dart';
import 'package:tire_repair_mobile/domain/entities/user.dart';
import 'package:tire_repair_mobile/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> register(User user) {
    return remoteDataSource.register(UserModel(
      name: user.name,
      phone: user.phone,
      address: user.address,
      email: user.email,
      password: user.password,
    ));
  }

  @override
  Future<String> login(String email, String password) {
    return remoteDataSource.login(email, password);
  }
}
