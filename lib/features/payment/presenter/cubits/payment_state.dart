part of 'payment_cubit.dart';

@immutable
abstract class PaymentState {
  const PaymentState();
}

/// When payment has not started
class PaymentInitial extends PaymentState {
  const PaymentInitial({
    required this.price,
  });

  final double price;
}

// When getting price or payment in ongoing
class PaymentLoading extends PaymentState {
  const PaymentLoading();
}

// When payment in complete
class PaymentComplete extends PaymentState {
  const PaymentComplete();
}
