import 'package:flutter_dotenv/flutter_dotenv.dart';

class Strings {
  static String baseApiUrl = dotenv.env['BASE_API_URL']!;
  static String mapApiKey = dotenv.env['TOMTOM_MAP_API']!;
  static const String saffarCaption = 'Ride with ease and comfort.';
}