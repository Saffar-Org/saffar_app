import 'package:dio/dio.dart';
import 'package:saffar_app/core/constants/strings.dart';
import 'package:saffar_app/core/errors/custom_exception.dart';
import 'package:saffar_app/core/models/user.dart';
import 'package:saffar_app/core/service_locator.dart';

/// Handles data to/from authentication APIs.
class AuthRepo {
  final Dio _dio = sl<Dio>();

  /// Signs up user and returns a User model
  Future<User> signUp(String name, String phone, String password) async {
    try {
      final Response response = await _dio.post(
        '${Strings.baseApiUrl}/sign_up',
        queryParameters: {
          'name': name,
          'phone_number': phone,
          'password': password,
        },
      );

      final Map<String, dynamic> data = response.data as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return User.fromMap(data['user']);
      }

      throw CustomException(
        errorCode: data['error'],
        message: data['message'],
      );
    } on DioException catch (e) {
      throw CustomException(
        errorCode: e.error.toString(),
        message: e.message,
      );
    }
  }

  /// Signs in user and returns a User model
  Future<User> signIn(String phone, String password) async {
    try {
      final Response response = await _dio.post(
        '${Strings.baseApiUrl}/sign_in',
        queryParameters: {
          'phone_number': phone,
          'password': password,
        },
      );

      final Map<String, dynamic> data = response.data as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return User.fromMap(data['user']);
      }

      throw CustomException(
        errorCode: data['error'],
        message: data['message'],
      );
    } on DioException catch (e) {
      throw CustomException(
        errorCode: e.error.toString(),
        message: e.message,
      );
    }
  }
}
