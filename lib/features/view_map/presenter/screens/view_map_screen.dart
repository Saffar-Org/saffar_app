import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:saffar_app/core/constants/strings.dart';
import 'package:saffar_app/core/widgets/expansion_animation_widget.dart';
import 'package:saffar_app/features/search_places/presenter/widgets/input_pickup_and_destination_location_widget.dart';

import '../widgets/address_list_bottom_widget.dart';

class ViewMapScreen extends StatefulWidget {
  const ViewMapScreen({Key? key}) : super(key: key);

  static const String routeName = '/view_map';

  @override
  State<ViewMapScreen> createState() => _ViewMapScreenState();
}

class _ViewMapScreenState extends State<ViewMapScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animatedController;

  final LatLng _tomTomHq = LatLng(32.43, 74.54);

  @override
  void initState() {
    super.initState();

    _animatedController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _animatedController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map
          FlutterMap(
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

          // Input and Destiantion Picker top widget
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ExpansionAnimationWidget(
              controller: _animatedController,
              child: const InputPickupAndDestinationLocationWidget(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AddressListBottomWidget(),
    );
  }
}
