import 'package:equatable/equatable.dart';

class User with EquatableMixin {
  const User({
    required this.email,
    required this.password,
    this.phoneNumber,
    this.name,
    this.id,
  });

  final String email;
  final String password;
  final String? phoneNumber;
  final String? name;
  final String? id;

  @override
  List<Object?> get props => [
        email,
        password,
        phoneNumber,
        name,
        id,
      ];
}
