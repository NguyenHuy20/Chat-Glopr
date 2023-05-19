import 'package:chat_glopr/@core/dependence_injection.dart';
import 'package:chat_glopr/@core/local_model/register_model.dart';
import 'package:chat_glopr/@core/local_model/request_otp_model.dart';
import 'package:chat_glopr/@core/network/repository/auth_repo.dart';
import 'package:chat_glopr/@core/network/repository/user_repo.dart';
import 'package:chat_glopr/@share/utils/utils.dart';
import 'package:chat_glopr/screen/login/ui/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../@share/widgets/flushbar_custom.dart';

part 'verify_otp_event.dart';
part 'verify_otp_state.dart';

class VerifyOTPBloc extends Bloc<VerifyOTPEvent, VerifyOTPState> {
  VerifyOTPBloc() : super(VerifyOTPInitial()) {
    on<RegisterAccountEvent>(_register);
    on<ResendOTPEvent>(_resendCode);
  }
  AuthRepo authRepo = inject<AuthRepo>();
  UserRepo userRepo = inject<UserRepo>();
  Future<void> _register(
      RegisterAccountEvent event, Emitter<VerifyOTPState> emit) async {
    try {
      showLoading(event.context, true);
      var result = await authRepo.register(event.model);
      showLoading(event.context, false);
      if (result.success == true) {
        goToScreen(event.context, LoginPage());
        return;
      }
      showFlushBar(event.context,
          msg: result.message ?? '', status: FLUSHBAR_ERROR);
    } catch (ex) {
      showLoading(event.context, false);

      showFlushBar(event.context, msg: 'Register Fail', status: FLUSHBAR_ERROR);
    }
  }

  Future<void> _resendCode(
      ResendOTPEvent event, Emitter<VerifyOTPState> emit) async {
    try {
      var result = await userRepo.requestOTP(event.model);
      if (result.statusCode == 200) {
        showFlushBar(event.context,
            msg: 'Đã gửi OTP', status: FLUSHBAR_SUCCESS);
        emit(ResendCodeSuccessState(otp: result.data?.otpCode ?? ''));
        return;
      }
      showFlushBar(event.context,
          msg: result.message ?? '', status: FLUSHBAR_ERROR);
    } catch (ex) {}
  }
}
