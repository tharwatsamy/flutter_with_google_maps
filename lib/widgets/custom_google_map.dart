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

    initCircles();
    super.initState();
  }

  late GoogleMapController googleMapController;

  Set<Circle> circles = {};
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      circles: circles,
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

    googleMapController.setMapStyle(nightMapStyle);
  }

  void initCircles() {
    Circle koshryAbuTarekServiceCircle = Circle(
        fillColor: Colors.black.withOpacity(.5),
        center: const LatLng(30.050250485630052, 31.237686871310093),
        radius: 10000,
        circleId: const CircleId('1'));

    circles.add(koshryAbuTarekServiceCircle);
  }
}
// world view 0 -> 3
// country view 4-> 6
// city view 10 -> 12
// street view 13 -> 17
// building view 18 -> 20