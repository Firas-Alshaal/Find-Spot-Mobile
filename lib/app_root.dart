import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lost_find_tracker/core/utils/constant.dart';
import 'package:lost_find_tracker/core/utils/routes.dart';
import 'package:lost_find_tracker/core/utils/theme_color.dart';
import 'package:lost_find_tracker/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:lost_find_tracker/features/goods/presentation/bloc/goods/goods_bloc.dart';
import 'package:lost_find_tracker/features/goods/presentation/bloc/map/map_bloc.dart';

import 'injection_container.dart' as di;

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthBloc>()),
        BlocProvider(create: (_) => di.sl<GoodsBloc>()),
        BlocProvider(create: (_) => di.sl<MapBloc>()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: ColorsFave.primaryColor,
          textSelectionTheme: TextSelectionThemeData(
              selectionHandleColor: ColorsFave.primaryColor),
        ),
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        routes: Routes.routes,
        initialRoute: Constants.SPLASH,
      ),
    );
  }
}
