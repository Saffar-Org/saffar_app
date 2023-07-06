import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:saffar_app/core/constants/strings.dart';
import 'package:saffar_app/core/models/address.dart';
import 'package:saffar_app/core/utils/view_helper.dart';
import 'package:saffar_app/core/widgets/expansion_animation_widget.dart';
import 'package:saffar_app/features/search_places/presenter/cubits/searched_places_cubit.dart';
import 'package:saffar_app/features/search_places/presenter/widgets/input_pickup_and_destination_location_widget.dart';

import '../widgets/address_list_bottom_widget.dart';

class ViewMapScreen extends StatefulWidget {
  const ViewMapScreen({Key? key}) : super(key: key);

  static const String routeName = '/view_map';

  @override
  State<ViewMapScreen> createState() => _ViewMapScreenState();
}

class _ViewMapScreenState extends State<ViewMapScreen>
    with TickerProviderStateMixin {
  LatLng? _pickupLatLng;
  LatLng? _destinationLatLng;

  late final AnimationController _topSectionAnimationController;
  late final AnimationController _bottomSectionAnimationController;

  late final MapController _mapController;

  late final TextEditingController _pickupTextEditingController;
  late final TextEditingController _destinationTextEditingController;

  late final FocusNode _pickupFocusNode;
  late final FocusNode _destinationFocusNode;

  late final SearchedPlacesCubit _searchedPlacesCubit;

  bool _showUpButton = false;

  void _onShowUpButtonPressed() {
    _topSectionAnimationController.reverse();
    _bottomSectionAnimationController.reverse();
  }

  void _onDonePressed() {
    _topSectionAnimationController.forward();
    _bottomSectionAnimationController.forward();

    if (_pickupLatLng != null && _destinationLatLng != null) {
      _mapController.centerZoomFitBounds(
        LatLngBounds(
          _pickupLatLng!,
          _destinationLatLng!,
        ),
      );
    }

    setState(() {});
  }

  void _onAddressSelected(Address address) {
    if (_pickupFocusNode.hasFocus) {
      _pickupTextEditingController.text = ViewHelper.getAddress(address);

      _pickupLatLng = address.latLng;

      _mapController.move(_pickupLatLng!, 13);

      _pickupFocusNode.unfocus();
      _destinationFocusNode.requestFocus();
    } else if (_destinationFocusNode.hasFocus) {
      _destinationTextEditingController.text = ViewHelper.getAddress(address);

      _destinationLatLng = address.latLng;

      _mapController.move(_destinationLatLng!, 13);

      _destinationFocusNode.unfocus();
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _topSectionAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _bottomSectionAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _bottomSectionAnimationController.addListener(() {
      setState(() {
        _showUpButton = _bottomSectionAnimationController.isCompleted;
      });
    });

    _mapController = MapController();

    _pickupTextEditingController = TextEditingController();
    _destinationTextEditingController = TextEditingController();

    _pickupFocusNode = FocusNode();
    _destinationFocusNode = FocusNode();

    _searchedPlacesCubit = SearchedPlacesCubit();

    _pickupTextEditingController.addListener(() {
      final String searchText = _pickupTextEditingController.text;
      if (searchText.trim().isNotEmpty) {
        _searchedPlacesCubit.searchPlaces(context, searchText);
      }
    });

    _destinationTextEditingController.addListener(() {
      final String searchText = _destinationTextEditingController.text;
      if (searchText.trim().isNotEmpty) {
        _searchedPlacesCubit.searchPlaces(context, searchText);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _topSectionAnimationController.dispose();
    _bottomSectionAnimationController.dispose();

    _mapController.dispose();

    _pickupTextEditingController.dispose();
    _destinationTextEditingController.dispose();

    _pickupFocusNode.dispose();
    _destinationFocusNode.dispose();

    _searchedPlacesCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final Size size = MediaQuery.of(context).size;

    return BlocProvider.value(
      value: _searchedPlacesCubit,
      child: Scaffold(
        body: Stack(
          children: [
            // Map
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: LatLng(40, 30),
                zoom: 13, // 0 to 22 where 0 is whole Earth
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://api.tomtom.com/map/1/tile/basic/night/{z}/{x}/{y}.png?key=${Strings.mapApiKey}",
                ),
                MarkerLayerOptions(
                  markers: [
                    if (_pickupLatLng != null)
                      Marker(
                        point: _pickupLatLng!,
                        anchorPos: AnchorPos.align(AnchorAlign.top),
                        builder: (context) {
                          return const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 40,
                          );
                        },
                      ),
                    if (_destinationLatLng != null)
                      Marker(
                        point: _destinationLatLng!,
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
              bottom: 0,
              left: 0,
              right: 0,
              child: SingleChildScrollView(
                child: SizedBox(
                  height: size.height,
                  width: double.infinity,
                  child: Column(
                    children: [
                      ExpansionAnimationWidget(
                        controller: _topSectionAnimationController,
                        child: InputPickupAndDestinationLocationWidget(
                          onDonePressed: _destinationLatLng == null ||
                                  _pickupLatLng == null
                              ? null
                              : () => _onDonePressed(),
                          pickupTextEditingController:
                              _pickupTextEditingController,
                          destinationTextEditingController:
                              _destinationTextEditingController,
                          pickupFocusNode: _pickupFocusNode,
                          destinationFocusNode: _destinationFocusNode,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: AddressListBottomWidget(
                            onAddressSelected: (address) {
                              _onAddressSelected(address);
                            },
                            animationController:
                                _bottomSectionAnimationController,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: _showUpButton
            ? FloatingActionButton(
                onPressed: () {
                  _onShowUpButtonPressed();
                },
                backgroundColor: colorScheme.background,
                child: Icon(
                  Icons.keyboard_arrow_up_rounded,
                  color: colorScheme.primary,
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
