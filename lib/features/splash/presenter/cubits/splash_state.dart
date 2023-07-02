part of 'splash_cubit.dart';

@immutable
abstract class SplashState {
  const SplashState();
}

class SplashDone extends SplashState {
  const SplashDone();
}

class SplashLoading extends SplashState {
  const SplashLoading();
}
