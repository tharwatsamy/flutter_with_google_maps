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
        zoom: 12, target: LatLng(31.187084851056554, 29.928110526889437));

    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  late GoogleMapController googleMapController;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
            onMapCreated: (controller) {
              googleMapController = controller;
            },
            // cameraTargetBounds: CameraTargetBounds(LatLngBounds(
            //     southwest: const LatLng(31.080569617326795, 29.763491041232577),
            //     northeast: const LatLng(31.30846738149212, 30.169298507189573))),
            initialCameraPosition: initialCameraPostion),
        Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: ElevatedButton(
                onPressed: () {}, child: const Text('Change location'))),
      ],
    );
  }
}

// world view 0 -> 3
// country view 4-> 6
// city view 10 -> 12
// street view 13 -> 17
// building view 18 -> 20