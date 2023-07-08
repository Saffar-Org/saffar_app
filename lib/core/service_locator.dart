import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:saffar_app/core/repositories/rides_repo.dart';
import 'package:saffar_app/core/repositories/user_repo.dart';
import 'package:saffar_app/core/services/validator_service.dart';
import 'package:saffar_app/features/authentication/data/repositories/auth_repo.dart';
import 'package:saffar_app/features/search_places/data/repositories/search_places_repo.dart';
import 'package:uuid/uuid.dart';

final GetIt sl = GetIt.instance;

Future<void> setUpServices() async {
  // ---------- External Services ----------
  sl.registerSingleton<Dio>(Dio());
  sl.registerSingleton<HiveInterface>(Hive);
  sl.registerSingleton<Uuid>(const Uuid());

  // ---------- Internal Services ----------
  sl.registerSingleton<ValidatorService>(ValidatorService());

  // ---------- Repos ----------
  sl.registerSingleton<UserRepo>(UserRepo());
  sl.registerSingleton<AuthRepo>(AuthRepo());
  sl.registerSingleton<RidesRepo>(RidesRepo());
  sl.registerSingleton<SearchPlacesRepo>(SearchPlacesRepo());
}
