import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lost_find_tracker/core/utils/assets.dart';
import 'package:lost_find_tracker/core/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../injection_container.dart' as di;

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  initState() {
    super.initState();
    var sharedPreference = di.sl<SharedPreferences>();
    Future.delayed(const Duration(seconds: 2), () {
      if (sharedPreference.containsKey(Constants.TOKEN)) {
        Navigator.pushReplacementNamed(context, Constants.HomeScreen);
      } else {
        if (sharedPreference.containsKey(Constants.OnBoarding)) {
          if (sharedPreference.getBool(Constants.OnBoarding) == true) {
            Navigator.pushReplacementNamed(context, Constants.IntroScreen);
          } else {
            Navigator.pushReplacementNamed(context, Constants.LoginScreen);
          }
        } else {
          Navigator.pushReplacementNamed(context, Constants.IntroScreen);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          Images.logo,
          width: 200,
          fit: BoxFit.cover,
        ).animate().fadeIn(delay: .4.seconds, duration: .5.seconds),
      ),
    );
  }
}
