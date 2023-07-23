part of 'payment_cubit.dart';

@immutable
abstract class PaymentState {
  const PaymentState();
}

class PaymentInitial extends PaymentState {
  const PaymentInitial({
    required this.price,
  });

  final double price;
}

class PaymentLoading extends PaymentState {
  const PaymentLoading();
}

class PaymentComplete extends PaymentState {
  const PaymentComplete();
}
