import 'package:tire_repair_mobile/domain/entities/user.dart';

class UserModel extends User {
  UserModel(
      {required super.name,
      required super.phone,
      required super.address,
      required super.email,
      required super.password});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['full_name'],
      phone: json['phone_number'],
      address: json['address'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'full_name': name,
      'phone_number': phone,
      'address': address,
      'email': email,
      'password': password
    };
  }
}
