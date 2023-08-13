import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:saffar_app/core/models/ride.dart';
import 'package:saffar_app/core/usecases/create_ride_usecase.dart';
import 'package:saffar_app/core/utils/snackbar.dart';
import 'package:saffar_app/features/ride/domain/usecases/add_ride_usecase.dart';
import 'package:saffar_app/features/ride/domain/usecases/get_ride_route_points_usecase.dart';

import '../../../../core/models/address.dart';
import '../../../../core/models/driver.dart';
import '../../../user/data/models/user.dart';

part 'ride_state.dart';

class RideCubit extends Cubit<RideState> {
  RideCubit() : super(const RideInitial());

  final GetRideRoutePointsUsecase _getRideRoutePointsUsecase =
      GetRideRoutePointsUsecase();
  final AddRideUsecase _addRideUsecase = AddRideUsecase();
  final CreateRideUsecase _createRideUsecase = CreateRideUsecase();

  /// Initialized the Ride Active state with required
  /// values
  Future<void> getRoutePointsAndStartRide(
    BuildContext context,
    LatLng sourcePosition,
    LatLng destinationPosition,
  ) async {
    final result = await _getRideRoutePointsUsecase.call(
      sourcePosition,
      destinationPosition,
    );

    result.fold(
      (l) {
        Snackbar.of(context).show('Failed to get route');
      },
      (routePoints) {
        const int initialRoutePointIndex = 0;
        final LatLng initialPosition = routePoints[initialRoutePointIndex];

        emit(RideActive(
          routePoints: routePoints,
          currentRoutePointIndex: initialRoutePointIndex,
          currentPosition: initialPosition,
        ));
      },
    );
  }

  /// Moves the rider by one position in the direction of
  /// the route
  void moveRiderByOnePoint() {
    if (state is RideActive) {
      final RideActive rideActive = state as RideActive;

      final int nextIndex = rideActive.currentRoutePointIndex + 1;

      if (nextIndex < rideActive.routePoints.length) {
        final LatLng nextPosition = rideActive.routePoints[nextIndex];

        emit(rideActive.copyWith(
          currentRoutePointIndex: nextIndex,
          currentPosition: nextPosition,
        ));
      }

      if (nextIndex == rideActive.routePoints.length - 1) {
        Future.delayed(
          const Duration(seconds: 1),
          () {
            emit(const RideCompleted());
          },
        );
      }
    }
  }

  /// Ends the ride
  void endRide() {
    emit(const RideCompleted());
  }

  /// Adds ride to DB
  void addRide(Ride ride) async {
    await _addRideUsecase.call(ride);
  }

  /// Creates an instance of the Ride model
  Ride createRide({
    required User user,
    required Driver driver,
    required Address sourceAddress,
    required Address destinationAddress,
    required DateTime startTime,
    DateTime? endTime,
    required bool cancelled,
    required double price,
    double? discountPrice,
  }) {
    final Ride ride = _createRideUsecase.call(
      user: user,
      driver: driver,
      sourceAddress: sourceAddress,
      destinationAddress: destinationAddress,
      startTime: startTime,
      endTime: endTime,
      cancelled: cancelled,
      price: price,
      discountPrice: discountPrice,
    );

    return ride;
  }
}
