import 'package:dartz/dartz.dart';
import 'package:saffar_app/core/errors/custom_exception.dart';
import 'package:saffar_app/core/errors/failure.dart';
import 'package:saffar_app/core/models/address.dart';
import 'package:saffar_app/core/service_locator.dart';
import 'package:saffar_app/features/search_places_and_get_route/data/repositories/search_places_repo.dart';

class GetAddressFromLatLon {
  final SearchPlacesRepo _searchPlacesRepo = sl<SearchPlacesRepo>();

  /// Gets Address from lat lon
  Future<Either<Failure, Address>> call(double lat, double lon) async {
    try {
      final Address address = await _searchPlacesRepo.getAddressFromLatLng(lat, lon);

      return Right(address);
    } on CustomException catch (e) {
      return Left(Failure.fromCustomException(e));
    }
  }
}