import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lost_find_tracker/core/error/failures.dart';
import 'package:lost_find_tracker/core/strings/failures.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/itemType.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/lostItem.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/search.dart';
import 'package:lost_find_tracker/features/goods/domain/usecases/getLostItems.dart';
import 'package:lost_find_tracker/features/goods/domain/usecases/lostItem.dart';
import 'package:lost_find_tracker/features/goods/domain/usecases/searchItem.dart';

part 'goods_event.dart';

part 'goods_state.dart';

class GoodsBloc extends Bloc<GoodsEvent, GoodsState> {
  final LostItemUseCase lostItemUseCase;

  final GetLostItemUseCase getLostItemUseCase;
  final SearchItemUseCase searchItemUseCase;

  GoodsBloc({
    required this.lostItemUseCase,
    required this.getLostItemUseCase,
    required this.searchItemUseCase,
  }) : super(GoodsInitial()) {
    on<GoodsEvent>((event, emit) async {
      if (event is AddLostItemEvent) {
        emit(LoadingGoodsState());

        final failureOrAddLostItem =
            await lostItemUseCase(event.lostItem, event.itemType);
        emit(_mapFailureOrAddGoodsToState(failureOrAddLostItem));
      } else if (event is GetLostItemsEvent) {
        emit(LoadingGoodsState());

        final failureOrGetFoundItems = await getLostItemUseCase(event.itemType);
        emit(_mapFailureOrGetLostItemsToState(failureOrGetFoundItems));
      } else if (event is GetSearchItemsEvent) {
        emit(LoadingGoodsState());

        final failureOrGetFoundItems = await searchItemUseCase(event.search);
        emit(_mapFailureOrGetLostItemsToState(failureOrGetFoundItems));
      } else if (event is EmptyEvent) {
        emit(GoodsInitial());
      }
    });
  }

  GoodsState _mapFailureOrAddGoodsToState(Either<Failure, Unit> either) {
    return either.fold(
      (failure) => ErrorGoodsState(message: _mapFailureToMessage(failure)),
      (data) => AddGoodsSuccessState(),
    );
  }

  GoodsState _mapFailureOrGetLostItemsToState(
      Either<Failure, List<LostItem>> either) {
    return either.fold(
      (failure) => ErrorGoodsState(message: _mapFailureToMessage(failure)),
      (data) => GetLostItemsSuccessState(items: data),
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
      case AuthorizationFailure:
        return Authorization_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
