part of 'auth_cubit.dart';

@immutable
class AuthState {
  /// Stores the state of auth loading.
  /// By default [loading] is [false]
  const AuthState({
    this.loading = false,
    this.signIn = true,
  });

  final bool loading;
  final bool signIn;

  AuthState copyWith({
    bool? loading,
    bool? signIn,
  }) {
    return AuthState(
      loading: loading ?? this.loading,
      signIn: signIn ?? this.signIn,
    );
  }
}
