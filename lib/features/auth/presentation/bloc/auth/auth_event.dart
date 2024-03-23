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
  final Register register;

  const RegisterEvent({required this.register});

  @override
  List<Object> get props => [register];
}

class GetCategoriesEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class CancelAuthEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

