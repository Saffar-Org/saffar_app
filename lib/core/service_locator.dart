import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:saffar_app/core/services/validator_service.dart';
import 'package:saffar_app/features/authentication/data/repositories/auth_repo.dart';

final GetIt sl = GetIt.instance;

void setUpServices() {
  // External Services
  sl.registerSingleton<Dio>(Dio());

  // Internal Services
  sl.registerSingleton<ValidatorService>(ValidatorService());

  // Repos
  sl.registerSingleton<AuthRepo>(AuthRepo());

  // Usecases
}