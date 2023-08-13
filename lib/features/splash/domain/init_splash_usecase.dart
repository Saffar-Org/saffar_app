import 'package:saffar_app/core/errors/custom_exception.dart';
import 'package:saffar_app/features/user/data/repositories/user_repo.dart';
import 'package:saffar_app/core/service_locator.dart';

import '../../../core/errors/failure.dart';

class InitSplashUsecase {
  final UserRepo _userRepo = sl<UserRepo>();

  Future<Failure?> call() async {
    try {
      await _userRepo.initUserRepo();
    } on CustomException catch (e) {
      return Failure.fromCustomException(e);
    }
  }
}
