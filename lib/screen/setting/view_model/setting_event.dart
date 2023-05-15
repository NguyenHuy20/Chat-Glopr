part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class ShowDialogChangeNameEvent extends SettingEvent {
  final BuildContext context;
  final ProfileBloc profileBloc;
  const ShowDialogChangeNameEvent(
      {required this.context, required this.profileBloc});
  @override
  List<Object> get props => [];
}

class SignOutEvent extends SettingEvent {
  final ProfileBloc profileBloc;
  final BuildContext context;
  const SignOutEvent({required this.context, required this.profileBloc});
  @override
  List<Object> get props => [];
}

class ShowBottomImagePickerEvent extends SettingEvent {
  final BuildContext context;
  final SettingBloc settingBloc;
  final ProfileBloc profileBloc;
  const ShowBottomImagePickerEvent(
      {required this.context,
      required this.settingBloc,
      required this.profileBloc});
  @override
  List<Object> get props => [];
}

class UploadImageEvent extends SettingEvent {
  final File file;
  final ProfileData profileData;
  final BuildContext context;
  const UploadImageEvent(
      {required this.file, required this.profileData, required this.context});
  @override
  List<Object> get props => [];
}
