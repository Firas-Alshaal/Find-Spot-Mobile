import 'package:dartz/dartz.dart';
import 'package:lost_find_tracker/core/error/failures.dart';
import 'package:lost_find_tracker/features/auth/data/models/auth_model.dart';
import 'package:lost_find_tracker/features/auth/data/models/user_model.dart';
import 'package:lost_find_tracker/features/auth/domain/entities/user.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/category.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthUser>> register(User register);

  Future<Either<Failure, AuthUser>> login(User login);

  Future<Either<Failure, List<Category>>> categories();

  Future<Either<Failure, UserModel>> editUser(User editUser);
}
