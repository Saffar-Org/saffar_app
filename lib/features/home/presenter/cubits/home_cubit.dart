import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:saffar_app/core/cubits/user_cubit.dart';
import 'package:saffar_app/core/usecases/init_rides_repo_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final InitRidesRepoUsecase _initRidesRepoUsecase = InitRidesRepoUsecase();

  void initHomeCubit(BuildContext context) {
    final String? token = context.read<UserCubit>().state.token;
    final String? userId = context.read<UserCubit>().state.currentUser?.id;

    if (token != null && userId != null) {
      _initRidesRepoUsecase.call(token, userId);
    }
  }
}
