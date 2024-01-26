import 'package:flutter/material.dart';
import 'package:flutter_with_google_maps/utils/location_service.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPostion;

  late LocationService locationService;
  @override
  void initState() {
    initialCameraPostion = const CameraPosition(
        zoom: 17, target: LatLng(31.187084851056554, 29.928110526889437));
    locationService = LocationService();
    updateMyLocation();
    super.initState();
  }

  GoogleMapController? googleMapController;

  Set<Marker> markers = {};
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      markers: markers,
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

  void updateMyLocation() async {
    await locationService.checkAndRequestLocationService();
    var hasPermission =
        await locationService.checkAndRequestLocationPermission();
    if (hasPermission) {
      locationService.getRealTimeLocationData((locationData) {
        setMyLocationMarker(locationData);
        setMyCameraPosition(locationData);
      });
    } else {}
  }

  void setMyCameraPosition(LocationData locationData) {
    var camerPosition = CameraPosition(
        target: LatLng(locationData.latitude!, locationData.longitude!),
        zoom: 15);

    googleMapController
        ?.animateCamera(CameraUpdate.newCameraPosition(camerPosition));
  }

  void setMyLocationMarker(LocationData locationData) {
    var myLocationMarker = Marker(
        markerId: const MarkerId('my_location_marker'),
        position: LatLng(locationData.latitude!, locationData.longitude!));

    markers.add(myLocationMarker);
    setState(() {});
  }
}


// inquire about location service
// request permission
// get location
// display
