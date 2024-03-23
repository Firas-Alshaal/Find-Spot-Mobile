import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lost_find_tracker/core/error/failures.dart';
import 'package:lost_find_tracker/core/strings/failures.dart';
import 'package:lost_find_tracker/features/goods/data/models/map_model.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/map.dart';
import 'package:lost_find_tracker/features/goods/domain/usecases/getLocation.dart';

part 'map_event.dart';

part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final GetLocationUseCase getLocationUseCase;

  MapBloc({required this.getLocationUseCase}) : super(MapInitial()) {
    on<MapEvent>((event, emit) async {
      if (event is GetLocationEvent) {
        emit(GetLocationProgressState());

        final failureOrAddLostItem = await getLocationUseCase(event.mapItem);
        emit(_mapFailureOrGetLocationToState(failureOrAddLostItem));
      }
    });
  }

  MapState _mapFailureOrGetLocationToState(Either<Failure, MapModel> either) {
    return either.fold(
      (failure) =>
          ErrorGetLocationState(message: _mapFailureToMessage(failure)),
      (data) => GetLocationSuccessState(mapModel: data),
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
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
