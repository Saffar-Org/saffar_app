import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:saffar_app/core/errors/custom_exception.dart';
import 'package:saffar_app/core/service_locator.dart';

import '../../../../core/constants/strings.dart';

class RazorpayRepo {
  final Dio _dio = sl<Dio>();
  final Razorpay _razorpay = sl<Razorpay>();

  Future<void> payViaRazorpay(
    double amount,
    String phone,
  ) async {
    try {
      // If amount is 123.44321 then it will be converted to 123.44 * 100 = 12344
      final double finalAmount =
          double.parse(amount.toStringAsFixed(2)) * 100.0;

      final Response response = await _dio.post(
        'https://api.razorpay.com/v1/orders',
        options: Options(
          contentType: 'application/json',
          headers: {
            'authorization':
                'Basic ${base64Encode(utf8.encode('${Strings.razorpayKeyId}:${Strings.razorpayKeySecret}'))}',
          },
        ),
        data: {
          'amount': finalAmount.toInt(),
          'currency': 'INR',
        },
      );

      final Map<String, dynamic> options = {
        'key': Strings.razorpayKeyId,
        'amount': finalAmount,
        'name': 'Saffar',
        'order_id': response.data['id'],
        'timeout': 60, // in seconds
        'prefill': {'contact': phone, 'email': 'gaurav.kumar@example.com'}
      };

      _razorpay.open(options);
    } on DioException catch (e) {
      throw CustomException(message: e.toString());
    }
  }
}
