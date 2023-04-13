part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class SendOTPEvent extends RegisterEvent {
  final RegisterModel model;
  final BuildContext context;
  const SendOTPEvent({required this.model, required this.context});
  @override
  List<Object> get props => [];
}
