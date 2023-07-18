import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:saffar_app/core/utils/snackbar.dart';
import 'package:saffar_app/features/ride/domain/usecases/get_ride_route_points_usecase.dart';

part 'ride_state.dart';

class RideCubit extends Cubit<RideState> {
  RideCubit() : super(const RideInitial());

  final GetRideRoutePointsUsecase _getRideRoutePointsUsecase =
      GetRideRoutePointsUsecase();

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
    }
  }

  /// Ends the ride
  void endRide() {
    emit(const RideCompleted());
  }
}
