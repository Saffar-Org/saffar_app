import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';
import 'package:saffar_app/core/errors/custom_exception.dart';
import 'package:saffar_app/core/service_locator.dart';

import '../../../../core/constants/strings.dart';

class MapRouteRepo {
  final Dio _dio = sl<Dio>();

  /// Gets the routes points from source to destination
  Future<List<LatLng>> getPointsFromSourceToDestination(
    LatLng sourceLatLng,
    LatLng destinationLatLng,
  ) async {
    try {
      final Response response = await _dio.get(
        'https://api.tomtom.com/routing/1/calculateRoute/${sourceLatLng.latitude},${sourceLatLng.longitude}:${destinationLatLng.latitude},${destinationLatLng.longitude}/json?key=${Strings.mapApiKey}',
      );

      final List list = response.data['routes'][0]['legs'][0]['points'] as List;

      final List<Map<String, dynamic>> maps =
          list.map((e) => e as Map<String, dynamic>).toList();

      final List<LatLng> points = [];

      for (final map in maps) {
        final double? lat = double.tryParse(map['latitude'].toString());
        final double? lon = double.tryParse(map['longitude'].toString());

        if (lat != null && lon != null) {
          points.add(LatLng(lat, lon));
        }
      }

      return points;
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  /// Gets the distance from source to destination in meters
  Future<double> getDistanceInMetersFromSourceToDestination(
    LatLng sourceLatLng,
    LatLng destinationLatLng,
  ) async {
    try {
      final Response response = await _dio.get(
        'https://api.tomtom.com/routing/1/calculateRoute/${sourceLatLng.latitude},${sourceLatLng.longitude}:${destinationLatLng.latitude},${destinationLatLng.longitude}/json?key=${Strings.mapApiKey}',
      );

      final double? distanceInMeters = double.tryParse(
        response.data['routes'][0]['legs'][0]['summary']['lengthInMeters']
            .toString(),
      );

      if (distanceInMeters != null) {
        return distanceInMeters;
      }

      throw const CustomException(
        message:
            'There was some problem in getting distance from source to destination.',
      );
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }
}
