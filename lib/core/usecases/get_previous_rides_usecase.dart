import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:saffar_app/core/errors/custom_exception.dart';
import 'package:saffar_app/core/errors/failure.dart';
import 'package:saffar_app/features/ride/data/repositories/ride_repo.dart';
import 'package:saffar_app/core/service_locator.dart';

import '../models/ride.dart';

/// Gets all the previous rides of the user
class GetPreviousRidesUsecase {
  final RideRepo _rideRepo = sl<RideRepo>();

  /// Returns a list of previous rides, previous rides without cancellation and 
  /// latest two rides without cancellation. All rides are sorted in descenting
  /// order of start time.
  Future<Either<Failure, List<List<Ride>>>> getListOfPreviousRides() async {
    try {
      final List<Ride> previousRides = await _rideRepo.getPreviousRides();

      // Sorting previous rides in descending order according to its start time 
      previousRides.sort((r1, r2) => -1 * r1.startTime.compareTo(r2.startTime));

      final List<Ride> previousRidesWithoutCancellation =
          previousRides.where((ride) => ride.cancelled == false).toList();

      final List<Ride> latestTwoPreviousRidesWithoutCancellation =
          List.generate(
        min(previousRidesWithoutCancellation.length, 2),
        (index) {
          return previousRidesWithoutCancellation[index];
        },
      );

      return Right([previousRides, previousRidesWithoutCancellation, latestTwoPreviousRidesWithoutCancellation]);
    } on CustomException catch (e) {
      return Left(Failure.fromCustomException(e));
    }
  }
}
