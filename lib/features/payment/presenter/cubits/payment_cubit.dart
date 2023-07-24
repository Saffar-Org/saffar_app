import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:saffar_app/features/payment/domain/usecases/get_total_ride_price_usecase.dart';
import 'package:latlong2/latlong.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(const PaymentLoading());

  final GetTotalRidePriceUsecase _getTotalRidePriceUsecase =
      GetTotalRidePriceUsecase();

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
}
