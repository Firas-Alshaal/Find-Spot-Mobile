import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:lost_find_tracker/core/network/headers.dart';
import 'package:lost_find_tracker/core/utils/constant.dart';
import 'package:lost_find_tracker/core/error/exceptions.dart';
import 'package:lost_find_tracker/features/goods/data/models/lostItem_model.dart';
import 'package:lost_find_tracker/features/goods/data/models/map_model.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/itemType.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/search.dart';

abstract class GoodsRemoteDataSource {
  Future<Unit> lostItem(LostItemModel lostItem, ItemType itemType);

  Future<List<LostItemModel>> getLostItems(ItemType itemType);

  Future<List<LostItemModel>> searchItems(Search search);

  Future<MapModel> getLocation(MapModel mapItem);
}

class GoodsRemoteDataSourceImpl extends Api implements GoodsRemoteDataSource {
  final http.Client client;

  GoodsRemoteDataSourceImpl({required this.client});

  @override
  Future<Unit> lostItem(LostItemModel lostItem, ItemType itemType) async {
    Map<String, dynamic> body = {
      "name": lostItem.name,
      "description": lostItem.description,
      "categoryId": lostItem.categoryId,
      "lostDate": lostItem.date,
      "lat": lostItem.lat,
      "long": lostItem.long,
      "images": lostItem.images,
      "city": lostItem.city,
      "street": lostItem.street,
    };

    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            '${Constants.URL}${itemType.name == ItemType.LOST.name ? Constants.AddLostItem : Constants.AddFoundItem}'));
    request.headers.addAll(await getHeaders());

    body.forEach((key, value) async {
      if (key == 'images' && value.length > 0) {
        request.files
            .add(await http.MultipartFile.fromPath(key, value.first.path));
      } else {
        request.fields[key] = value.toString();
      }
    });

    var response = await request.send().timeout(const Duration(seconds: 30));
    final respStr = await response.stream.bytesToString();
    jsonDecode(respStr);

    if (response.statusCode == 201) {
      return Future.value(unit);
    } else if (response.statusCode == 401) {
      throw AuthorizationException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<LostItemModel>> getLostItems(ItemType itemType) async {
    final response = await client
        .get(
            Uri.parse(
                '${Constants.URL}${Constants.GetLostItem}?lostType=${itemType.name}'),
            headers: await getHeaders())
        .timeout(const Duration(seconds: 60));

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body)['data'] as List;
      final List<LostItemModel> lostItemsModels = decodedJson
          .map<LostItemModel>((jsonLostItemsModel) =>
              LostItemModel.fromJson(jsonLostItemsModel))
          .toList();

      return lostItemsModels;
    } else if (response.statusCode == 401) {
      throw AuthorizationException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<LostItemModel>> searchItems(Search search) async {
    final response = await client
        .get(
            Uri.parse(
                '${Constants.URL}${Constants.Search}?categoryId=${search.categoryId}&name=${search.name}&date=${search.date}&location=${search.location}'),
            headers: await getHeaders())
        .timeout(const Duration(seconds: 60));

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body)['data'] as List;
      final List<LostItemModel> lostItemsModels = decodedJson
          .map<LostItemModel>((jsonLostItemsModel) =>
              LostItemModel.fromJson(jsonLostItemsModel))
          .toList();

      return lostItemsModels;
    } else if (response.statusCode == 401) {
      throw AuthorizationException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MapModel> getLocation(MapModel mapModel) async {
    final body = {
      "lat": mapModel.lat,
      "lng": mapModel.long,
    };

    final response = await client
        .post(Uri.parse('BASE URL API'),
            body: jsonEncode(body), headers: await getHeadersMap())
        .timeout(const Duration(seconds: 60));

    var responseJson = json.decode(response.body);

    if (response.statusCode == 200 && responseJson['success']) {
      MapModel mapModel = MapModel.fromJson(responseJson['data']);

      return Future.value(mapModel);
    } else {
      throw ServerException();
    }
  }
}
