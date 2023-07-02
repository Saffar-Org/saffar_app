import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:saffar_app/core/usecases/get_user_from_local_storage_usecase.dart';
import 'package:saffar_app/core/usecases/put_user_in_local_storage_usercase.dart';

import '../models/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  /// Getting current user and emitting
  /// the current user.
  UserCubit() : super(const UserState());

  final GetUserFromLocalStorageUsecase _getUserFromLocalStorageUsecase =
      GetUserFromLocalStorageUsecase();
  final PutUserInLocalStorageUsecase _putUserInLocalStorageUsecase =
      PutUserInLocalStorageUsecase();

  /// Initialized User Cubit. This must be called once 
  /// in the application before any of the other functions 
  /// of [UserCubit] are called.
  void initUserCubit() {
    final User? currentUser = _getUserFromLocalStorageUsecase.call();

    if (currentUser != null) {
      emit(UserState(currentUser: currentUser));
    }
  }

  /// Puts current user info in local storage and emits the current user
  Future<void> putCurrentUserInfoInLocalStorageAndEmitCurrentUser(
      User user) async {
    await _putUserInLocalStorageUsecase.call(user);
    emit(UserState(currentUser: user));
  }
}
