part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();
}

class SplashInitial extends SplashState {
  @override
  List<Object> get props => [];
}

class GeneralSettingsSuccessState extends SplashState {
  const GeneralSettingsSuccessState();

  @override
  List<Object> get props => [];
}

class GeneralSettingsErrorState extends SplashState {
  const GeneralSettingsErrorState();

  @override
  List<Object> get props => [identityHashCode(this)];
}
