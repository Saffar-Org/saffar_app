import 'package:saffar_app/core/errors/custom_exception.dart';

class Failure {
  const Failure({
    this.code,
    this.message,
  });

  final String? code;
  final String? message;

  factory Failure.fromCustomException(CustomException e) {
    return Failure(
      code: e.code,
      message: e.message,
    );
  }
}
