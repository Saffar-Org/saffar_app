import 'package:saffar_app/core/errors/custom_exception.dart';
import 'package:saffar_app/core/errors/failure.dart';
import 'package:saffar_app/features/ride/data/repositories/ride_repo.dart';
import 'package:saffar_app/core/service_locator.dart';

class InitRidesRepoUsecase {
  final RideRepo _ridesRepo = sl<RideRepo>();

  Failure? call(
    String token,
    String userId,
  ) {
    try {
      _ridesRepo.initRidesRepo(token, userId);
    } on CustomException catch (e) {
      return Failure.fromCustomException(e);
    }
  }
}
