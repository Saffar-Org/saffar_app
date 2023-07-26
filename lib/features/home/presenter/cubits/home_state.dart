part of 'home_cubit.dart';

@immutable
abstract class HomeState {
  const HomeState();
}

/// Initial home state
class HomeInitial extends HomeState {
  const HomeInitial();
}

/// Loading home state
class HomeLoading extends HomeState {
  const HomeLoading();
}
