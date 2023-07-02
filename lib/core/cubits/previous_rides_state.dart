part of 'previous_rides_cubit.dart';

@immutable
abstract class PreviousRidesState {
  const PreviousRidesState();
}

/// Holdes the state of previous rides
class PreviousRidesGot extends PreviousRidesState {
  const PreviousRidesGot({
    this.previousRides = const [],
    this.previousRidesWithoutCancellation = const [],
    this.latestTwoPreviousRides = const [],
  });

  final List<Ride> previousRides;
  final List<Ride> previousRidesWithoutCancellation;
  final List<Ride> latestTwoPreviousRides;
}

/// Holds the state of loading
/// when previous rides are being fetched
class PreviousRidesLoading extends PreviousRidesState {
  const PreviousRidesLoading();
}
