import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:saffar_app/core/errors/failure.dart';
import 'package:saffar_app/core/usecases/get_previous_rides_usecase.dart';
import 'package:saffar_app/core/usecases/init_rides_repo_usecase.dart';

import '../models/ride.dart';

part 'previous_rides_state.dart';

class PreviousRidesCubit extends Cubit<PreviousRidesState> {
  PreviousRidesCubit() : super(const PreviousRidesLoading());

  final InitRidesRepoUsecase _initRidesRepoUsecase = InitRidesRepoUsecase();
  final GetPreviousRidesUsecase _getPreviousRidesUsecase =
      GetPreviousRidesUsecase();

  /// Initialized Rides Repo and then gets list of previous rides,
  /// previous rides without cancellation and latest two previous rides
  /// without cancellation. Also all the rides are in descending order.
  void init(String token, String userId) async {
    final Failure? failure = _initRidesRepoUsecase.call(token, userId);

    if (failure == null) {
      final result = await _getPreviousRidesUsecase.getListOfPreviousRides();

      result.fold(
        (l) {
          emit(const PreviousRidesGot());
        },
        (r) {
          final List<Ride> previousRides = r[0];
          final List<Ride> previousRidesWithoutCancellation = r[1];
          final List<Ride> latestTwoPreviousRidesWihtoutCancellation = r[2];

          emit(PreviousRidesGot(
            previousRides: previousRides,
            previousRidesWithoutCancellation: previousRidesWithoutCancellation,
            latestTwoPreviousRidesWithoutCancellation: latestTwoPreviousRidesWihtoutCancellation,
          ));
        },
      );
    } else {
      emit(const PreviousRidesGot());
    }
  }
}
