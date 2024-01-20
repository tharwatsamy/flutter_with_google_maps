import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;
  final String name;
  final LatLng latLng;

  PlaceModel({required this.id, required this.name, required this.latLng});
}

List<PlaceModel> places = [
  PlaceModel(
      id: 1,
      name: 'كافيه ومطعم بابلو',
      latLng: const LatLng(31.23421656831209, 29.950389241391225)),
  PlaceModel(
      id: 1,
      name: 'مستشفي الهدايا',
      latLng: const LatLng(31.23335288295843, 29.955435384540227)),
  PlaceModel(
      id: 1,
      name: 'الهندسه للحاويات',
      latLng: const LatLng(31.236177044116396, 29.953879703242208))
];
