import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:latlong2/latlong.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF344955),
        title: const Text("Vaccination Center"),
      ),
      body: FlutterMap(
        options: MapOptions(
          zoom: 9.0,
          center: LatLng(Get.arguments[0], Get.arguments[1]),
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: FlutterConfig.get('MAP_BOX_STYLE'),
              additionalOptions: {
                'accessToken': FlutterConfig.get('MAP_BOX_TOKEN'),
                'id': 'mapbox.mapbox-streets-v7'
              }),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(Get.arguments[0], Get.arguments[1]),
                builder: (ctx) => const Icon(
                  Icons.location_on,
                  size: 40.0,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
