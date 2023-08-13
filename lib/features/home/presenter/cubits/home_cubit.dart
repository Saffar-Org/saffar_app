import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:saffar_app/features/user/presenter/cubits/user_cubit.dart';
import 'package:saffar_app/core/models/address.dart';
import 'package:saffar_app/core/usecases/init_rides_repo_usecase.dart';
import 'package:saffar_app/core/utils/snackbar.dart';
import 'package:saffar_app/features/home/domain/usecases/get_current_lat_lon_and_address_usecase.dart';
import 'package:saffar_app/features/location/domain/usecases/request_location_permission_and_enable_location_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeInitial());

  final InitRidesRepoUsecase _initRidesRepoUsecase = InitRidesRepoUsecase();
  final RequestLocationPermissionAndEnableLocationUsecase
      _requestLocationPermissionAndEnableLocationUsecase =
      RequestLocationPermissionAndEnableLocationUsecase();
  final GetCurrentLatLngAndAddressUsecase _getCurrentLatLngAndAddressUsecase = GetCurrentLatLngAndAddressUsecase();

  void initHomeCubit(BuildContext context) {
    final String? token = context.read<UserCubit>().state.token;
    final String? userId = context.read<UserCubit>().state.currentUser?.id;

    if (token != null && userId != null) {
      _initRidesRepoUsecase.call(token, userId);
    }
  }

  Future<bool> requestLocationPermissionAndEnableLocation(
    BuildContext context, {
    bool showLocationAlreadyOnMessage = false,
  }) async {
    final String? error =
        await _requestLocationPermissionAndEnableLocationUsecase.call();

    if (error != null) {
      Snackbar.of(context).show(error);

      return false;
    } else if (showLocationAlreadyOnMessage) {
      Snackbar.of(context).show('Location is already turned on.');
    }

    return true;
  }

  Future<Address?> getCurrentAddress() async {
    emit(const HomeLoading());

    final Address? currentAddress = await _getCurrentLatLngAndAddressUsecase.call();

    emit(const HomeInitial());

    return currentAddress;
  }
}
