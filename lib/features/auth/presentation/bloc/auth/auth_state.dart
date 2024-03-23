part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoadingAuthState extends AuthState {}

class AuthSuccessState extends AuthState {
  @override
  List<Object> get props => [];
}

class ErrorAuthState extends AuthState {
  final String message;

  const ErrorAuthState({required this.message});

  @override
  List<Object> get props => [message];
}

class LoadingCategoriesState extends AuthState {}

class GetCategoriesSuccessState extends AuthState {
  final List<Category> categories;

  const GetCategoriesSuccessState({required this.categories});

  @override
  List<Object> get props => [categories];
}

class ErrorGetCategoriesState extends AuthState {
  final String message;

  const ErrorGetCategoriesState({required this.message});

  @override
  List<Object> get props => [message];
}
