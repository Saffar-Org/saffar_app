import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saffar_app/core/models/driver.dart';
import 'package:latlong2/latlong.dart';

part 'ride_driver_state.dart';

class RideDriverCubit extends Cubit<RideDriverState> {
  RideDriverCubit() : super(const RideDriverInitial());
}
