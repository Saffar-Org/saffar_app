import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:saffar_app/core/service_locator.dart';
import 'package:saffar_app/main.dart';

/// When running in Development mode this 
/// main function will be called.
void main() async {
  debugPrint('Application running in Development Mode');

  // Loading dev.env file
  await dotenv.load(fileName: 'dev.env');

  // Registers services
  setUpServices();

  runApp(const MyApp());
}