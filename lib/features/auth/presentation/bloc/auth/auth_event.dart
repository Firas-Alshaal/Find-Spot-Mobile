part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final User login;

  const LoginEvent({required this.login});

  @override
  List<Object> get props => [login];
}

class RegisterEvent extends AuthEvent {
  final User register;

  const RegisterEvent({required this.register});

  @override
  List<Object> get props => [register];
}

class EditUserEvent extends AuthEvent {
  final User user;

  const EditUserEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class GetCategoriesEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class CancelAuthEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}
