part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  List<Object> get props => [];
}

class GetDataProfile extends ProfileEvent {
  List<Object> get prop => [];
}

class SplashCheckProfile extends ProfileEvent {
  List<Object> get prop => [];
}

class ClearProfileEvent extends ProfileEvent {
  List<Object> get prop => [];
}
