import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPostion;

  late Location location;
  @override
  void initState() {
    initialCameraPostion = const CameraPosition(
        zoom: 17, target: LatLng(31.187084851056554, 29.928110526889437));

    location = Location();
    checkAndRequestLocationService();

    super.initState();
  }

  late GoogleMapController googleMapController;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      zoomControlsEnabled: false,
      onMapCreated: (controller) {
        googleMapController = controller;
        initMapStyle();

        location.onLocationChanged.listen((locationData) {});
      },
      initialCameraPosition: initialCameraPostion,
    );
  }

  void initMapStyle() async {
    var nightMapStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/map_syles/night_map_style.json');

    googleMapController.setMapStyle(nightMapStyle);
  }

  void checkAndRequestLocationService() async {
    var isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        // TODO: show error bar
      }
    }

    checkAndRequestLocationPermission();
  }

  void checkAndRequestLocationPermission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();

      if (permissionStatus != PermissionStatus.granted) {
        // TODO: show error bar
      }
    }
  }
}

// inquire about location service
// request permission
// get location
// display
