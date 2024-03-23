import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmptyCacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class VerificationFailure extends Failure {
  final String errorMessage;

  VerificationFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class AuthorizationFailure extends Failure {
  @override
  List<Object?> get props => [];
}
