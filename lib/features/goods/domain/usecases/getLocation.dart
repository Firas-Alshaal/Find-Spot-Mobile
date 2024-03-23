import 'package:dartz/dartz.dart';
import 'package:lost_find_tracker/core/error/failures.dart';
import 'package:lost_find_tracker/features/goods/data/models/map_model.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/map.dart';
import 'package:lost_find_tracker/features/goods/domain/repositories/goods_repository.dart';

class GetLocationUseCase {
  final GoodsRepository repository;

  GetLocationUseCase(this.repository);

  Future<Either<Failure, MapModel>> call(MapItem mapItem) async {
    return await repository.getLocation(mapItem);
  }
}
