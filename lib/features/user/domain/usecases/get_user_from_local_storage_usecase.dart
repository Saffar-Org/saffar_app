import 'package:saffar_app/core/errors/custom_exception.dart';
import 'package:saffar_app/features/user/data/models/user.dart';
import 'package:saffar_app/features/user/data/repositories/user_repo.dart';
import 'package:saffar_app/core/service_locator.dart';

class GetUserFromLocalStorageUsecase {
  final UserRepo _userRepo = sl<UserRepo>();

  /// Gets user map and changes it to User model.
  User? call() {
    try {
      final Map<dynamic, dynamic> userMap = _userRepo.getUserMapFromLocalStorage();

      return User.fromMap(userMap);
    } on CustomException {
      return null;
    }
  }
}
