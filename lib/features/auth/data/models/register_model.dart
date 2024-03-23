import 'package:lost_find_tracker/features/auth/domain/entities/register.dart';

class RegisterModel extends Register {
  const RegisterModel(
      {required String email,
      required String password,
      required String phone,
      required String userName,
      required String confirmPassword})
      : super(
          phone: phone,
          password: password,
          email: email,
          userName: userName,
          confirmPassword: confirmPassword,
        );

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      email: json['email'],
      password: json['password'],
      userName: json['userName'],
      confirmPassword: json['confirmPassword'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'phone': phone,
      'userName': userName,
    };
  }
}
