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

    updateMyLocation();
    super.initState();
  }

  GoogleMapController? googleMapController;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      zoomControlsEnabled: false,
      onMapCreated: (controller) {
        googleMapController = controller;
        initMapStyle();
      },
      initialCameraPosition: initialCameraPostion,
    );
  }

  void initMapStyle() async {
    var nightMapStyle = await DefaultAssetBundle.of(context)
        .loadString('assets/map_syles/night_map_style.json');

    googleMapController!.setMapStyle(nightMapStyle);
  }

  Future<void> checkAndRequestLocationService() async {
    var isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        // TODO: show error bar
      }
    }
  }

  Future<bool> checkAndRequestLocationPermission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      return false;
    }
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return false;
      }
    }

    return true;
  }

  void getLocationdata() {
    location.onLocationChanged.listen(
      (locationData) {
        var camerPosition = CameraPosition(
            target: LatLng(locationData.latitude!, locationData.longitude!),
            zoom: 15);
        googleMapController
            ?.animateCamera(CameraUpdate.newCameraPosition(camerPosition));
      },
    );
  }

  void updateMyLocation() async {
    await checkAndRequestLocationService();
    var hasPermission = await checkAndRequestLocationPermission();
    if (hasPermission) {
      getLocationdata();
    } else {}
  }
}


// inquire about location service
// request permission
// get location
// display
