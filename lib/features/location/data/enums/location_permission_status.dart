/// Location permission status 
enum LocationPermissionStatus {
  /// Location is granted
  granted,
  /// Location is denied but dialog box for permission will show
  denied,
  /// Location is denied forever and no box for permission will show
  deniedForever,
}