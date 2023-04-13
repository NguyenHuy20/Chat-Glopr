part of 'verify_otp_bloc.dart';

abstract class VerifyOTPState extends Equatable {
  const VerifyOTPState();
}

class VerifyOTPInitial extends VerifyOTPState {
  @override
  List<Object> get props => [];
}

class ResendCodeSuccessState extends VerifyOTPState {
  final String otp;
  const ResendCodeSuccessState({required this.otp});
  @override
  List<Object> get props => [identityHashCode(this), otp];
}
