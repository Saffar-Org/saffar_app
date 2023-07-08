import 'package:dio/dio.dart';
import 'package:saffar_app/core/constants/strings.dart';
import 'package:saffar_app/core/models/address.dart';

import '../../../../core/errors/custom_exception.dart';
import '../../../../core/service_locator.dart';

class SearchPlacesRepo {
  final Dio _dio = sl<Dio>();

  /// Gets 10 addresses with the given query
  Future<List<Address>> getSearchedAddresses(
    String searchText, {
    int page = 0,
  }) async {
    try {
      final String encodedSearchText = Uri.encodeComponent(searchText);

      final Response response = await _dio.get(
        'https://api.tomtom.com/search/2/search/$encodedSearchText.json?key=${Strings.mapApiKey}&ofs=$page&limit=10',
      );

      final List list = response.data['results'] as List;

      final List<Map<String, dynamic>> maps = list.map((e) {
        return e as Map<String, dynamic>;
      }).toList();

      final List<Address> addresses = maps
          .map((map) => Address.fromSearchPlacesApiResponseMap(map))
          .toList();

      return addresses;
    } on DioException catch (e) {
      if (e.response?.statusCode == 429) {
        throw const CustomException(code: 'TOO_MANY_QUERIES_PER_SECOND');
      }

      throw const CustomException(
        message: 'Error in fetching Address list with query',
      );
    }
  }

  /// Gets Address from latitude and longitude
  Future<Address> getAddressFromLatLng(double lat, double lon) async {
    try {
      final Response response = await _dio.get(
        'https://api.tomtom.com/search/2/reverseGeocode/$lat,$lon.json?key=${Strings.mapApiKey}&radius=100',
      );

      final List list = response.data['addresses'] as List;

      if (list.isEmpty) {
        throw CustomException(
          code: 'NO_PLACE_FOUND',
          message: 'No place found with latitude: $lat and longitude: $lon',
        );
      }

      final List<Map<String, dynamic>> maps = list.map((e) {
        return e as Map<String, dynamic>;
      }).toList();

      final Map<String, dynamic> map = maps[0];

      await Future.delayed(const Duration(milliseconds: 1000));

      return Address.fromReverseGeocodeApiResponseMap(map);
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }
}
