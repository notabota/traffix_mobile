import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:traffix/pages/cameras/cameras.dart';
import 'package:traffix/pages/notifications/notifications.dart';
import 'package:traffix/pages/roads/roads.dart';
import 'package:traffix/pages/settings.dart';
import 'package:traffix/pages/discovery/discovery.dart';

import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:traffix/pages/navigation/navigation.dart';

import 'dart:math' show cos, sqrt, asin;

import 'package:material_dialogs/material_dialogs.dart' as dialog;
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

class TrafficMap extends StatefulWidget {
  const TrafficMap({Key? key}) : super(key: key);

  @override
  TrafficMapState createState() => TrafficMapState();
}

class TrafficMapState extends State<TrafficMap> {
  final CameraPosition _initialLocation =
  const CameraPosition(target: LatLng(0.0, 0.0));
  late GoogleMapController mapController;

  late BitmapDescriptor markerIcon;
  late Position _currentPosition;
  String _currentAddress = '';

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();

  String _startAddress = '';
  String _destinationAddress = '';
  String? _placeDistance;

  Set<Marker> markers = {};

  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)),
        'assets/imgs/marker_icon.png')
        .then((onValue) {
      markerIcon = onValue;
    });

    super.initState();
    _getCurrentLocation();
  }

  Widget _textField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String hint,
    required double width,
    required Icon prefixIcon,
    Widget? suffixIcon,
    required Function(String) locationCallback,
  }) {
    return SizedBox(
      width: width * 0.8,
      child: TextField(
        onChanged: (value) {
          locationCallback(value);
        },
        controller: controller,
        focusNode: focusNode,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.blue.shade300,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.all(15),
          hintText: hint,
        ),
      ),
    );
  }

  // Method for retrieving the current location
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        print('CURRENT POS: $_currentPosition');
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
      await _getAddress();
    }).catchError((e) {
      print(e);
    });
  }

  // Method for retrieving the address
  _getAddress() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
        "${place.name}, ${place.locality}, ${place.postalCode}, ${place
            .country}";
        startAddressController.text = _currentAddress;
        _startAddress = _currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  // Method for calculating the distance between two places
  Future<bool> _calculateDistance() async {
    try {
      // Retrieving placemarks from addresses
      List<Location> startPlacemark = await locationFromAddress(_startAddress);
      List<Location> destinationPlacemark =
      await locationFromAddress(_destinationAddress);

      // Use the retrieved coordinates of the current position,
      // instead of the address if the start position is user's
      // current position, as it results in better accuracy.
      double startLatitude = _startAddress == _currentAddress
          ? _currentPosition.latitude
          : startPlacemark[0].latitude;

      double startLongitude = _startAddress == _currentAddress
          ? _currentPosition.longitude
          : startPlacemark[0].longitude;

      double destinationLatitude = destinationPlacemark[0].latitude;
      double destinationLongitude = destinationPlacemark[0].longitude;

      String startCoordinatesString = '($startLatitude, $startLongitude)';
      String destinationCoordinatesString =
          '($destinationLatitude, $destinationLongitude)';

      // Start Location Marker
      Marker startMarker = Marker(
        markerId: MarkerId(startCoordinatesString),
        position: LatLng(startLatitude, startLongitude),
        infoWindow: InfoWindow(
          title: 'Start $startCoordinatesString',
          snippet: _startAddress,
        ),
        icon: markerIcon,
        consumeTapEvents: true,
        onTap: () =>
            dialog.Dialogs.materialDialog(
              color: Colors.white,
              msg: 'Congratulations, you won 500 points',
              title: 'Congratulations',
              customView: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'assets/imgs/marker_icon - Copy - Copy.png',
                  fit: BoxFit.contain,
                ),
              ),
              dialogWidth: kIsWeb ? 0.3 : null,
              context: context,
              actions: [
                IconsButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  text: 'Claim',
                  iconData: Icons.done,
                  color: Colors.blue,
                  textStyle: const TextStyle(color: Colors.white),
                  iconColor: Colors.white,
                ),
              ],
            ),
      );

      // Destination Location Marker
      Marker destinationMarker = Marker(
        markerId: MarkerId(destinationCoordinatesString),
        position: LatLng(destinationLatitude, destinationLongitude),
        infoWindow: InfoWindow(
          title: 'Destination $destinationCoordinatesString',
          snippet: _destinationAddress,
        ),
        icon: markerIcon,
        consumeTapEvents: true,
        onTap: () =>
            dialog.Dialogs.materialDialog(
              color: Colors.white,
              msg: 'Congratulations, you won 500 points',
              title: 'Congratulations',
              customView: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'assets/imgs/marker_icon - Copy - Copy.png',
                  fit: BoxFit.contain,
                ),
              ),
              dialogWidth: kIsWeb ? 0.3 : null,
              context: context,
              actions: [
                IconsButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  text: 'Claim',
                  iconData: Icons.done,
                  color: Colors.blue,
                  textStyle: const TextStyle(color: Colors.white),
                  iconColor: Colors.white,
                ),
              ],
            ),
      );

      // Adding the markers to the list
      markers.add(startMarker);
      markers.add(destinationMarker);

      print(
        'START COORDINATES: ($startLatitude, $startLongitude)',
      );
      print(
        'DESTINATION COORDINATES: ($destinationLatitude, $destinationLongitude)',
      );

      // Calculating to check that the position relative
      // to the frame, and pan & zoom the camera accordingly.
      double miny = (startLatitude <= destinationLatitude)
          ? startLatitude
          : destinationLatitude;
      double minx = (startLongitude <= destinationLongitude)
          ? startLongitude
          : destinationLongitude;
      double maxy = (startLatitude <= destinationLatitude)
          ? destinationLatitude
          : startLatitude;
      double maxx = (startLongitude <= destinationLongitude)
          ? destinationLongitude
          : startLongitude;

      double southWestLatitude = miny;
      double southWestLongitude = minx;

      double northEastLatitude = maxy;
      double northEastLongitude = maxx;

      // Accommodate the two locations within the
      // camera view of the map
      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(northEastLatitude, northEastLongitude),
            southwest: LatLng(southWestLatitude, southWestLongitude),
          ),
          100.0,
        ),
      );

      // Calculating the distance between the start and the end positions
      // with a straight path, without considering any route
      // double distanceInMeters = await Geolocator.bearingBetween(
      //   startLatitude,
      //   startLongitude,
      //   destinationLatitude,
      //   destinationLongitude,
      // );

      await _createPolylines(startLatitude, startLongitude, destinationLatitude,
          destinationLongitude);

      double totalDistance = 0.0;

      // Calculating the total distance by adding the distance
      // between small segments
      for (int i = 0; i < polylineCoordinates.length - 1; i++) {
        totalDistance += _coordinateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude,
        );
      }

      setState(() {
        _placeDistance = totalDistance.toStringAsFixed(2);
        print('DISTANCE: $_placeDistance km');
      });

      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  // Formula for calculating distance between two coordinates
  // https://stackoverflow.com/a/54138876/11910277
  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  // Create the polylines for showing the route between two places
  _createPolylines(double startLatitude,
      double startLongitude,
      double destinationLatitude,
      double destinationLongitude,) async {
    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      dotenv.env['GOOGLE_MAP_API_KEY']!, // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.driving,
    );

    print("Error ${result.errorMessage}");

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    PolylineId id = const PolylineId('directions');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 7,
      zIndex: 100,
      consumeTapEvents: true,
      onTap: () =>
          dialog.Dialogs.materialDialog(
            color: Colors.white,
            msg: 'Thông tin đường',
            title: 'Congratulations',
            customView: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                'assets/imgs/marker_icon - Copy - Copy.png',
                fit: BoxFit.contain,
              ),
            ),
            dialogWidth: kIsWeb ? 0.3 : null,
            context: context,
            actions: [
              IconsButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: 'Claim',
                iconData: Icons.done,
                color: Colors.blue,
                textStyle: const TextStyle(color: Colors.white),
                iconColor: Colors.white,
              ),
            ],
          ),
    );
    polylines[id] = polyline;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return SizedBox(
      height: height,
      width: width,
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            // Map View
            GoogleMap(
              trafficEnabled: true,
              markers: Set<Marker>.from(markers),
              initialCameraPosition: _initialLocation,
              myLocationEnabled: true,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              myLocationButtonEnabled: true,
              polylines: Set<Polyline>.of(polylines.values),
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),
            // Show zoom buttons
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(
                      child: Material(
                        color: Colors.blue.shade100, // button color
                        child: InkWell(
                          splashColor: Colors.blue, // inkwell color
                          child: const SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(Icons.add),
                          ),
                          onTap: () {
                            mapController.animateCamera(
                              CameraUpdate.zoomIn(),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ClipOval(
                      child: Material(
                        color: Colors.blue.shade100, // button color
                        child: InkWell(
                          splashColor: Colors.blue, // inkwell color
                          child: const SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(Icons.remove),
                          ),
                          onTap: () {
                            mapController.animateCamera(
                              CameraUpdate.zoomOut(),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Show the place input fields & button for
            // showing the route
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    width: width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text(
                            'Map',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          const SizedBox(height: 10),
                          _textField(
                              label: 'Điểm di chuyển',
                              hint: 'Chọn nơi bắt đầu',
                              prefixIcon: const Icon(Icons.looks_one),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.my_location),
                                onPressed: () {
                                  startAddressController.text = _currentAddress;
                                  _startAddress = _currentAddress;
                                },
                              ),
                              controller: startAddressController,
                              focusNode: startAddressFocusNode,
                              width: width,
                              locationCallback: (String value) {
                                setState(() {
                                  _startAddress = value;
                                });
                              }),
                          const SizedBox(height: 10),
                          _textField(
                              label: 'Điểm đến',
                              hint: 'Chọn nơi kết thúc',
                              prefixIcon: const Icon(Icons.looks_two),
                              controller: destinationAddressController,
                              focusNode: desrinationAddressFocusNode,
                              width: width,
                              locationCallback: (String value) {
                                setState(() {
                                  _destinationAddress = value;
                                });
                              }),
                          const SizedBox(height: 10),
                          Visibility(
                            visible: _placeDistance == null ? false : true,
                            child: Text(
                              'DISTANCE: $_placeDistance km',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          ElevatedButton(
                            onPressed: (_startAddress != '' &&
                                _destinationAddress != '')
                                ? () async {
                              startAddressFocusNode.unfocus();
                              desrinationAddressFocusNode.unfocus();
                              setState(() {
                                if (markers.isNotEmpty) markers.clear();
                                if (polylines.isNotEmpty) {
                                  polylines.clear();
                                }
                                if (polylineCoordinates.isNotEmpty) {
                                  polylineCoordinates.clear();
                                }
                                _placeDistance = null;
                              });

                              _calculateDistance().then((isCalculated) {
                                if (isCalculated) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Distance Calculated Sucessfully'),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Error Calculating Distance'),
                                    ),
                                  );
                                }
                              });
                            }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Định hướng',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Show current location button
            SafeArea(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                  child: ClipOval(
                    child: Material(
                      color: Colors.orange.shade100, // button color
                      child: InkWell(
                        splashColor: Colors.orange, // inkwell color
                        child: const SizedBox(
                          width: 56,
                          height: 56,
                          child: Icon(Icons.my_location),
                        ),
                        onTap: () {
                          mapController.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: LatLng(
                                  _currentPosition.latitude,
                                  _currentPosition.longitude,
                                ),
                                zoom: 18.0,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  MapPageState createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  void _handleIndexChanged(index) {
    List<Widget> pages = [
      const Cameras(),
      const Roads(),
      Navigation(),
      Discovery(),
      const Notifications(),
    ];

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => pages[index]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TrafficMap(),
      extendBody: true,
      bottomNavigationBar: DotNavigationBar(
        onTap: _handleIndexChanged,
        items: [
          DotNavigationBarItem(
            icon: Icon(Icons.camera),
            selectedColor: Colors.purple,
          ),
          DotNavigationBarItem(
            icon: Icon(Icons.traffic),
            selectedColor: Colors.pink,
          ),
          DotNavigationBarItem(
            icon: Icon(Icons.map),
            selectedColor: Colors.orange,
          ),
          DotNavigationBarItem(
            icon: Icon(Icons.add_road),
            selectedColor: Colors.teal,
          ),
          DotNavigationBarItem(
            icon: Icon(Icons.notification_important),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}
