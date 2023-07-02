import 'package:dio/dio.dart';
import 'package:saffar_app/core/constants/strings.dart';
import 'package:saffar_app/core/errors/custom_exception.dart';
import 'package:saffar_app/core/models/ride.dart';
import 'package:saffar_app/core/service_locator.dart';

/// Gets rides data
class RidesRepo {
  RidesRepo({
    this.token,
    this.userId,
  });

  final Dio _dio = sl<Dio>();

  final String? token;
  final String? userId;

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

      final List maps = response.data as List;

      return maps.map((map) => Ride.fromMap(map)).toList();
    } on DioException catch (e) {
      throw CustomException(
        code: e.response?.data['error']['code'],
        message: e.response?.data['error']['message'],
      );
    }
  }
}
