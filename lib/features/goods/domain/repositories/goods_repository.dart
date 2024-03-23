import 'package:dartz/dartz.dart';
import 'package:lost_find_tracker/core/error/failures.dart';
import 'package:lost_find_tracker/features/goods/data/models/map_model.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/itemType.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/lostItem.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/map.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/search.dart';

abstract class GoodsRepository {
  Future<Either<Failure, Unit>> lostItem(LostItem lostItem, ItemType itemType);

  Future<Either<Failure, List<LostItem>>> getLostItems(ItemType itemType);

  Future<Either<Failure, List<LostItem>>> searchItems(Search search);

  Future<Either<Failure, MapModel>> getLocation(MapItem mapItem);
}
