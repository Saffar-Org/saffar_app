import 'package:saffar_app/core/service_locator.dart';
import 'package:saffar_app/core/services/validator_service.dart';

class ValidatePasswordUsecase {
  final ValidatorService _validatorService = sl<ValidatorService>();

  /// Validates password and returns error message if 
  /// password is not valid else returns [null]
  String? call(String? password) {
    if (password == null || password.isEmpty)  {
      return 'Password can not be empty';
    }

    if (!_validatorService.validatePassword(password)) {
      return 'Password must contain atleast 8 characters';
    }

    return null;
  }
}