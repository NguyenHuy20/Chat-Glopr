import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    // on<SplashInitialEvent>(_onSplashInitialEvent);
  }

  // Future<void> _onSplashInitialEvent(
  //     SplashInitialEvent event, Emitter<SplashState> emit) async {
  //   // PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   // await saveAppVersion(packageInfo.version);
  //   // emit(const GeneralSettingsSuccessState());
  // }
}
