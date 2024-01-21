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

    initPolygons();
    super.initState();
  }

  late GoogleMapController googleMapController;

  Set<Polygon> ploygons = {};
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      polygons: ploygons,
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

  void initPolygons() {
    Polygon polygon = Polygon(
        holes: const [
          [
            LatLng(25.030949373562184, 29.71903473330491),
            LatLng(28.753297577743304, 26.950480244745513),
            LatLng(29.673819683117372, 34.245401595552806),
          ]
        ],
        strokeWidth: 3,
        fillColor: Colors.black.withOpacity(.5),
        points: const [
          LatLng(31.5, 25.0),
          LatLng(31.5, 28.0),
          LatLng(31.2, 30.0),
          LatLng(31.0, 32.0),
          LatLng(31.0, 34.0),
          LatLng(31.0, 34.0),
          LatLng(29.5, 34.5),
          LatLng(28.0, 34.5),
          LatLng(25.0, 34.0),
          LatLng(25.0, 34.0),
          LatLng(22.0, 36.0),
          LatLng(22.0, 36.0),
          LatLng(22.0, 31.0),
          LatLng(22.0, 25.0),
          LatLng(22.0, 25.0),
          LatLng(25.0, 25.0),
          LatLng(31.5, 25.0)
        ],
        polygonId: const PolygonId('1'));
    ploygons.add(polygon);
  }
}
// world view 0 -> 3
// country view 4-> 6
// city view 10 -> 12
// street view 13 -> 17
// building view 18 -> 20