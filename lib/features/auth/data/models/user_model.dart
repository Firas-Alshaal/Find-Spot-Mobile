import 'package:lost_find_tracker/features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String email,
    required String password,
    String? phoneNumber,
    String? name,
  }) : super(
          email: email,
          password: password,
          name: name,
          phoneNumber: phoneNumber,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      password: json['password'],
      name: json['name'],
      phoneNumber: json['phone_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'phone_number': phoneNumber,
    };
  }
}
