import 'package:location/location.dart';
import 'package:saffar_app/features/location/data/enums/location_permission_status.dart';
import 'package:latlong2/latlong.dart';

class LocationRepo {
  final Location _location = Location();

  /// Gets location permission status
  Future<LocationPermissionStatus> getLocationPermissionStatus() async {
    final PermissionStatus permissionStatus = await _location.hasPermission();

    switch (permissionStatus) {
      case PermissionStatus.granted:
        return LocationPermissionStatus.granted;
      case PermissionStatus.grantedLimited:
        return LocationPermissionStatus.granted;
      case PermissionStatus.denied:
        return LocationPermissionStatus.denied;
      case PermissionStatus.deniedForever:
        return LocationPermissionStatus.deniedForever;
    }
  }

  /// Shows dialog to request permission from the user
  Future<LocationPermissionStatus> requestPermission() async {
    final PermissionStatus permissionStatus =
        await _location.requestPermission();

    switch (permissionStatus) {
      case PermissionStatus.granted:
        return LocationPermissionStatus.granted;
      case PermissionStatus.grantedLimited:
        return LocationPermissionStatus.granted;
      case PermissionStatus.denied:
        return LocationPermissionStatus.denied;
      case PermissionStatus.deniedForever:
        return LocationPermissionStatus.deniedForever;
    }
  }

  /// Checks if location is enabled
  Future<bool> islocationEnabled() {
    return _location.serviceEnabled();
  }

  /// Shows the dialog box to request current location of user
  Future<bool> requestEnableLocation() {
    return _location.requestService();
  }

  /// Gets the users current location. If can not get lat lng then null is
  /// returned
  Future<LatLng?> getCurrentLatLng() async {
    final LocationData locationData = await _location.getLocation();

    if (locationData.latitude != null && locationData.longitude != null) {
      return LatLng(
        locationData.latitude!,
        locationData.longitude!,
      );
    }
  }
}
