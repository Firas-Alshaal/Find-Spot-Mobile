import 'package:dartz/dartz.dart';
import 'package:lost_find_tracker/core/error/exceptions.dart';
import 'package:lost_find_tracker/core/error/failures.dart';
import 'package:lost_find_tracker/core/network/network_info.dart';
import 'package:lost_find_tracker/features/goods/data/datasources/goods_local_data_source.dart';
import 'package:lost_find_tracker/features/goods/data/datasources/goods_remote_data_source.dart';
import 'package:lost_find_tracker/features/goods/data/models/lostItem_model.dart';
import 'package:lost_find_tracker/features/goods/data/models/map_model.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/itemType.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/lostItem.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/map.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/search.dart';
import 'package:lost_find_tracker/features/goods/domain/repositories/goods_repository.dart';

typedef Future<Unit> LostOrFound();

class GoodsRepositoryImpl implements GoodsRepository {
  final GoodsRemoteDataSource remoteDataSource;
  final GoodsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  GoodsRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<LostItem>>> searchItems(Search search) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteLostItems = await remoteDataSource.searchItems(search);
        return Right(remoteLostItems);
      } on AuthorizationException {
        return Left(AuthorizationFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(ServerFailure());
  }

  @override
  Future<Either<Failure, List<LostItem>>> getLostItems(
      ItemType itemType) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteLostItems = await remoteDataSource.getLostItems(itemType);
        if (itemType.name == ItemType.BOTH.name) {
          localDataSource.cacheLostItems(remoteLostItems);
        }
        return Right(remoteLostItems);
      } on ServerException {
        return Left(ServerFailure());
      } on AuthorizationException {
        return Left(AuthorizationFailure());
      }
    } else {
      try {
        final localLostItem = await localDataSource.getCachedListLostItem();
        return Right(localLostItem);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, MapModel>> getLocation(MapItem mapItem) async {
    final MapModel mapModel = MapModel(
      lat: mapItem.lat,
      long: mapItem.long,
    );
    if (await networkInfo.isConnected) {
      try {
        final mapInfo = await remoteDataSource.getLocation(mapModel);
        return Right(mapInfo);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> lostItem(
      LostItem lostItem, ItemType itemType) async {
    final LostItemModel lostItemModel = LostItemModel(
      name: lostItem.name,
      description: lostItem.description,
      date: lostItem.date,
      categoryId: lostItem.categoryId,
      lat: lostItem.lat,
      long: lostItem.long,
      city: lostItem.city,
      street: lostItem.street,
      images: lostItem.images,
    );
    return await _addGoodsItem(() {
      return remoteDataSource.lostItem(lostItemModel, itemType);
    });
  }

  Future<Either<Failure, Unit>> _addGoodsItem(LostOrFound lostOrFound) async {
    if (await networkInfo.isConnected) {
      try {
        await lostOrFound();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } on AuthorizationException {
        return Left(AuthorizationFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
