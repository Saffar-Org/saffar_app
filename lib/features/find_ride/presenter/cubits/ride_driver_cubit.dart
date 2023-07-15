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

  Future<void> findRideDriver(
    BuildContext context,
    LatLng userSourcePosition,
  ) async {
    emit(const RideDriverLoading());

    final result = await _findRideDriverUsecase.call(userSourcePosition);

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

  void moveRiderByOnePoint() {
    if (state is RideDriverGot) {
      final RideDriverGot rideDriverGotState = state as RideDriverGot;


      final List<LatLng> movedPoints =
          rideDriverGotState.points.toList().sublist(1);

      emit(RideDriverGot(
        driver: rideDriverGotState.driver,
        points: movedPoints,
      ));
    }
  }
}
