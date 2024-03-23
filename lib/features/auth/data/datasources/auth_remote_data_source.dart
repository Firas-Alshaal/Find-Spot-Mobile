import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lost_find_tracker/core/network/headers.dart';
import 'package:lost_find_tracker/core/utils/constant.dart';
import 'package:lost_find_tracker/core/error/exceptions.dart';
import 'package:lost_find_tracker/features/auth/domain/entities/user.dart';
import 'package:lost_find_tracker/features/auth/domain/entities/register.dart';
import 'package:lost_find_tracker/features/goods/data/models/category_model.dart';

abstract class AuthRemoteDataSource {
  Future<String> login(User loginData);

  Future<String> register(Register registerData);

  Future<List<CategoryModel>> categories();
}

class AuthRemoteDataSourceImpl extends Api implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<String> login(User loginData) async {
    final body = {
      "email": loginData.email,
      "password": loginData.password,
    };

    final response = await client.post(
        Uri.parse(Constants.URL + Constants.LOGIN),
        body: utf8.encode(json.encode(body)),
        headers: await getHeaders());

    var responseJson = json.decode(response.body);

    if (response.statusCode == 201) {
      return Future.value(responseJson['accessToken']);
    } else if (response.statusCode == 400) {
      throw ValidateException(responseJson['message'][0]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> register(Register registerData) async {
    final body = {
      "email": registerData.email,
      "password": registerData.password,
      "passwordConfirmation": registerData.confirmPassword,
      "name": registerData.userName,
      "phoneNumber": registerData.phone,
    };

    final response = await client.post(
        Uri.parse(Constants.URL + Constants.Register),
        body: utf8.encode(json.encode(body)),
        headers: await getHeaders());
    var responseJson = json.decode(response.body);

    if (response.statusCode == 201) {
      return Future.value(responseJson['accessToken']);
    } else if (response.statusCode == 400) {
      throw ValidateException(responseJson['message'][0]);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<CategoryModel>> categories() async {
    final response = await client.get(
        Uri.parse('${Constants.URL}${Constants.GetCategories}'),
        headers: await getHeaders());

    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body)['data'] as List;
      final List<CategoryModel> lostItemsModels = decodedJson
          .map<CategoryModel>((jsonLostItemsModel) =>
              CategoryModel.fromJson(jsonLostItemsModel))
          .toList();

      return lostItemsModels;
    } else {
      throw ServerException();
    }
  }
}
