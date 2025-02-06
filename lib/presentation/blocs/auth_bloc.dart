import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tire_repair_mobile/data/models/user_model.dart';
import 'package:tire_repair_mobile/domain/repositories/auth_repository.dart';
import 'package:tire_repair_mobile/service/auth_service.dart';

// Các sự kiện
abstract class AuthEvent {}

class RegisterUser extends AuthEvent {
  final UserModel user; // UserModel là lớp mô hình
  RegisterUser(this.user); // Constructor
}

class LoginUser extends AuthEvent {
  final String email;
  final String password;
  LoginUser({required this.email, required this.password});
}

// Các trạng thái
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String? token; // Token có thể null trong một số trường hợp
  final String? message; // Thông điệp nếu có

  AuthSuccess({this.token, this.message});
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

// Bloc xử lý logic
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<RegisterUser>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.register(event.user);
        emit(AuthSuccess(message: 'Đăng ký thành công!'));

        // Giả sử bạn nhận được token sau khi đăng ký thành công
        const String token = 'sample_token'; // Thay bằng token thực tế
        final authService = AuthService();
        await authService.saveToken(token); // Lưu token
      } catch (e) {
        emit(AuthFailure(e.toString())); // Thông báo lỗi nếu đăng ký thất bại
      }
    });

    on<LoginUser>((event, emit) async {
      emit(AuthLoading());
      try {
        final token = await authRepository.login(event.email, event.password);

        // Lưu token vào SharedPreferences thông qua AuthService
        final authService = AuthService();
        await authService.saveToken(token);

        emit(AuthSuccess(token: token)); // Thông báo thành công và trả về token
      } catch (e) {
        emit(AuthFailure(e.toString())); // Thông báo lỗi nếu đăng nhập thất bại
      }
    });
  }
}
