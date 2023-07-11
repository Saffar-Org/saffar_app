import 'package:dartz/dartz.dart';
import 'package:saffar_app/core/errors/custom_exception.dart';
import 'package:saffar_app/core/errors/failure.dart';
import 'package:saffar_app/core/repositories/ride_repo.dart';
import 'package:saffar_app/core/service_locator.dart';

class FindRideDriverUsecase {
  final RideRepo _rideRepo = sl<RideRepo>();

  /// Find ride Driver info and driver source and destination position 
  Future<Either<Failure, Map<String, dynamic>>> call() async {
    try {
      final Map<String, dynamic> data = await _rideRepo.findRideDriver();

      return Right(data);
    } on CustomException catch (e) {
      return Left(Failure.fromCustomException(e));
    }
  }
}
