import 'package:saffar_app/features/user/data/repositories/user_repo.dart';
import 'package:saffar_app/core/service_locator.dart';

class DeleteUserFromLocalStorageUsecase {
  final UserRepo _userRepo = sl<UserRepo>();

  /// Delete user from local storage
  Future<bool> call() {
    return _userRepo.deleteUserFromLocalStorage();
  }
}
