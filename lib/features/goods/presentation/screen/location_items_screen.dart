import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:lost_find_tracker/core/network/authrization.dart';
import 'package:lost_find_tracker/core/utils/constant.dart';
import 'package:lost_find_tracker/core/strings/failures.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/itemType.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/lostItem.dart';
import 'package:lost_find_tracker/features/goods/presentation/bloc/goods/goods_bloc.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/error_snackbar.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/wait_location_items.dart';
import 'package:lost_find_tracker/injection_container.dart' as di;

class LocationItemsScreen extends StatefulWidget {
  const LocationItemsScreen({Key? key}) : super(key: key);

  @override
  State<LocationItemsScreen> createState() => _LocationItemsScreenState();
}

class _LocationItemsScreenState extends State<LocationItemsScreen> {
  late GoogleMapController _mapController;

  late LatLng _initialPosition = const LatLng(25.2048, 55.2708);

  GoogleMapController get mapController => _mapController;

  final Set<Marker> _markers = {};

  bool isLoading = true;

  Uint8List? markerIcon;

  Set<Marker> get markers => _markers;

  Future<Uint8List?> _getMarkerIconFromNetwork(String imageUrl) async {
    final http.Response response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      final Uint8List markerIcon = response.bodyBytes;
      return markerIcon;
    }
    return null;
  }

  Future<BitmapDescriptor> getResizedBitmapDescriptor(
      Uint8List imageData, double size) async {
    Uint8List resizedImageData = await FlutterImageCompress.compressWithList(
      imageData,
      minHeight: size.toInt(),
      minWidth: size.toInt(),
    );

    return BitmapDescriptor.fromBytes(resizedImageData);
  }

  void _loadMarkers(List<LostItem> listItems) async {
    _markers.clear();
    for (var item in listItems) {
      markerIcon = true //item.images!.isEmpty
          ? null
          : await _getMarkerIconFromNetwork(item.images!.first);
      markers.add(Marker(
        markerId: MarkerId(item.id!),
        icon: markerIcon == null
            ? BitmapDescriptor.defaultMarkerWithHue(item.isLost!
                ? BitmapDescriptor.hueBlue
                : BitmapDescriptor.hueRed)
            : await getResizedBitmapDescriptor(markerIcon!, 100),
        position: LatLng(item.location!.last, item.location!.first),
        infoWindow: InfoWindow(
          title: item.name,
        ),
      ));
    }

    setState(() {
      isLoading = false;
    });
  }

  void onCameraMove(CameraPosition position) async {
    debugPrint(position.target.toString());
    _initialPosition = position.target;
  }

  void onCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => di.sl<GoodsBloc>()
          ..add(const GetLostItemsEvent(itemType: ItemType.BOTH)),
        child: Scaffold(
          body: BlocConsumer<GoodsBloc, GoodsState>(
            listener: (context, state) {
              if (state is GetLostItemsSuccessState) {
                _loadMarkers(state.items);
              } else if (state is ErrorGoodsState) {
                setState(() {
                  isLoading = false;
                });
                showSuccessSnackBar(context, state.message, Colors.red);
                Navigator.pop(context);
                if (state.message == Authorization_FAILURE_MESSAGE) {
                  logout(context);
                }
              }
            },
            builder: (context, state) {
              if (state is LoadingGoodsState && isLoading) {
                return WaitLocationItems(
                  onCreated: onCreated,
                  onCameraMove: onCameraMove,
                );
              }
              return GoogleMap(
                zoomControlsEnabled: true,
                zoomGesturesEnabled: true,
                mapType: MapType.normal,
                mapToolbarEnabled: true,
                markers: _markers,
                onCameraMove: onCameraMove,
                initialCameraPosition:
                    CameraPosition(zoom: 4, target: _initialPosition),
                onMapCreated: onCreated,
              );
            },
          ),
        ));
  }
}
