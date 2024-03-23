import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lost_find_tracker/core/utils/theme_color.dart';

class WaitLocationItems extends StatelessWidget {
  WaitLocationItems({Key? key, this.onCreated, this.onCameraMove})
      : super(key: key);

  final onCreated;
  CameraPositionCallback? onCameraMove;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          zoomControlsEnabled: true,
          zoomGesturesEnabled: true,
          mapType: MapType.normal,
          mapToolbarEnabled: true,
          markers: const {},
          onCameraMove: onCameraMove,
          initialCameraPosition:
              const CameraPosition(zoom: 4, target: LatLng(25.2048, 55.2708)),
          onMapCreated: onCreated,
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 40.0, sigmaY: 40.0),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.4,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: ColorsFave.whiteColor,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20.0,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Please wait until the items locations finish loading.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(fontSize: 20),
                  ),
                  CircularProgressIndicator(
                    backgroundColor: ColorsFave.primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
