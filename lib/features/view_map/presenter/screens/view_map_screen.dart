import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:saffar_app/core/constants/nums.dart';
import 'package:saffar_app/core/constants/strings.dart';
import 'package:saffar_app/core/models/address.dart';
import 'package:saffar_app/core/utils/view_helper.dart';
import 'package:saffar_app/core/widgets/expansion_animation_widget.dart';
import 'package:saffar_app/features/find_ride/presenter/cubits/ride_driver_cubit.dart';
import 'package:saffar_app/features/find_ride/presenter/widgets/ride_driver_info_widget.dart';
import 'package:saffar_app/features/ride/presenter/cubits/ride_cubit.dart';
import 'package:saffar_app/features/search_places_and_get_route/presenter/cubits/map_route_cubit.dart';
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
  late final MapRouteCubit _mapRouteCubit;
  late final RideDriverCubit _rideDriverCubit;
  late final RideCubit _rideCubit;

  Address? _pickupAddress;
  Address? _destinationAddress;

  bool _showUpButton = false;
  bool _addressFromMap = false;

  /// Show source to destination route of user
  bool _showRoute = false;

  bool _showDemoRideCountDown = false;

  int _countDownNumber = 10;

  void _onShowUpButtonPressed() {
    _topSectionAnimationController.reverse();
    _bottomSectionAnimationController.reverse();

    _mapRouteCubit.clearRoute();

    _showRoute = false;

    setState(() {});
  }

  void _onDonePressed() async {
    _showUpButton = false;
    _bottomSectionAnimationController.removeListener(() {});
    setState(() {});

    if (_pickupAddress != null && _destinationAddress != null) {
      final LatLng sourceLatLng = _pickupAddress!.latLng;
      final LatLng destinationLatLng = _destinationAddress!.latLng;

      await _mapRouteCubit.getRouteFromSourceToDestination(
        context,
        sourceLatLng,
        destinationLatLng,
      );

      _topSectionAnimationController.forward();
      _bottomSectionAnimationController.forward();

      final CenterZoom newCenterZoom = _mapController.centerZoomFitBounds(
        LatLngBounds(
          sourceLatLng,
          destinationLatLng,
        ),
      );

      _mapController.move(
        newCenterZoom.center,
        newCenterZoom.zoom - .2,
      );

      _showRoute = true;
      setState(() {});

      await _rideDriverCubit.findRideDriver(
        context,
        sourceLatLng,
      );

      final RideDriverState rideDriverState = _rideDriverCubit.state;

      if (rideDriverState is RideDriverGot) {
        Timer.periodic(const Duration(milliseconds: 300), (timer) {
          if (timer.tick < rideDriverState.points.length) {
            _rideDriverCubit.moveRideDriverByOnePoint();
          } else {
            _showStartDemoRideCountDown();
            timer.cancel();
          }
        });
      }
    }

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

  void _showStartDemoRideCountDown() {
    _showDemoRideCountDown = true;

    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timer.tick <= 10) {
        setState(() {
          _countDownNumber = 10 - timer.tick;
        });
      } else {
        _rideDriverCubit.emitRideDriverInitialState();
        _startRide();
        timer.cancel();
      }
    });
  }

  void _startRide() async {
    if (_pickupAddress == null || _destinationAddress == null) {
      return;
    }

    final LatLng sourcePosition = _pickupAddress!.latLng;
    final LatLng destinationPosition = _destinationAddress!.latLng;

    await _rideCubit.getRoutePointsAndStartRide(
      context,
      sourcePosition,
      destinationPosition,
    );

    final CenterZoom newCenterZoom = _mapController.centerZoomFitBounds(
      LatLngBounds(sourcePosition, destinationPosition),
      options: const FitBoundsOptions(
        padding: EdgeInsets.all(128),
      ),
    );

    _mapController.move(
      newCenterZoom.center,
      newCenterZoom.zoom,
    );

    final RideState rideState = _rideCubit.state;

    if (rideState is RideActive) {
      Timer.periodic(const Duration(milliseconds: 100), (timer) {
        if (timer.tick < rideState.routePoints.length) {
          _rideCubit.moveRiderByOnePoint();
        } else {
          _rideCubit.endRide();
          timer.cancel();
        }
      });
    }

    _showRoute = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _searchedPlacesCubit = SearchedPlacesCubit();
    _mapRouteCubit = MapRouteCubit();
    _rideDriverCubit = RideDriverCubit();
    _rideCubit = RideCubit();

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

    _rideDriverCubit.stream.listen((rideDriverState) {
      if (rideDriverState is RideDriverGot) {
        final LatLng vehicleSourcePosition = rideDriverState.points[0];
        final LatLng userPosition = _pickupAddress!.latLng;

        final CenterZoom newCenterZoom = _mapController.centerZoomFitBounds(
          LatLngBounds(vehicleSourcePosition, userPosition),
        );

        _mapController.move(
          newCenterZoom.center,
          newCenterZoom.zoom - 2,
        );

        _showRoute = false;
        setState(() {});
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
    _mapRouteCubit.close();
    _rideDriverCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final Size size = MediaQuery.of(context).size;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _searchedPlacesCubit),
        BlocProvider.value(value: _mapRouteCubit),
        BlocProvider.value(value: _rideDriverCubit),
        BlocProvider.value(value: _rideCubit),
      ],
      child: BlocBuilder<RideDriverCubit, RideDriverState>(
        builder: (context, rideDriverState) {
          return BlocBuilder<RideCubit, RideState>(
            builder: (context, rideState) {
              return Scaffold(
                body: Stack(
                  children: [
                    // Map
                    BlocBuilder<MapRouteCubit, MapRouteState>(
                      builder: (context, mapRouteState) {
                        return FlutterMap(
                          mapController: _mapController,
                          options: MapOptions(
                            center: LatLng(22.5726, 88.3639),
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
                                if (_pickupAddress != null &&
                                    (_showRoute ||
                                        rideDriverState is RideDriverGot))
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
                                if (rideDriverState is RideDriverGot &&
                                    !_showRoute)
                                  Marker(
                                    point: rideDriverState.points[0],
                                    anchorPos: AnchorPos.align(AnchorAlign.top),
                                    rotate: true,
                                    builder: (context) {
                                      return Icon(
                                        Icons.car_repair_sharp,
                                        color: colorScheme.primary,
                                        size: 40,
                                      );
                                    },
                                  ),
                                if (rideState is RideActive && _showRoute)
                                  Marker(
                                    point: rideState.currentPosition,
                                    anchorPos: AnchorPos.align(AnchorAlign.top),
                                    rotate: true,
                                    builder: (context) {
                                      return Icon(
                                        Icons.car_repair_sharp,
                                        color: colorScheme.primary,
                                        size: 40,
                                      );
                                    },
                                  ),
                              ],
                            ),
                            PolylineLayerOptions(
                              polylines: [
                                if (mapRouteState is MapRouteGot && _showRoute)
                                  Polyline(
                                    points: mapRouteState.points,
                                    color: colorScheme.primary,
                                    strokeCap: StrokeCap.round,
                                    strokeWidth: 4,
                                  ),
                                if (rideDriverState is RideDriverGot &&
                                    !_showRoute)
                                  Polyline(
                                    points: rideDriverState.points,
                                    color: colorScheme.primary,
                                    strokeCap: StrokeCap.round,
                                    strokeWidth: 4,
                                  ),
                                if (rideState is RideActive && _showRoute)
                                  Polyline(
                                    points: rideState.routePoints,
                                    color: colorScheme.primary,
                                    strokeCap: StrokeCap.round,
                                    strokeWidth: 4,
                                  ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),

                    // Input and Destiantion Picker top widget
                    SingleChildScrollView(
                      child: SizedBox(
                        height: _showUpButton ? 260 : size.height,
                        width: double.infinity,
                        child: Column(
                          children: [
                            BlocBuilder<MapRouteCubit, MapRouteState>(
                              builder: (context, state) {
                                return ExpansionAnimationWidget(
                                  controller: _topSectionAnimationController,
                                  child:
                                      InputPickupAndDestinationLocationWidget(
                                    onDonePressed: _pickupAddress != null &&
                                            _destinationAddress != null
                                        ? () => (state is MapRouteLoading)
                                            ? null
                                            : _onDonePressed()
                                        : null,
                                    pickupTextEditingController:
                                        _pickupTextEditingController,
                                    destinationTextEditingController:
                                        _destinationTextEditingController,
                                    pickupFocusNode: _pickupFocusNode,
                                    destinationFocusNode: _destinationFocusNode,
                                  ),
                                );
                              },
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

                    // Loading screen
                    if (rideDriverState is RideDriverLoading)
                      Container(
                        height: size.height,
                        width: size.width,
                        color: Colors.black26,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(),
                            const SizedBox(height: 16),
                            Text(
                              'Finding driver for your ride',
                              style: textTheme.bodyText1?.copyWith(
                                color: colorScheme.primary,
                              ),
                            ),
                          ],
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
                bottomSheet: rideDriverState is RideDriverGot
                    ? Container(
                        height: 200,
                        width: size.width,
                        padding: const EdgeInsets.all(Nums.horizontalPadding),
                        decoration: BoxDecoration(
                          color: _showDemoRideCountDown
                              ? colorScheme.primary
                              : colorScheme.background,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(
                              Nums.roundedCornerRadius,
                            ),
                            topRight: Radius.circular(
                              Nums.roundedCornerRadius,
                            ),
                          ),
                        ),
                        child: _showDemoRideCountDown
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Demo Ride starting in...',
                                    style: TextStyle(
                                      color: colorScheme.onPrimary,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    '$_countDownNumber',
                                    style: TextStyle(
                                      color: colorScheme.onPrimary,
                                      fontSize: 64,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            : RideDriverInfoWidget(
                                driver: rideDriverState.driver,
                              ),
                      )
                    : const SizedBox(
                        width: 0,
                        height: 0,
                      ),
              );
            },
          );
        },
      ),
    );
  }
}
