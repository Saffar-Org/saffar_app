part of 'user_cubit.dart';

@immutable
/// Contains the state of current user.
class UserState {
  const UserState({
    this.currentUser,
  });

  final User? currentUser;
}
