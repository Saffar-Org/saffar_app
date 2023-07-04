import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:saffar_app/core/constants/strings.dart';

class ViewMapScreen extends StatefulWidget {
  const ViewMapScreen({Key? key}) : super(key: key);

  static const String routeName = '/view_map';

  @override
  State<ViewMapScreen> createState() => _ViewMapScreenState();
}

class _ViewMapScreenState extends State<ViewMapScreen> {
  final LatLng _tomTomHq = LatLng(32.43, 74.54);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: _tomTomHq,
          zoom: 3, // 0 to 22 where 0 is whole Earth

        ),
        layers: [
          TileLayerOptions(
            urlTemplate:
                "https://api.tomtom.com/map/1/tile/basic/night/{z}/{x}/{y}.png?key=${Strings.mapApiKey}",
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                point: _tomTomHq,
                anchorPos: AnchorPos.align(AnchorAlign.top),
                builder: (context) {
                  return const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
