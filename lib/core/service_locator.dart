import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

void setUpServices() {
  sl.registerSingleton<Dio>(Dio());
}