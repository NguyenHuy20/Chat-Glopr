part of 'setting_bloc.dart';

abstract class SettingState extends Equatable {
  const SettingState();
}

class SettingInitial extends SettingState {
  @override
  List<Object> get props => [];
}

class ChangeNameSuccessState extends SettingState {
  final String name;
  const ChangeNameSuccessState({required this.name});
  @override
  List<Object> get props => [identityHashCode(this), name];
}

class ChangeAvatarSuccessState extends SettingState {
  final String avatar;
  const ChangeAvatarSuccessState({required this.avatar});
  @override
  List<Object> get props => [identityHashCode(this), avatar];
}
