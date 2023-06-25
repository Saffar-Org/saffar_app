import 'package:dartz/dartz.dart';
import 'package:saffar_app/core/errors/custom_exception.dart';
import 'package:saffar_app/core/errors/failure.dart';
import 'package:saffar_app/core/models/user.dart';
import 'package:saffar_app/core/service_locator.dart';
import 'package:saffar_app/features/authentication/data/repositories/auth_repo.dart';

class SignInUsecase {
  final AuthRepo _authRepo = sl<AuthRepo>();

  /// Signs in use and returns a [User] when success else returns a [Failure]
  Future<Either<Failure, User>> call(String phone, String password) async {
    try {
      final User user = await _authRepo.signIn(phone, password);
      return Right(user);
    } on CustomException catch (e) {
      return Left(Failure.fromCustomException(e));
    }
  }
}
