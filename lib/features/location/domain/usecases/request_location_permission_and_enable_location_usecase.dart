import 'package:saffar_app/core/service_locator.dart';
import 'package:saffar_app/features/location/data/enums/location_permission_status.dart';
import 'package:saffar_app/features/location/data/repositories/location_repo.dart';

class RequestLocationPermissionAndEnableLocationUsecase {
  final LocationRepo _locationRepo = sl<LocationRepo>();

  /// Requests location permission and
  /// requests enable location
  Future<String?> call() async {
    LocationPermissionStatus locationPermissionStatus =
        await _locationRepo.getLocationPermissionStatus();

    if (locationPermissionStatus == LocationPermissionStatus.granted) {
      return _enableLocationService();
    }

    if (locationPermissionStatus == LocationPermissionStatus.deniedForever) {
      return 'Please allow location permission from settings.';
    }

    locationPermissionStatus = await _locationRepo.requestPermission();

    if (locationPermissionStatus == LocationPermissionStatus.deniedForever) {
      return 'Please allow location permission from settings.';
    }

    if (locationPermissionStatus == LocationPermissionStatus.denied) {
      return 'Please allow location permission.';
    }

    return _enableLocationService();

    // LocationPermissionStatus locationPermissionStatus =
    //     await _locationRepo.getLocationPermissionStatus();

    // if (locationPermissionStatus == LocationPermissionStatus.deniedForever) {
    //   return 'Enable Location permission from Settings.';
    // } else if (locationPermissionStatus == LocationPermissionStatus.denied) {
    //   locationPermissionStatus = await _locationRepo.requestPermission();

    //   if (locationPermissionStatus == LocationPermissionStatus.granted) {
    //     bool locationEnabled = await _locationRepo.islocationEnabled();

    //     if (!locationEnabled) {
    //       locationEnabled = await _locationRepo.requestEnableLocation();

    //       if (!locationEnabled) {
    //         return 'Please switch on Location.';
    //       }
    //     }

    //     return null;
    //   }

    //   return 'Permission denied. Please allow location permission.';
    // } else if (locationPermissionStatus == LocationPermissionStatus.granted) {
    //   bool locationEnabled = await _locationRepo.islocationEnabled();

    //   if (!locationEnabled) {
    //     locationEnabled = await _locationRepo.requestEnableLocation();

    //     if (!locationEnabled) {
    //       return 'Please switch on Location.';
    //     }
    //   }

    //   return null;
    // }

    // return null;
  }

  Future<String?> _enableLocationService() async {
    bool locationEnabled = await _locationRepo.islocationEnabled();

    if (locationEnabled) {
      return null;
    }

    locationEnabled = await _locationRepo.requestEnableLocation();

    if (!locationEnabled) {
      return 'Please turn on Location.';
    }
  }
}
