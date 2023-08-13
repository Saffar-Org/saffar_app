import 'package:saffar_app/core/errors/custom_exception.dart';
import 'package:saffar_app/features/user/data/models/user.dart';
import 'package:saffar_app/features/user/data/repositories/user_repo.dart';
import 'package:saffar_app/core/service_locator.dart';

class PutUserInLocalStorageUsecase {
  final UserRepo _userRepo = sl<UserRepo>();

  /// Gets user map and changes it to User model.
  /// If [CustomException] caught then rethrow [CustomException].
  Future<void> call(User user) async {
    try {
      final Map<dynamic, dynamic> userMap = user.toMap();

      await _userRepo.putUserMapInLocalStorage(userMap);
    } on CustomException {
      rethrow;
    }
  }
}
