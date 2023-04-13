part of 'verify_otp_bloc.dart';

abstract class VerifyOTPEvent extends Equatable {
  const VerifyOTPEvent();

  @override
  List<Object> get props => [];
}

class RegisterAccountEvent extends VerifyOTPEvent {
  final RegisterModel model;
  final BuildContext context;
  const RegisterAccountEvent({required this.model, required this.context});

  @override
  List<Object> get props => [];
}

class ResendOTPEvent extends VerifyOTPEvent {
  final RequestOTPModel model;
  final BuildContext context;
  late String otp;
  ResendOTPEvent(
      {required this.model, required this.otp, required this.context});
  @override
  List<Object> get props => [];
}
