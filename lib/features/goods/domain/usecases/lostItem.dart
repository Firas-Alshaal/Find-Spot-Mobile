import 'package:dartz/dartz.dart';
import 'package:lost_find_tracker/core/error/failures.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/itemType.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/lostItem.dart';
import 'package:lost_find_tracker/features/goods/domain/repositories/goods_repository.dart';

class LostItemUseCase {
  final GoodsRepository repository;

  LostItemUseCase(this.repository);

  Future<Either<Failure, Unit>> call(
      LostItem lostItem, ItemType itemType) async {
    return await repository.lostItem(lostItem, itemType);
  }
}
