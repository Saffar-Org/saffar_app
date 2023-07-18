part of 'ride_cubit.dart';

@immutable
abstract class RideState {
  const RideState();
}

/// When Ride not started 
class RideInitial extends RideState {
  const RideInitial();
}

/// When Ride is on going
class RideActive extends RideState {
  const RideActive({
    required this.routePoints,
    required this.currentRoutePointIndex,
    required this.currentPosition,
  });

  final List<LatLng> routePoints;
  final int currentRoutePointIndex;
  final LatLng currentPosition;

  RideActive copyWith({
    List<LatLng>? routePoints,
    int? currentRoutePointIndex,
    LatLng? currentPosition,
  }) {
    return RideActive(
      routePoints: routePoints ?? this.routePoints,
      currentRoutePointIndex:
          currentRoutePointIndex ?? this.currentRoutePointIndex,
      currentPosition: currentPosition ?? this.currentPosition,
    );
  }
}

/// When Ride is completed
class RideCompleted extends RideState {
  const RideCompleted();
}
