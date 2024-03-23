import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lost_find_tracker/core/utils/assets.dart';
import 'package:lost_find_tracker/core/utils/theme_color.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/map.dart';
import 'package:lost_find_tracker/features/goods/presentation/bloc/map/map_bloc.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/error_snackbar.dart';

class PutLocationScreen extends StatelessWidget {
  PutLocationScreen({Key? key}) : super(key: key);
  late GoogleMapController _mapController;

  late LatLng _initialPosition = const LatLng(25.2048, 55.2708);

  GoogleMapController get mapController => _mapController;

  final Set<Marker> _markers = {};

  Marker? getMarker;

  Set<Marker> get markers => _markers;

  void onCameraMove(CameraPosition position) async {
    debugPrint(position.target.toString());
    _initialPosition = position.target;
  }

  void onCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    getMarker = ModalRoute.of(context)!.settings.arguments as Marker?;
    getMarker == null ? null : _markers.add(getMarker!);

    return BlocListener<MapBloc, MapState>(
      listener: (context, state) {
        if (state is ErrorGetLocationState) {
          showSuccessSnackBar(context, state.message, Colors.red);
        } else if (state is GetLocationSuccessState) {
          state.mapModel.long = _initialPosition.longitude;
          state.mapModel.lat = _initialPosition.latitude;
          Navigator.pop(context, state.mapModel);
        }
      },
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            Stack(
              fit: StackFit.passthrough,
              children: [
                GoogleMap(
                  zoomControlsEnabled: true,
                  zoomGesturesEnabled: true,
                  mapType: MapType.normal,
                  mapToolbarEnabled: true,
                  markers: markers,
                  onCameraMove: onCameraMove,
                  initialCameraPosition: CameraPosition(
                      zoom: 5,
                      target: getMarker == null
                          ? _initialPosition
                          : LatLng(getMarker!.position.latitude,
                              getMarker!.position.longitude)),
                  onMapCreated: onCreated,
                ),
                if (getMarker == null)
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      margin: const EdgeInsets.all(4),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsFave.primaryColor,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                          onPressed: () {
                            BlocProvider.of<MapBloc>(context).add(
                                GetLocationEvent(
                                    mapItem: MapItem(
                                        long: _initialPosition.longitude,
                                        lat: _initialPosition.latitude)));
                          },
                          child: const Text(
                            'Select',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          )),
                    ),
                  ),
              ],
            ),
            if (getMarker == null)
              BlocBuilder<MapBloc, MapState>(
                builder: (context, state) {
                  if (state is GetLocationProgressState) {
                    return Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          color: ColorsFave.blackColor,
                        ));
                  } else {
                    return Align(
                        alignment: Alignment.center,
                        child: Image.asset(Images.marker));
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
