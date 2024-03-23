import 'package:equatable/equatable.dart';

class Register with EquatableMixin {
  const Register({
    required this.userName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phone,
  });

  final String userName;
  final String phone;
  final String password;
  final String email;
  final String confirmPassword;

  @override
  List<Object?> get props => [
        userName,
        phone,
        password,
        email,
        confirmPassword,
      ];
}
