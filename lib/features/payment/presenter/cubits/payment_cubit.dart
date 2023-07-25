import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:saffar_app/core/usecases/create_ride_usecase.dart';
import 'package:saffar_app/features/payment/domain/usecases/get_total_ride_price_usecase.dart';
import 'package:latlong2/latlong.dart';
import 'package:saffar_app/features/ride/domain/usecases/add_ride_usecase.dart';

import '../../../../core/models/address.dart';
import '../../../../core/models/driver.dart';
import '../../../../core/models/ride.dart';
import '../../../../core/models/user.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(const PaymentLoading());

  final GetTotalRidePriceUsecase _getTotalRidePriceUsecase =
      GetTotalRidePriceUsecase();
  final CreateRideUsecase _createRideUsecase = CreateRideUsecase();
  final AddRideUsecase _addRideUsecase = AddRideUsecase();

  void getTotalRidePrice(
    LatLng sourcePosition,
    LatLng destinationPosition,
  ) async {
    emit(const PaymentLoading());

    final result = await _getTotalRidePriceUsecase.call(
      sourcePosition,
      destinationPosition,
    );

    result.fold(
      (l) {},
      (r) {
        emit(PaymentInitial(price: r));
      },
    );
  }

  void addRide({
    required User user,
    required Driver driver,
    required Address sourceAddress,
    required Address destinationAddress,
    required DateTime startTime,
    DateTime? endTime,
    required bool cancelled,
    required double price,
    double? discountPrice,
  }) async {
    emit(const PaymentLoading());

    final Ride ride = _createRideUsecase.call(
      user: user,
      driver: driver,
      sourceAddress: sourceAddress,
      destinationAddress: destinationAddress,
      startTime: startTime,
      endTime: endTime,
      cancelled: cancelled,
      price: price,
      discountPrice: discountPrice,
    );

    await _addRideUsecase.call(ride);

    emit(const PaymentComplete());
  }
}