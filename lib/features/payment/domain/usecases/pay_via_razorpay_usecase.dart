import 'package:saffar_app/core/service_locator.dart';
import 'package:saffar_app/features/payment/data/repositories/razorpay_repo.dart';

class PayViaRazorpayUsecase {
  final RazorpayRepo _razorpayRepo = sl<RazorpayRepo>();

  Future<void> call(
    double amount,
    String phone,
  ) {
    return _razorpayRepo.payViaRazorpay(
      amount,
      phone,
    );
  }
}
