import 'package:saffar_app/core/service_locator.dart';
import 'package:saffar_app/core/services/validator_service.dart';

class ValidatePhoneUsecase {
  final ValidatorService _validatorService = sl<ValidatorService>();

  /// Validates phone number and returns an error message 
  /// if phone is not valid else returns [null]
  String? call(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Phone number can not be empty';
    }

    if (!_validatorService.validatePhone(phone)) {
      return 'Invalid phone number';
    }

    return null;
  }
}
