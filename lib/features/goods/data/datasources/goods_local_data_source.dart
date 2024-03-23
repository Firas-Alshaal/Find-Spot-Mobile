import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:lost_find_tracker/core/utils/constant.dart';
import 'package:lost_find_tracker/core/error/exceptions.dart';
import 'package:lost_find_tracker/features/goods/data/models/lostItem_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class GoodsLocalDataSource {
  Future<List<LostItemModel>> getCachedListLostItem();

  Future<Unit> cacheLostItems(List<LostItemModel> lostItems);
}

class GoodsLocalDataSourceImpl implements GoodsLocalDataSource {
  final SharedPreferences sharedPreferences;

  GoodsLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cacheLostItems(List<LostItemModel> lostItems) {
    List lostItemModelsToJson = lostItems
        .map<Map<String, dynamic>>((lostModel) => lostModel.toJson())
        .toList();
    sharedPreferences.setString(
        Constants.LostItems, json.encode(lostItemModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<LostItemModel>> getCachedListLostItem() {
    final jsonString = sharedPreferences.getString(Constants.LostItems);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<LostItemModel> jsonToLostItemsModels = decodeJsonData
          .map<LostItemModel>(
              (jsonLostItemModel) => LostItemModel.fromJson(jsonLostItemModel))
          .toList();
      return Future.value(jsonToLostItemsModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
