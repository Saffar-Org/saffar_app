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
        '${Strings.baseApiUrl}/auth/sign_up',
        data: {
          'name': name,
          'phone': phone,
          'password': password,
        },
      );

      final Map<String, dynamic> data = response.data as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return User.fromMap(data['user']);
      }

      throw CustomException(
        code: data['error']['code'],
        message: data['error']['message'],
      );
    } on DioException catch (e) {
      throw CustomException(
        code: e.response?.data['error']['code'],
        message: e.response?.data['error']['message'],
      );
    }
  }

  /// Signs in user and returns a User model
  Future<User> signIn(String phone, String password) async {
    try {
      final Response response = await _dio.post(
        '${Strings.baseApiUrl}/auth/sign_in',
        data: {
          'phone': phone,
          'password': password,
        },
      );

      final Map<String, dynamic> data = response.data as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return User.fromMap(data['user']);
      }

      throw CustomException(
        code: data['error']['code'],
        message: data['error']['message'],
      );
    } on DioException catch (e) {
      throw CustomException(
        code: e.response?.data['error']['code'],
        message: e.response?.data['error']['message'],
      );
    }
  }
}
