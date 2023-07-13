part of 'ride_driver_cubit.dart';

@immutable
abstract class RideDriverState {
  const RideDriverState();
}

/// State when no info about ride driver is fetched
class RideDriverInitial extends RideDriverState {
  const RideDriverInitial();
}

/// Stores the state of ride driver and the points 
/// in the route of the driver from it's source location 
/// to the destination location i.e. the user's location
class RideDriverGot extends RideDriverState {
  const RideDriverGot({
    required this.driver,
    required this.points,
  });

  final Driver driver;
  final List<LatLng> points;
}

/// State when fetching the info hence loading
class RideDriverLoading extends RideDriverState {
  const RideDriverLoading();
}
