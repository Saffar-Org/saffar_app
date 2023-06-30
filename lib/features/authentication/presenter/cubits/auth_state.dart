part of 'auth_cubit.dart';

@immutable
class AuthState {
  /// Stores the state of auth loading.
  /// By default [loading] is [false]
  const AuthState({
    this.loading = false,
  });

  final bool loading;
}
