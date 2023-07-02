import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:saffar_app/core/usecases/get_previous_rides_usecase.dart';

import '../models/ride.dart';

part 'previous_rides_state.dart';

class PreviousRidesCubit extends Cubit<PreviousRidesState> {
  /// When Cubit is creates then a function is called which
  /// gets all the previous rides by the user and those rides
  /// which were not cancelled among the previous rides are emitted.
  /// If there is a [Failure] then empty list is emitted.
  PreviousRidesCubit() : super(const PreviousRidesLoading()) {
    _getPreviousRidesUsecase.getListOfPreviousRides().then((result) {
      result.fold(
        (l) {
          print('Error: ${l.message}');

          emit(const PreviousRidesGot());
        },
        (r) {
          final List<Ride> previousRides = r[0];
          final List<Ride> previousRidesWithoutCancellation = r[1];
          final List<Ride> latestTwoRidesWithoutCancellation = r[2];

          emit(PreviousRidesGot(
            previousRides: previousRides,
            previousRidesWithoutCancellation: previousRidesWithoutCancellation,
            latestTwoPreviousRides: latestTwoRidesWithoutCancellation,
          ));
        },
      );
    });
  }

  final GetPreviousRidesUsecase _getPreviousRidesUsecase =
      GetPreviousRidesUsecase();
}
