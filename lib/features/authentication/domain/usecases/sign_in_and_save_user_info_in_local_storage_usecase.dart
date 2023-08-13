import 'package:dartz/dartz.dart';
import 'package:saffar_app/core/errors/custom_exception.dart';
import 'package:saffar_app/core/errors/failure.dart';
import 'package:saffar_app/features/user/data/models/user.dart';
import 'package:saffar_app/features/user/data/repositories/user_repo.dart';
import 'package:saffar_app/core/service_locator.dart';
import 'package:saffar_app/features/authentication/data/repositories/auth_repo.dart';

class SignInAndSaveUserInLocalStorageUsecase {
  final AuthRepo _authRepo = sl<AuthRepo>();
  final UserRepo _userRepo = sl<UserRepo>();

  /// Signs in use and returns a [User] when success else returns a [Failure].
  /// Also saves user info in local storage and emits current user.
  Future<Either<Failure, User>> call(
    String phone,
    String password,
  ) async {
    try {
      final Map<String, dynamic> data = await _authRepo.signIn(phone, password);

      final User user = data['user'];
      final String token = data['token'];

      await _userRepo.putUserMapInLocalStorage(user.toMap());
      await _userRepo.putTokenInLocalStorage(token);

      return Right(user);
    } on CustomException catch (e) {
      return Left(Failure.fromCustomException(e));
    }
  }
}
