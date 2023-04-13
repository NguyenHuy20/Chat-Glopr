part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetDataProfile extends ProfileEvent {
  const GetDataProfile();

  List<Object> get prop => [];
}

class SplashCheckProfile extends ProfileEvent {
  const SplashCheckProfile();

  List<Object> get prop => [];
}
