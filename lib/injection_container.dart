import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lost_find_tracker/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:lost_find_tracker/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:lost_find_tracker/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:lost_find_tracker/features/auth/domain/repositories/auth_repository.dart';
import 'package:lost_find_tracker/features/auth/domain/usecases/category.dart';
import 'package:lost_find_tracker/features/auth/domain/usecases/edit_user.dart';
import 'package:lost_find_tracker/features/auth/domain/usecases/login.dart';
import 'package:lost_find_tracker/features/auth/domain/usecases/register.dart';
import 'package:lost_find_tracker/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:lost_find_tracker/features/goods/data/datasources/goods_local_data_source.dart';
import 'package:lost_find_tracker/features/goods/data/datasources/goods_remote_data_source.dart';
import 'package:lost_find_tracker/features/goods/data/repositories/goods_repository_impl.dart';
import 'package:lost_find_tracker/features/goods/domain/repositories/goods_repository.dart';
import 'package:lost_find_tracker/features/goods/domain/usecases/getLocation.dart';
import 'package:lost_find_tracker/features/goods/domain/usecases/getLostItems.dart';
import 'package:lost_find_tracker/features/goods/domain/usecases/lostItem.dart';
import 'package:lost_find_tracker/features/goods/domain/usecases/searchItem.dart';
import 'package:lost_find_tracker/features/goods/presentation/bloc/goods/goods_bloc.dart';
import 'package:lost_find_tracker/features/goods/presentation/bloc/map/map_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features - Items

// Bloc

  sl.registerFactory(() => AuthBloc(
      loginUseCase: sl(),
      registerUseCase: sl(),
      categoryUseCase: sl(),
      editUserUseCase: sl()));
  sl.registerFactory(() => GoodsBloc(
      getLostItemUseCase: sl(),
      lostItemUseCase: sl(),
      searchItemUseCase: sl()));
  sl.registerFactory(() => MapBloc(getLocationUseCase: sl()));

// Usecases

  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => EditUserUseCase(sl()));
  sl.registerLazySingleton(() => CategoryUseCase(sl()));
  sl.registerLazySingleton(() => LostItemUseCase(sl()));
  sl.registerLazySingleton(() => GetLostItemUseCase(sl()));
  sl.registerLazySingleton(() => GetLocationUseCase(sl()));
  sl.registerLazySingleton(() => SearchItemUseCase(sl()));

// Repository

  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  sl.registerLazySingleton<GoodsRepository>(() => GoodsRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

// Datasources

  // Auth DataSource
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sharedPreferences: sl()));

  // Goods DataSource
  sl.registerLazySingleton<GoodsRemoteDataSource>(
      () => GoodsRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<GoodsLocalDataSource>(
      () => GoodsLocalDataSourceImpl(sharedPreferences: sl()));

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
