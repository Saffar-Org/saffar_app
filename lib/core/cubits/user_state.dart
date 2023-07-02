part of 'user_cubit.dart';

@immutable
/// Contains the state of current user and its token.
class UserState {
  const UserState({
    this.currentUser,
    this.token,
  });

  final User? currentUser;
  final String? token;

  bool get isLoggedIn => currentUser != null && token != null;
}
