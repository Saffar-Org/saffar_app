import 'package:saffar_app/core/service_locator.dart';
import 'package:saffar_app/features/location/data/repositories/location_repo.dart';
import 'package:latlong2/latlong.dart';

class GetCurrentLatLngUsecase {
  final LocationRepo _locationRepo = sl<LocationRepo>();

  Future<LatLng?> call() {
    return _locationRepo.getCurrentLatLng();
  }
}