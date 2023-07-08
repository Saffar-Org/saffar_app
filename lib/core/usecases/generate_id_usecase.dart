import 'package:saffar_app/core/service_locator.dart';
import 'package:uuid/uuid.dart';

class GenerateIdUsecase {
  final Uuid _uuid = sl<Uuid>();

  /// Generates a ID
  String call() {
    return _uuid.v4();
  }
}