import 'package:saffar_app/core/service_locator.dart';
import 'package:saffar_app/core/services/validator_service.dart';

class ValidateNameUsecase {
  final ValidatorService _validatorService = sl<ValidatorService>();

  /// Validates name and returns error message if 
  /// name is not valid else returns [null]
  String? call(String? name) {
    if (name == null || name.isEmpty) {
      return 'Name can not be empty';
    }

    if (!_validatorService.validateName(name)) {
      return 'Invalid name';
    }

    return null;
  }
}
