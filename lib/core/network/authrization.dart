import 'package:flutter/material.dart';
import 'package:lost_find_tracker/core/utils/constant.dart';
import 'package:lost_find_tracker/injection_container.dart' as di;
import 'package:shared_preferences/shared_preferences.dart';

void logout(BuildContext context) async {
  final SharedPreferences sharedPreferences = di.sl<SharedPreferences>();
  await sharedPreferences.remove(Constants.TOKEN);
  if (!context.mounted) return;
  Navigator.pushNamedAndRemoveUntil(
    context,
    Constants.LoginScreen,
    (Route<dynamic> route) => false,
  );
}
