import 'package:saffar_app/core/constants/error.dart';

class CustomException implements Exception {
  const CustomException({
    this.code,
    this.message,
  });

  /// Error code like (INVALID_PHONE, EMPTY_PARAMS, etc.)
  final String? code;

  /// Error message like (Phone number is invalid)
  final String? message;

  /// User not logged in `CustomException`
  factory CustomException.userNotLoggedIn() {
    return CustomException(
      code: Err.code.userNotLoggedIn,
      message: Err.message.userNotLoggedIn,
    );
  }
}
