import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:saffar_app/core/utils/snackbar.dart';
import 'package:saffar_app/features/user/domain/usecases/delete_token_from_local_storage_usecase.dart';
import 'package:saffar_app/features/user/domain/usecases/delete_user_from_loca_storage_usecase.dart';
import 'package:saffar_app/features/user/domain/usecases/get_token_from_local_storage_usecase.dart';
import 'package:saffar_app/features/user/domain/usecases/get_user_from_local_storage_usecase.dart';

import '../../data/models/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  /// Getting current user and emitting
  /// the current user.
  UserCubit() : super(const UserState());

  final GetUserFromLocalStorageUsecase _getUserFromLocalStorageUsecase =
      GetUserFromLocalStorageUsecase();
  final GetTokenFromLocalStorageUsecase _getTokenFromLocalStorageUsecase =
      GetTokenFromLocalStorageUsecase();
  final DeleteTokenFromLocalStorageUsecase _deleteTokenFromLocalStorageUsecase =
      DeleteTokenFromLocalStorageUsecase();
  final DeleteUserFromLocalStorageUsecase _deleteUserFromLocalStorageUsecase =
      DeleteUserFromLocalStorageUsecase();

  /// Emits user and token state with new user and token
  /// value.
  void emitUserAndToken(User user, String token) {
    emit(UserState(
      currentUser: user,
      token: token,
    ));
  }

  /// Gets current user info from local storage and emits the current user.
  void getCurrentUserFromLocalStorageAndEmitCurrentUser() {
    final User? currentUser = _getUserFromLocalStorageUsecase.call();
    final String? token = _getTokenFromLocalStorageUsecase.call();

    emit(UserState(
      currentUser: currentUser,
      token: token,
    ));
  }

  void deleteCurrentUserFromLocalStorageAndEmitCurrentUser(BuildContext context) async {
    final List<bool> deleteUserResultList = await Future.wait<bool>([
      _deleteTokenFromLocalStorageUsecase.call(),
      _deleteUserFromLocalStorageUsecase.call(),
    ]);

    for (final result in deleteUserResultList) {
      if (!result) {
        Snackbar.of(context).show('Logout failed');
        return;
      }
    }

    emit(const UserState());
  }
}
