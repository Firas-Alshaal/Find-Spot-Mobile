import 'package:dartz/dartz.dart';
import 'package:lost_find_tracker/core/error/failures.dart';
import 'package:lost_find_tracker/features/auth/domain/entities/user.dart';
import 'package:lost_find_tracker/features/auth/domain/entities/register.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/category.dart';

abstract class AuthRepository {
  Future<Either<Failure, String>> register(Register register);

  Future<Either<Failure, String>> login(User login);

  Future<Either<Failure, List<Category>>> categories();
}
