import 'package:flutter/material.dart';
import 'package:lost_find_tracker/core/utils/constant.dart';
import 'package:lost_find_tracker/features/auth/presentation/screen/edit_profile_screen.dart';
import 'package:lost_find_tracker/features/auth/presentation/screen/intro_screen.dart';
import 'package:lost_find_tracker/features/auth/presentation/screen/login_screen.dart';
import 'package:lost_find_tracker/features/auth/presentation/screen/register_screen.dart';
import 'package:lost_find_tracker/features/auth/presentation/screen/splash_screen.dart';
import 'package:lost_find_tracker/features/goods/presentation/screen/add_found_item_screen.dart';
import 'package:lost_find_tracker/features/goods/presentation/screen/add_lost_item_screen.dart';
import 'package:lost_find_tracker/features/goods/presentation/screen/found_items_screen.dart';
import 'package:lost_find_tracker/features/goods/presentation/screen/home_screen.dart';
import 'package:lost_find_tracker/features/goods/presentation/screen/item_details_screen.dart';
import 'package:lost_find_tracker/features/goods/presentation/screen/location_items_screen.dart';
import 'package:lost_find_tracker/features/goods/presentation/screen/lost_items_screen.dart';
import 'package:lost_find_tracker/features/goods/presentation/screen/put_location_screen.dart';
import 'package:lost_find_tracker/features/goods/presentation/screen/search_items_screen.dart';

class Routes {
  static final _splash = SplashPage();
  static const _intro = IntroScreen();
  static const _home = HomeScreen();
  static final _login = LoginScreen();
  static final _register = RegisterScreen();
  static final _search = SearchItemsScreen();
  static final _addLost = AddLostItemsScreen();
  static final _addFound = AddFoundItemsScreen();
  static final _lostItems = LostItemsScreen();
  static final _foundItems = FoundItemsScreen();
  static const _location = LocationItemsScreen();
  static const _details = ItemDetailsScreen();
  static final _putLocation = PutLocationScreen();
  static const _editUser = EditUserScreen();

  static final routes = <String, WidgetBuilder>{
    Constants.SPLASH: (BuildContext context) => _splash,
    Constants.IntroScreen: (BuildContext context) => _intro,
    Constants.HomeScreen: (BuildContext context) => _home,
    Constants.LoginScreen: (BuildContext context) => _login,
    Constants.RegisterScreen: (BuildContext context) => _register,
    Constants.SearchScreen: (BuildContext context) => _search,
    Constants.AddFoundScreen: (BuildContext context) => _addFound,
    Constants.AddLostScreen: (BuildContext context) => _addLost,
    Constants.LostItemScreen: (BuildContext context) => _lostItems,
    Constants.FoundItemScreen: (BuildContext context) => _foundItems,
    Constants.LocationScreen: (BuildContext context) => _location,
    Constants.ItemDetailsScreen: (BuildContext context) => _details,
    Constants.PutLocationScreen: (BuildContext context) => _putLocation,
    Constants.EditUserScreen: (BuildContext context) => _editUser,
  };
}
