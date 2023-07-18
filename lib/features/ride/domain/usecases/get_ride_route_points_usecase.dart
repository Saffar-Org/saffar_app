import 'package:dartz/dartz.dart';
import 'package:saffar_app/core/errors/custom_exception.dart';
import 'package:saffar_app/core/errors/failure.dart';
import 'package:latlong2/latlong.dart';
import 'package:saffar_app/core/service_locator.dart';
import 'package:saffar_app/features/search_places_and_get_route/data/repositories/map_route_repo.dart';

class GetRideRoutePointsUsecase {
  final MapRouteRepo _mapRouteRepo = sl<MapRouteRepo>();

  Future<Either<Failure, List<LatLng>>> call(
    LatLng sourcePosition,
    LatLng destinationPosition,
  ) async {
    try {
      final List<LatLng> routePoints = await _mapRouteRepo.getPointsFromSourceToDestination(
        sourcePosition,
        destinationPosition,
      );

      return Right(routePoints);
    } on CustomException catch (e) {
      return Left(Failure.fromCustomException(e));
    }
  }
}
