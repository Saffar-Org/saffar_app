import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saffar_app/features/authentication/presenter/cubits/auth_cubit.dart';
import 'package:saffar_app/features/authentication/presenter/screens/sign_in_screen.dart';
import 'package:saffar_app/features/authentication/presenter/screens/sign_up_screen.dart';

/// Wrapper around sign in and sign up screens
/// so that it can toggle between the two screens
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  late final AuthCubit _authCubit;

  @override
  void initState() {
    super.initState();

    _authCubit = AuthCubit();
  }

  @override
  void dispose() {
    _authCubit.close();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _authCubit,
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return state.signIn ? const SignInScreen() : const SignUpScreen();
        },
      ),
    );
  }
}
