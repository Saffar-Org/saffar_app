class CustomException implements Exception {
  const CustomException({
    this.error,
    this.message,
  });

  /// Error code like (INVALID_PHONE, EMPTY_PARAMS, etc.)
  final String? error;
  /// Error message like (Phone number is invalid)
  final String? message;
}
