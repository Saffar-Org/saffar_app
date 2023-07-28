import 'package:dartz/dartz.dart';
import 'package:saffar_app/core/errors/custom_exception.dart';
import 'package:saffar_app/core/errors/failure.dart';
import 'package:latlong2/latlong.dart';
import 'package:saffar_app/core/service_locator.dart';
import 'package:saffar_app/features/ride/data/repositories/ride_repo.dart';
import 'package:saffar_app/features/search_places_and_get_route/data/repositories/map_route_repo.dart';

class GetTotalRidePriceUsecase {
  final MapRouteRepo _mapRouteRepo = sl<MapRouteRepo>();
  final RideRepo _rideRepo = sl<RideRepo>();

  /// Gets the distance in km and the gets the total 
  /// ride price according to the distance of the route
  Future<Either<Failure, double>> call(
    LatLng sourcePosition,
    LatLng destinationPosition,
  ) async {
    try {
      final double distanceInMeters = await _mapRouteRepo.getDistanceInMetersFromSourceToDestination(
        sourcePosition,
        destinationPosition,
      );

      final double distanceInKm = distanceInMeters/1000.0;

      final double totalRidePrice = await _rideRepo.getTotalRidePrice(distanceInKm);

      final double finalTotalRidePrice = double.parse(totalRidePrice.toStringAsExponential(2));

      return Right(finalTotalRidePrice);
    } on CustomException catch (e) {
      return Left(Failure.fromCustomException(e));
    }
  }
}
