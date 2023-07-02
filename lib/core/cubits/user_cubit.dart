import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:saffar_app/core/usecases/get_token_from_local_storage_usecase.dart';
import 'package:saffar_app/core/usecases/get_user_from_local_storage_usecase.dart';

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
}
