import 'package:dartz/dartz.dart';
import 'package:lost_find_tracker/core/error/exceptions.dart';
import 'package:lost_find_tracker/core/error/failures.dart';
import 'package:lost_find_tracker/core/network/network_info.dart';
import 'package:lost_find_tracker/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:lost_find_tracker/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:lost_find_tracker/features/auth/data/models/auth_model.dart';
import 'package:lost_find_tracker/features/auth/data/models/user_model.dart';
import 'package:lost_find_tracker/features/auth/domain/entities/user.dart';
import 'package:lost_find_tracker/features/auth/domain/repositories/auth_repository.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/category.dart';

typedef Future<AuthUser> LoginOrRegister();

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, AuthUser>> login(User loginData) async {
    final UserModel loginModel =
        UserModel(email: loginData.email, password: loginData.password);
    return await _addAuth(() {
      return remoteDataSource.login(loginModel);
    });
  }

  @override
  Future<Either<Failure, AuthUser>> register(User registerData) async {
    return await _addAuth(() {
      return remoteDataSource.register(registerData);
    });
  }

  @override
  Future<Either<Failure, UserModel>> editUser(User editUser) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await remoteDataSource.editUser(editUser);
        localDataSource.saveUser(user);
        return Right(user);
      } on ServerException {
        return Left(ServerFailure());
      } on ValidateException catch (e) {
        return Left(VerificationFailure(e.message));
      }
    } else {
      try {
        final user = await localDataSource.loadUser();
        return Right(user);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Category>>> categories() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteLostItems = await remoteDataSource.categories();
        localDataSource.saveCategories(remoteLostItems);
        return Right(remoteLostItems);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localLostItem = await localDataSource.loadCategories();
        return Right(localLostItem);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  Future<Either<Failure, AuthUser>> _addAuth(
      LoginOrRegister loginOrRegister) async {
    if (await networkInfo.isConnected) {
      try {
        final user = await loginOrRegister();
        localDataSource.cacheToken(user.accessToken);
        localDataSource.saveUser(user.user);
        return Right(user);
      } on ValidateException catch (e) {
        return Left(VerificationFailure(e.message));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
