import 'package:saffar_app/features/user/data/repositories/user_repo.dart';
import 'package:saffar_app/core/service_locator.dart';

class DeleteTokenFromLocalStorageUsecase {
  final UserRepo _userRepo = sl<UserRepo>();

  /// Delete token from local storage
  Future<bool> call() {
    return _userRepo.deleteTokenFromLocalStorage();
  }
}
