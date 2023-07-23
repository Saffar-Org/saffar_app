import 'package:dartz/dartz.dart';
import 'package:saffar_app/core/errors/custom_exception.dart';
import 'package:saffar_app/core/errors/failure.dart';
import 'package:saffar_app/features/ride/data/repositories/ride_repo.dart';
import 'package:saffar_app/core/service_locator.dart';

import '../../../../core/models/ride.dart';

class AddRideUsecase {
  final RideRepo _rideRepo = sl<RideRepo>();

  Future<Either<Failure, void>> call(Ride ride) async {
    try {
      return Right(await _rideRepo.addRide(ride));
    } on CustomException catch (e) {
      return Left(Failure.fromCustomException(e));
    }
  }
}