import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:lost_find_tracker/core/utils/constant.dart';
import 'package:lost_find_tracker/features/auth/data/models/user_model.dart';
import 'package:lost_find_tracker/features/goods/data/models/category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';

abstract class AuthLocalDataSource {
  Future<String> getCachedToken();

  Future<Unit> cacheToken(String token);

  Future<Unit> saveCategories(List<CategoryModel> categories);

  Future<List<CategoryModel>> loadCategories();

  Future<Unit> saveUser(UserModel userModel);

  Future<UserModel> loadUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cacheToken(String token) {
    sharedPreferences.setString(Constants.TOKEN, token);
    return Future.value(unit);
  }

  @override
  Future<String> getCachedToken() {
    final jsonString = sharedPreferences.getString(Constants.TOKEN);
    if (jsonString != null) {
      return Future.value(jsonString);
    } else {
      throw EmptyCacheException();
    }
  }

  @override
  Future<Unit> saveUser(UserModel userModel) {
    final userModelString = json.encode(userModel.toJson());
    sharedPreferences.setString(Constants.User, userModelString);

    return Future.value(unit);
  }

  @override
  Future<UserModel> loadUser() {
    final categoryString = sharedPreferences.getString(Constants.User);
    return Future.value(UserModel.fromJson(json.decode(categoryString!)));
  }

  @override
  Future<Unit> saveCategories(List<CategoryModel> categories) async {
    List<String> categoriesString =
        categories.map((category) => json.encode(category.toJson())).toList();
    await sharedPreferences.setStringList(
        Constants.Categories, categoriesString);
    return Future.value(unit);
  }

  @override
  Future<List<CategoryModel>> loadCategories() async {
    List<String> categoriesString =
        sharedPreferences.getStringList(Constants.Categories) ?? [];
    return categoriesString
        .map((category) => CategoryModel.fromJson(json.decode(category)))
        .toList();
  }
}
