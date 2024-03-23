import 'package:dartz/dartz.dart';
import 'package:lost_find_tracker/core/error/failures.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/lostItem.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/search.dart';
import 'package:lost_find_tracker/features/goods/domain/repositories/goods_repository.dart';

class SearchItemUseCase {
  final GoodsRepository repository;

  SearchItemUseCase(this.repository);

  Future<Either<Failure, List<LostItem>>> call(Search search) async {
    return await repository.searchItems(search);
  }
}
