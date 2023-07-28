import 'package:flutter_dotenv/flutter_dotenv.dart';

class Strings {
  static String baseApiUrl = dotenv.env['BASE_API_URL']!;
  static String mapApiKey = dotenv.env['TOMTOM_MAP_API']!;
  static String razorpayKeyId = dotenv.env['RAZORPAY_KEY_ID']!;
  static String razorpayKeySecret = dotenv.env['RAZORPAY_KEY_SECRET']!;
  static const String saffarCaption = 'Ride with ease and comfort.';
}