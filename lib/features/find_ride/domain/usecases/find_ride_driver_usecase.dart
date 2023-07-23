import 'package:dartz/dartz.dart';
import 'package:saffar_app/core/errors/custom_exception.dart';
import 'package:saffar_app/core/errors/failure.dart';
import 'package:saffar_app/core/models/ride_driver.dart';
import 'package:saffar_app/features/ride/data/repositories/ride_repo.dart';
import 'package:saffar_app/core/service_locator.dart';
import 'package:saffar_app/features/search_places_and_get_route/data/repositories/map_route_repo.dart';
import 'package:latlong2/latlong.dart';

class FindRideDriverUsecase {
  final RideRepo _rideRepo = sl<RideRepo>();
  final MapRouteRepo _mapRouteRepo = sl<MapRouteRepo>();

  /// Find Ride Driver info and get the route points and set
  /// the route points to the ride driver model
  Future<Either<Failure, RideDriver>> call(LatLng userSourcePosition) async {
    try {
      final double latitude = userSourcePosition.latitude;
      final double longitude = userSourcePosition.longitude;

      RideDriver rideDriver = await _rideRepo.findRideDriver(
        latitude,
        longitude,
      );

      final List<LatLng> points =
          await _mapRouteRepo.getPointsFromSourceToDestination(
        rideDriver.sourcePosition,
        rideDriver.destinationPosition,
      );

      rideDriver = rideDriver.setPoints(points);

      return Right(rideDriver);
    } on CustomException catch (e) {
      return Left(Failure.fromCustomException(e));
    }
  }
}
