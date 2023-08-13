import 'package:saffar_app/core/errors/custom_exception.dart';
import 'package:saffar_app/features/user/data/repositories/user_repo.dart';
import 'package:saffar_app/core/service_locator.dart';

class PutTokenInLocalStorageUsecase {
  final UserRepo _userRepo = sl<UserRepo>();

  /// Gets token from local storage.
  /// If [CustomException] caught then rethrow [CustomException].
  Future<void> call(String token) async {
    try {
      await _userRepo.putTokenInLocalStorage(token);
    } on CustomException {
      rethrow;
    }
  }
}
