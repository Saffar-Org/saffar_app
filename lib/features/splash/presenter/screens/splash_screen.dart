import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saffar_app/features/splash/presenter/cubits/splash_cubit.dart';
import 'package:saffar_app/wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    context.read<SplashCubit>().init(context);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<SplashCubit, SplashState>(
      builder: (context, state) {
        if (state is SplashLoading) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: colorScheme.primary,
              ),
            ),
          );
        } else if (state is SplashDone) {
          return const Wrapper();
        } else {
          return Center(
            child: Text(
              'No UI for state: $state',
            ),
          );
        }
      },
    );
  }
}
