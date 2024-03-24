import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lost_find_tracker/core/error/failures.dart';
import 'package:lost_find_tracker/core/strings/failures.dart';
import 'package:lost_find_tracker/features/auth/data/models/auth_model.dart';
import 'package:lost_find_tracker/features/auth/data/models/user_model.dart';
import 'package:lost_find_tracker/features/auth/domain/entities/user.dart';
import 'package:lost_find_tracker/features/auth/domain/usecases/category.dart';
import 'package:lost_find_tracker/features/auth/domain/usecases/edit_user.dart';
import 'package:lost_find_tracker/features/auth/domain/usecases/login.dart';
import 'package:lost_find_tracker/features/auth/domain/usecases/register.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/category.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final CategoryUseCase categoryUseCase;
  final EditUserUseCase editUserUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.categoryUseCase,
    required this.editUserUseCase,
  }) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoadingAuthState());
        final failureOrLogin = await loginUseCase(event.login);
        emit(_mapFailureOrAuthToState(failureOrLogin));
      } else if (event is RegisterEvent) {
        emit(LoadingAuthState());

        final failureOrRegister = await registerUseCase(event.register);
        emit(_mapFailureOrAuthToState(failureOrRegister));
      } else if (event is EditUserEvent) {
        emit(LoadingAuthState());

        final failureOrEdit = await editUserUseCase(event.user);
        emit(failureOrEdit.fold(
          (failure) => ErrorAuthState(message: _mapFailureToMessage(failure)),
          (data) => EditAuthSuccessState(userModel: data),
        ));
      } else if (event is GetCategoriesEvent) {
        emit(LoadingCategoriesState());

        final failureOrCategories = await categoryUseCase();
        emit(failureOrCategories.fold(
          (failure) =>
              ErrorGetCategoriesState(message: _mapFailureToMessage(failure)),
          (data) => GetCategoriesSuccessState(categories: data),
        ));
      } else if (event is CancelAuthEvent) {
        emit(AuthInitial());
      }
    });
  }

  AuthState _mapFailureOrAuthToState(Either<Failure, AuthUser> either) {
    return either.fold(
      (failure) => ErrorAuthState(message: _mapFailureToMessage(failure)),
      (data) => AuthSuccessState(),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      case VerificationFailure:
        return (failure as VerificationFailure).errorMessage;
      default:
        return "Unexpected Error , Please try again later.";
    }
  }
}
