part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class GetLocationEvent extends MapEvent {
  final MapItem mapItem;

  const GetLocationEvent({required this.mapItem});

  @override
  List<Object> get props => [mapItem];
}
