import 'package:dartz/dartz.dart';
import 'package:saffar_app/core/errors/custom_exception.dart';
import 'package:saffar_app/core/errors/failure.dart';
import 'package:latlong2/latlong.dart';
import 'package:saffar_app/core/service_locator.dart';
import 'package:saffar_app/features/search_places_and_get_route/data/repositories/map_route_repo.dart';

class GetPointsFromSourceToDestinationUsecase {
  final MapRouteRepo _mapRoutesRepo = sl<MapRouteRepo>();

  /// Gest the routes points from source to destination
  Future<Either<Failure, List<LatLng>>> call(
    LatLng sourceLatLng,
    LatLng destinationLatLng,
  ) async {
    try {
      final List<LatLng> points =
          await _mapRoutesRepo.getPointsFromSourceToDestination(
        sourceLatLng,
        destinationLatLng,
      );

      return Right(points);
    } on CustomException catch (e) {
      return Left(Failure.fromCustomException(e));
    }
  }
}
