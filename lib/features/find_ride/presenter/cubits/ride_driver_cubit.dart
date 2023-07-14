import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saffar_app/core/models/driver.dart';
import 'package:latlong2/latlong.dart';
import 'package:saffar_app/core/utils/snackbar.dart';
import 'package:saffar_app/features/find_ride/domain/usecases/find_ride_driver_usecase.dart';

part 'ride_driver_state.dart';

class RideDriverCubit extends Cubit<RideDriverState> {
  RideDriverCubit() : super(const RideDriverInitial());

  final FindRideDriverUsecase _findRideDriverUsecase = FindRideDriverUsecase();

  void findRideDriver(BuildContext context) async {
    emit(const RideDriverLoading());

    final result = await _findRideDriverUsecase.call();

    result.fold(
      (l) {
        Snackbar.of(context).show(
          l.message ??
              'There was some problem in finding driver. Please try again.',
        );
      },
      (r) {
        emit(RideDriverGot(
          driver: r.driver,
          points: r.points,
        ));
      },
    );
  }
}
