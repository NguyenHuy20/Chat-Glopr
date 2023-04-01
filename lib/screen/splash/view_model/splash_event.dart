part of 'splash_bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

class SplashInitialEvent extends SplashEvent {
  final BuildContext context;
  const SplashInitialEvent({required this.context});

  List<Object> get prop => [];
}