import 'package:equatable/equatable.dart';

class User with EquatableMixin {
  const User({
    required this.email,
    required this.password,
    this.phoneNumber,
    this.name,
  });

  final String email;
  final String password;
  final String? phoneNumber;
  final String? name;

  @override
  List<Object?> get props => [
        email,
        password,
        phoneNumber,
        name,
      ];
}
