import 'package:saffar_app/core/errors/custom_exception.dart';
import 'package:saffar_app/core/service_locator.dart';
import 'package:saffar_app/features/location/data/repositories/location_repo.dart';
import 'package:saffar_app/features/search_places_and_get_route/data/repositories/search_places_repo.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/models/address.dart';

class GetCurrentLatLngAndAddressUsecase {
  final SearchPlacesRepo _searchPlacesRepo = sl<SearchPlacesRepo>();
  final LocationRepo _locationRepo = sl<LocationRepo>();

  Future<Address?> call() async {
    try {
      final LatLng? currentPosition = await _locationRepo.getCurrentLatLng();

      if (currentPosition != null) {
        final double lat = currentPosition.latitude;
        final double lon = currentPosition.longitude;

        final Address address = await _searchPlacesRepo.getAddressFromLatLng(
          lat,
          lon,
        );

        return address;
      }
    } on CustomException {
      return null;
    }
  }
}
