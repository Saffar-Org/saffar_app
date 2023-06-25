class CustomException implements Exception {
  const CustomException({
    this.errorCode,
    this.message,
  });

  final String? errorCode;
  final String? message;
}
