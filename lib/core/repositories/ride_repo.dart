import 'package:dio/dio.dart';
import 'package:saffar_app/core/constants/strings.dart';
import 'package:saffar_app/core/errors/custom_exception.dart';
import 'package:saffar_app/core/models/ride.dart';
import 'package:saffar_app/core/service_locator.dart';

/// Gets rides data
class RideRepo {
  final Dio _dio = sl<Dio>();

  late final String? token;
  late final String? userId;

  /// Initialized Rides Repo. This must be called once
  /// in the application before the other functions are
  /// called. Preferrably in the Splash Screen.
  void initRidesRepo(String token, String userId) {
    this.token = token;
    this.userId = userId;
  }

  /// Gets all the previous rides of the user
  Future<List<Ride>> getPreviousRides() async {
    if (token == null || userId == null) {
      throw const CustomException(message: 'User not logged in');
    }

    try {
      final Response response = await _dio.get(
        '${Strings.baseApiUrl}/ride/previous_rides',
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
          },
        ),
        data: {
          'user_id': userId,
        },
      );

      if (response.statusCode != 200) {
        throw CustomException(
          code: response.data['error']['code'],
          message: response.data['error']['message'],
        );
      }

      final List<Map<String, dynamic>> maps =
          (response.data['previous_rides'] as List)
              .map((e) => e as Map<String, dynamic>)
              .toList();

      return maps.map((map) => Ride.fromMap(map)).toList();
    } on DioException catch (e) {
      throw CustomException(
        code: e.response?.data['error']['code'],
        message: e.response?.data['error']['message'],
      );
    }
  }

  /// Gives Driver, drivers source position, drivers destination position
  Future<Map<String, dynamic>> findRideDriver() async {
    if (token == null) {
      throw const CustomException(message: 'User not logged in');
    }

    try {
      final Response response = await _dio.get(
        '${Strings.baseApiUrl}/ride/find_ride_driver',
        options: Options(
          headers: {
            'authorization': 'Bearer $token',
          },
        ),
      );

      return response.data;
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }
}
