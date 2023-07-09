import 'package:dio/dio.dart';
import 'package:saffar_app/core/errors/custom_exception.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/service_locator.dart';

class DistanceRepo {
  final Dio _dio = sl<Dio>();

  /// Gets route distance in KM
  Future<double> getRouteDistanceInKm(
    LatLng sourceLatLng,
    LatLng destinationLatLng,
  ) async {
    try {
      final Response response = await _dio.get(
        'https://api.tomtom.com/routing/1/calculateRoute/${sourceLatLng.latitude},${sourceLatLng.longitude}:${destinationLatLng.latitude},${destinationLatLng.longitude}/json?key=${Strings.mapApiKey}',
      );

      final double? distanceInMeters = double.tryParse(response.data['routes']
              [0]['legs'][0]['summary']['lengthInMeters']
          .toString());

      if (distanceInMeters != null) {
        final double distanceInKm = distanceInMeters / 1000.0;

        return distanceInKm;
      }

      throw const CustomException(message: 'Failed to get distance.');
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }
}
