part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class SubmitLoginEvent extends LoginEvent {
  final LoginModel model;
  final BuildContext context;
  const SubmitLoginEvent({required this.model, required this.context});
  @override
  List<Object> get props => [];
}
