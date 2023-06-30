import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saffar_app/core/cubits/user_cubit.dart';
import 'package:saffar_app/features/authentication/presenter/view/sign_in_screen.dart';
import 'package:saffar_app/features/home/presenter/screens/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  static const String routeName = '/wrapper';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return state.currentUser != null
            ? const HomeScreen()
            : const SignInScreen();
      },
    );
  }
}
