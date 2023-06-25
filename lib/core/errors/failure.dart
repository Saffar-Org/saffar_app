import 'package:saffar_app/core/errors/custom_exception.dart';

class Failure {
  const Failure({
    this.errorCode,
    this.message,
  });

  final String? errorCode;
  final String? message;

  factory Failure.fromCustomException(CustomException e) {
    return Failure(
      errorCode: e.error,
      message: e.message,
    );
  }
}
