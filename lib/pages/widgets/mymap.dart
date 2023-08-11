import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  MyMapState createState() => MyMapState();
}

class MyMapState extends State<MyMap> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15.0),
      height: MediaQuery.of(context).size.height / 4,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
              child: GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(40, 0),
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
