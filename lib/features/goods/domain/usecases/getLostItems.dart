import 'package:dartz/dartz.dart';
import 'package:lost_find_tracker/core/error/failures.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/itemType.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/lostItem.dart';
import 'package:lost_find_tracker/features/goods/domain/repositories/goods_repository.dart';

class GetLostItemUseCase {
  final GoodsRepository repository;

  GetLostItemUseCase(this.repository);

  Future<Either<Failure, List<LostItem>>> call(ItemType itemType) async {
    return await repository.getLostItems(itemType);
  }
}
