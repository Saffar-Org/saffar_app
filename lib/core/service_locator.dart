import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:saffar_app/features/location/data/repositories/location_repo.dart';
import 'package:saffar_app/features/payment/data/repositories/razorpay_repo.dart';
import 'package:saffar_app/features/ride/data/repositories/ride_repo.dart';
import 'package:saffar_app/features/user/data/repositories/user_repo.dart';
import 'package:saffar_app/core/services/validator_service.dart';
import 'package:saffar_app/features/authentication/data/repositories/auth_repo.dart';
import 'package:saffar_app/features/search_places_and_get_route/data/repositories/map_route_repo.dart';
import 'package:saffar_app/features/search_places_and_get_route/data/repositories/search_places_repo.dart';
import 'package:uuid/uuid.dart';

final GetIt sl = GetIt.instance;

Future<void> setUpServices() async {
  // ---------- External Services ----------
  sl.registerSingleton<Dio>(Dio());
  sl.registerSingleton<HiveInterface>(Hive);
  sl.registerSingleton<Uuid>(const Uuid());
  sl.registerSingleton<Razorpay>(Razorpay());

  // ---------- Internal Services ----------
  sl.registerSingleton<ValidatorService>(ValidatorService());

  // ---------- Repos ----------
  sl.registerSingleton<UserRepo>(UserRepo());
  sl.registerSingleton<AuthRepo>(AuthRepo());
  sl.registerSingleton<RideRepo>(RideRepo());
  sl.registerSingleton<SearchPlacesRepo>(SearchPlacesRepo());
  sl.registerSingleton<MapRouteRepo>(MapRouteRepo());
  sl.registerSingleton<LocationRepo>(LocationRepo());
  sl.registerSingleton<RazorpayRepo>(RazorpayRepo());
}
