import 'package:dartz/dartz.dart';
import 'package:lost_find_tracker/core/error/failures.dart';
import 'package:lost_find_tracker/features/auth/data/models/auth_model.dart';
import 'package:lost_find_tracker/features/auth/domain/entities/user.dart';
import 'package:lost_find_tracker/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, AuthUser>> call(User registerData) async {
    return await repository.register(registerData);
  }
}
