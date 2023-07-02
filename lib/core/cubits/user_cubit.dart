import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:saffar_app/core/usecases/get_token_from_local_storage_usecase.dart';
import 'package:saffar_app/core/usecases/get_user_from_local_storage_usecase.dart';
import 'package:saffar_app/core/usecases/put_token_in_local_storage_usecase.dart';
import 'package:saffar_app/core/usecases/put_user_in_local_storage_usercase.dart';

import '../models/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  /// Getting current user and emitting
  /// the current user.
  UserCubit() : super(const UserState());

  final GetUserFromLocalStorageUsecase _getUserFromLocalStorageUsecase =
      GetUserFromLocalStorageUsecase();
  final GetTokenFromLocalStorageUsecase _getTokenFromLocalStorageUsecase =
      GetTokenFromLocalStorageUsecase();
  final PutUserInLocalStorageUsecase _putUserInLocalStorageUsecase =
      PutUserInLocalStorageUsecase();
  final PutTokenInLocalStorageUsecase _putTokenInLocalStorageUsecase =
      PutTokenInLocalStorageUsecase();

  /// Gets current user info from local storage and emits the current user.
  void getCurrentUserFromLocalStorageAndEmitCurrentUser() {
    final User? currentUser = _getUserFromLocalStorageUsecase.call();
    final String? token = _getTokenFromLocalStorageUsecase.call();

    emit(UserState(
      currentUser: currentUser,
      token: token,
    ));
  }

  /// Puts current user info in local storage and emits the current user
  Future<void> putCurrentUserInLocalStorageAndEmitCurrentUser(
    User user,
    String token,
  ) async {
    await _putUserInLocalStorageUsecase.call(user);
    await _putTokenInLocalStorageUsecase.call(token);

    emit(UserState(
      currentUser: user,
      token: token,
    ));
  }
}
