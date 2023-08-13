import 'package:saffar_app/core/errors/custom_exception.dart';
import 'package:saffar_app/features/user/data/repositories/user_repo.dart';
import 'package:saffar_app/core/service_locator.dart';

class GetTokenFromLocalStorageUsecase {
  final UserRepo _userRepo = sl<UserRepo>();

  /// Gets token from local storage.
  String? call() {
    try {
      final String token = _userRepo.getTokenFromLocalStorage();

      return token;
    } on CustomException {
      return null;
    }
  }
}
