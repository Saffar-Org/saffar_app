import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:saffar_app/core/service_locator.dart';
import 'package:saffar_app/main.dart';

/// When running in Development mode this
/// main function will be called.
void main() async {
  debugPrint('Application running in Development Mode');

  WidgetsFlutterBinding.ensureInitialized();

  // Locking app in portrait mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // Loading dev.env file.
  await dotenv.load(fileName: 'dev.env');

  // Initializing hive with a temp sub directory.
  await Hive.initFlutter();

  // Registers services.
  await setUpServices();

  runApp(const MyApp());
}
