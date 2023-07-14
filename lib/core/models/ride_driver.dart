import 'package:saffar_app/core/models/driver.dart';
import 'package:latlong2/latlong.dart';
import 'package:saffar_app/core/utils/model_helper.dart';

/// Model to store info about the driver and it's
/// source and destination position and the points 
/// of route from source position to destination position
class RideDriver {
  const RideDriver({
    required this.driver,
    required this.sourcePosition,
    required this.destinationPosition,
    this.points = const [],
  });

  final Driver driver;
  final LatLng sourcePosition;
  final LatLng destinationPosition;
  /// Points in route from source position to destination position
  final List<LatLng> points;

  /// Parses map to RideDriver model
  factory RideDriver.fromMap(Map<String, dynamic> map) {
    ModelHelper.throwExceptionIfRequiredFieldsNotPresentInMap(
      'RideDriver',
      map,
      [
        'driver',
        'source_position',
        'destination_position',
      ],
    );

    final double? sourceLat = double.tryParse(
      map['source_position']['latitude'].toString(),
    );
    final double? sourceLon = double.tryParse(
      map['source_position']['longitude'].toString(),
    );

    final double? destinationLat = double.tryParse(
      map['destination_position']['latitude'].toString(),
    );
    final double? destinationLon = double.tryParse(
      map['destination_position']['longitude'].toString(),
    );

    if (sourceLat == null ||
        sourceLon == null ||
        destinationLat == null ||
        destinationLon == null) {
      throw Exception(
        'Model RideDriver: RideDriver can not parse source lat source lon destination lat destination lon to double',
      );
    }

    return RideDriver(
      driver: Driver.fromMap(map['driver']),
      sourcePosition: LatLng(sourceLat, sourceLon),
      destinationPosition: LatLng(destinationLat, destinationLon),
    );
  }

  /// Sets new points 
  RideDriver setPoints(List<LatLng> points) {
    return RideDriver(
      driver: driver,
      sourcePosition: sourcePosition,
      destinationPosition: destinationPosition,
      points: points,
    );
  }
}
