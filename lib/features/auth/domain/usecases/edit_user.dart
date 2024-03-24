import 'package:dartz/dartz.dart';
import 'package:lost_find_tracker/core/error/failures.dart';
import 'package:lost_find_tracker/features/auth/data/models/user_model.dart';
import 'package:lost_find_tracker/features/auth/domain/entities/user.dart';
import 'package:lost_find_tracker/features/auth/domain/repositories/auth_repository.dart';

class EditUserUseCase {
  final AuthRepository repository;

  EditUserUseCase(this.repository);

  Future<Either<Failure, UserModel>> call(User editUser) async {
    return await repository.editUser(editUser);
  }
}
