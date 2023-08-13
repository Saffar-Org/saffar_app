import 'package:flutter/cupertino.dart';
import 'package:saffar_app/features/user/presenter/cubits/user_cubit.dart';
import 'package:saffar_app/features/splash/domain/init_splash_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failure.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashLoading());

  final InitSplashUsecase _initSplashUsecase = InitSplashUsecase();

  /// Call this function in the [initState] function of
  /// Splash Screen.
  void init(BuildContext context) async {
    final Failure? failure = await _initSplashUsecase.call();

    if (failure == null) {
      context
          .read<UserCubit>()
          .getCurrentUserFromLocalStorageAndEmitCurrentUser();
    }

    emit(const SplashDone());
  }
}
