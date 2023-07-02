import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:saffar_app/core/errors/custom_exception.dart';
import 'package:saffar_app/core/errors/failure.dart';
import 'package:saffar_app/core/models/user.dart';
import 'package:saffar_app/core/service_locator.dart';
import 'package:saffar_app/features/authentication/data/repositories/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cubits/user_cubit.dart';

class SignUpAndSaveUserInLocalStorageUsecase {
  final AuthRepo _authRepo = sl<AuthRepo>();

  /// Signs up use and returns a [User] when success else returns a [Failure].
  /// Also saves user info in local storage and emits current user.
  Future<Either<Failure, User>> call(
    BuildContext context,
    String name,
    String phone,
    String password,
  ) async {
    try {
      final Map<String, dynamic> data = await _authRepo.signUp(name, phone, password);

      final User user = data['user'];
      final String token = data['token'];

      context
          .read<UserCubit>()
          .putCurrentUserInLocalStorageAndEmitCurrentUser(user, token);

      return Right(user);
    } on CustomException catch (e) {
      return Left(Failure.fromCustomException(e));
    }
  }
}
