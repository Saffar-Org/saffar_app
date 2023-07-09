part of 'map_route_cubit.dart';

@immutable
abstract class MapRouteState {
  const MapRouteState();
}

/// Stores the initial state of map route when no route
/// is being asked for
class MapRouteInitial extends MapRouteState {
  const MapRouteInitial();
}

/// Stores the loading state of map route when 
/// the route is being fetched 
class MapRouteLoading extends MapRouteState {
  const MapRouteLoading();
}

/// Stores the route i.e. points of latitudes and longitudes
/// from the source to destination
class MapRouteGot extends MapRouteState {
  const MapRouteGot({
    required this.points,
  });

  final List<LatLng> points;
}
