import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:saffar_app/core/utils/snackbar.dart';
import 'package:saffar_app/features/search_places_and_get_route/domain/usecases/get_points_from_source_to_destination_usecase.dart';

part 'map_route_state.dart';

class MapRouteCubit extends Cubit<MapRouteState> {
  MapRouteCubit() : super(const MapRouteInitial());

  final GetPointsFromSourceToDestinationUsecase
      _getPointsFromSourceToDestinationUsecase =
      GetPointsFromSourceToDestinationUsecase();

  /// Gets the route from source to destination
  Future<void> getRouteFromSourceToDestination(
    BuildContext context,
    LatLng sourceLatLng,
    LatLng destinationLatLng,
  ) async {
    emit(const MapRouteLoading());

    final result = await _getPointsFromSourceToDestinationUsecase.call(
      sourceLatLng,
      destinationLatLng,
    );

    result.fold(
      (l) {
        Snackbar.of(context).show('There was some problem in getting the route. Please try again after some time.');
        emit(const MapRouteInitial());
      },
      (r) {
        emit(MapRouteGot(points: r));
      },
    );
  }

  /// Clears the current route
  void clearRoute() {
    emit(const MapRouteInitial());
  }
}
