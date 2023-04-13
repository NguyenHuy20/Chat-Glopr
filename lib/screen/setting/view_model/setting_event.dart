part of 'setting_bloc.dart';

abstract class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class ShowDialogChangeNameEvent extends SettingEvent {
  final BuildContext context;
  final String fullName;
  const ShowDialogChangeNameEvent(
      {required this.context, required this.fullName});
  @override
  List<Object> get props => [];
}
