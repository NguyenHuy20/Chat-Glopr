part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileSuccessState extends ProfileState {
  final ProfileData data;
  const ProfileSuccessState({required this.data});

  @override
  List<Object> get props => [data];
}

class ProfileErrorState extends ProfileState {
  final String msg;
  const ProfileErrorState({required this.msg});

  @override
  List<Object> get props => [];
}

class CheckProfileSuccessState extends ProfileState {
  final String pincode;
  const CheckProfileSuccessState(this.pincode);

  @override
  List<Object> get props => [];
}

class CheckProfileErrorState extends ProfileState {
  const CheckProfileErrorState();
  @override
  List<Object> get props => [];
}
