part of 'auth_cubit.dart';

@immutable
class AuthState {
  const AuthState({
    this.loading = false,
  });

  final bool loading;
}
