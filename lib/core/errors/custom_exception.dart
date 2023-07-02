class CustomException implements Exception {
  const CustomException({
    this.code,
    this.message,
  });

  /// Error code like (INVALID_PHONE, EMPTY_PARAMS, etc.)
  final String? code;
  /// Error message like (Phone number is invalid)
  final String? message;
}
