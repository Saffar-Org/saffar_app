part of 'map_route_cubit.dart';

@immutable
abstract class MapRouteState {
  const MapRouteState();
}

class MapRouteInitial extends MapRouteState {
  const MapRouteInitial();
}

class MapRouteLoading extends MapRouteState {
  const MapRouteLoading();
}

class MapRouteGot extends MapRouteState {
  const MapRouteGot({
    required this.points,
  });

  final List<LatLng> points;
}
