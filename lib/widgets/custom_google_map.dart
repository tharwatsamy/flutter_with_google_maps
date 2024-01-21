import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPostion;

  @override
  void initState() {
    initialCameraPostion = const CameraPosition(
        zoom: 1, target: LatLng(31.187084851056554, 29.928110526889437));

    initPolyLines();
    super.initState();
  }

  Set<Marker> markers = {};

  Set<Polyline> polyLines = {};
  late GoogleMapController googleMapController;
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      polylines: polyLines,
      zoomControlsEnabled: false,
      markers: markers,
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

    googleMapController.setMapStyle(nightMapStyle);
  }

  void initPolyLines() {
    Polyline polyline = const Polyline(
        geodesic: true,
        patterns: [PatternItem.dot],
        width: 5,
        zIndex: 2,
        startCap: Cap.roundCap,
        color: Colors.red,
        polylineId: PolylineId('1'),
        points: [
          LatLng(31.146667052085522, 29.881753268076064),
          LatLng(31.183682581705128, 29.9059575204872),
          LatLng(31.178982998722887, 29.942006407056986),
          LatLng(31.209379299176593, 29.93719988884768),
        ]);
    Polyline polyline2 = const Polyline(
        width: 5,
        zIndex: 1,
        startCap: Cap.roundCap,
        color: Colors.black,
        polylineId: PolylineId('2'),
        points: [
          LatLng(-32.53225272725898, 20.961370268194745),
          LatLng(84.0278401870962, 53.83246214878455),
        ]);
    polyLines.add(polyline);
    polyLines.add(polyline2);
  }
}
// world view 0 -> 3
// country view 4-> 6
// city view 10 -> 12
// street view 13 -> 17
// building view 18 -> 20