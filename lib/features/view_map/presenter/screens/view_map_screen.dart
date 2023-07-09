import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:saffar_app/core/constants/strings.dart';
import 'package:saffar_app/core/models/address.dart';
import 'package:saffar_app/core/utils/view_helper.dart';
import 'package:saffar_app/core/widgets/expansion_animation_widget.dart';
import 'package:saffar_app/features/search_places_and_get_route/presenter/cubits/searched_places_cubit.dart';
import 'package:saffar_app/features/search_places_and_get_route/presenter/widgets/input_pickup_and_destination_location_widget.dart';

import '../widgets/address_list_bottom_widget.dart';

class ViewMapScreen extends StatefulWidget {
  const ViewMapScreen({Key? key}) : super(key: key);

  static const String routeName = '/view_map';

  @override
  State<ViewMapScreen> createState() => _ViewMapScreenState();
}

class _ViewMapScreenState extends State<ViewMapScreen>
    with TickerProviderStateMixin {
  late final AnimationController _topSectionAnimationController;
  late final AnimationController _bottomSectionAnimationController;

  late final MapController _mapController;

  late final TextEditingController _pickupTextEditingController;
  late final TextEditingController _destinationTextEditingController;

  late final FocusNode _pickupFocusNode;
  late final FocusNode _destinationFocusNode;

  late final SearchedPlacesCubit _searchedPlacesCubit;

  Address? _pickupAddress;
  Address? _destinationAddress;

  bool _showUpButton = false;
  bool _addressFromMap = false;
  bool _showRoute = false;

  void _onShowUpButtonPressed() {
    _topSectionAnimationController.reverse();
    _bottomSectionAnimationController.reverse();

    _showRoute = false;

    setState(() {});
  }

  void _onDonePressed() {
    _topSectionAnimationController.forward();
    _bottomSectionAnimationController.forward();

    if (_pickupAddress != null && _destinationAddress != null) {
      final CenterZoom newCenterZoom = _mapController.centerZoomFitBounds(
        LatLngBounds(
          _pickupAddress!.latLng,
          _destinationAddress!.latLng,
        ),
      );

      _mapController.move(
        newCenterZoom.center,
        newCenterZoom.zoom - .2,
      );
    }

    _showRoute = true;

    setState(() {});
  }

  void _onAddressSelected(Address address) {
    if (_pickupFocusNode.hasFocus) {
      _pickupTextEditingController.text = ViewHelper.getAddress(address);

      _pickupAddress = address;

      _mapController.move(address.latLng, 13);

      _pickupFocusNode.unfocus();
      _destinationFocusNode.requestFocus();
    } else if (_destinationFocusNode.hasFocus) {
      _destinationTextEditingController.text = ViewHelper.getAddress(address);

      _destinationAddress = address;

      _mapController.move(address.latLng, 13);

      _destinationFocusNode.unfocus();
    }

    _addressFromMap = false;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _searchedPlacesCubit = SearchedPlacesCubit();
    _mapController = MapController();
    _pickupTextEditingController = TextEditingController();
    _destinationTextEditingController = TextEditingController();
    _pickupFocusNode = FocusNode();
    _destinationFocusNode = FocusNode();

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

    _mapController.mapEventStream.listen((event) async {
      if (_addressFromMap) {
        if (_pickupFocusNode.hasFocus) {
          final double lat = _mapController.center.latitude;
          final double lon = _mapController.center.longitude;

          _pickupTextEditingController.text = 'Loading...';

          _pickupAddress = await _searchedPlacesCubit.getAddressFromLatLon(
            context,
            lat,
            lon,
          );

          if (_pickupAddress != null) {
            _pickupTextEditingController.text = ViewHelper.getAddress(
              _pickupAddress!,
            );
          } else {
            _pickupTextEditingController.clear();
          }
        } else if (_destinationFocusNode.hasFocus) {
          final double lat = _mapController.center.latitude;
          final double lon = _mapController.center.longitude;

          _destinationTextEditingController.text = 'Loading...';

          _destinationAddress = await _searchedPlacesCubit.getAddressFromLatLon(
            context,
            lat,
            lon,
          );

          if (_destinationAddress != null) {
            _destinationTextEditingController.text = ViewHelper.getAddress(
              _destinationAddress!,
            );
          } else {
            _destinationTextEditingController.clear();
          }
        }
      }

      _addressFromMap = true;

      setState(() {});
    });

    _pickupTextEditingController.addListener(() {
      final String searchText = _pickupTextEditingController.text;
      if (searchText.trim().isNotEmpty) {
        _searchedPlacesCubit.searchPlaces(context, searchText);
      }

      if (searchText.isEmpty) {
        _pickupAddress = null;
      }
    });

    _destinationTextEditingController.addListener(() {
      final String searchText = _destinationTextEditingController.text;
      if (searchText.trim().isNotEmpty) {
        _searchedPlacesCubit.searchPlaces(context, searchText);
      }

      if (searchText.isEmpty) {
        _destinationAddress = null;
      }
    });

    _pickupFocusNode.addListener(() {
      if (_pickupFocusNode.hasFocus && _pickupAddress != null) {
        _mapController.move(
          _pickupAddress!.latLng,
          13,
        );
      }
    });

    _destinationFocusNode.addListener(() {
      if (_destinationFocusNode.hasFocus && _destinationAddress != null) {
        _mapController.move(
          _destinationAddress!.latLng,
          13,
        );
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
                    if (_pickupFocusNode.hasFocus)
                      Marker(
                        point: _mapController.center,
                        anchorPos: AnchorPos.align(AnchorAlign.top),
                        rotate: true,
                        builder: (context) {
                          return Icon(
                            Icons.location_history,
                            color: colorScheme.primary,
                            size: 40,
                          );
                        },
                      ),
                    if (_destinationFocusNode.hasFocus)
                      Marker(
                        point: _mapController.center,
                        anchorPos: AnchorPos.align(AnchorAlign.top),
                        rotate: true,
                        builder: (context) {
                          return Icon(
                            Icons.location_history_rounded,
                            color: colorScheme.primary,
                            size: 40,
                          );
                        },
                      ),
                    if (_pickupAddress != null && _showRoute)
                      Marker(
                        point: _pickupAddress!.latLng,
                        anchorPos: AnchorPos.align(AnchorAlign.top),
                        rotate: true,
                        builder: (context) {
                          return Icon(
                            Icons.location_history,
                            color: colorScheme.primary,
                            size: 40,
                          );
                        },
                      ),
                    if (_destinationAddress != null && _showRoute)
                      Marker(
                        point: _destinationAddress!.latLng,
                        anchorPos: AnchorPos.align(AnchorAlign.top),
                        rotate: true,
                        builder: (context) {
                          return Icon(
                            Icons.location_history_rounded,
                            color: colorScheme.primary,
                            size: 40,
                          );
                        },
                      ),
                  ],
                ),
              ],
            ),

            // Input and Destiantion Picker top widget
            SingleChildScrollView(
              child: SizedBox(
                height: _showUpButton ? 260 : size.height,
                width: double.infinity,
                child: Column(
                  children: [
                    ExpansionAnimationWidget(
                      controller: _topSectionAnimationController,
                      child: InputPickupAndDestinationLocationWidget(
                        onDonePressed: _pickupAddress != null &&
                                _destinationAddress != null
                            ? () => _onDonePressed()
                            : null,
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
