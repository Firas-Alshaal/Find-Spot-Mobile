part of 'map_bloc.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {}

class GetLocationProgressState extends MapState {}

class GetLocationSuccessState extends MapState {
   final MapModel mapModel;

   const GetLocationSuccessState({required this.mapModel});

  @override
  List<Object> get props => [mapModel];
}

class ErrorGetLocationState extends MapState {
  final String message;

  const ErrorGetLocationState({required this.message});

  @override
  List<Object> get props => [message];
}
