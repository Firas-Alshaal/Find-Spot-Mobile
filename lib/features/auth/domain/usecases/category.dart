import 'package:dartz/dartz.dart';
import 'package:lost_find_tracker/core/error/failures.dart';
import 'package:lost_find_tracker/features/auth/domain/repositories/auth_repository.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/category.dart';

class CategoryUseCase {
  final AuthRepository repository;

  CategoryUseCase(this.repository);

  Future<Either<Failure, List<Category>>> call() async {
    return await repository.categories();
  }
}
