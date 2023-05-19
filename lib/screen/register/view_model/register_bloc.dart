import 'package:chat_glopr/@core/local_model/register_model.dart';
import 'package:chat_glopr/@core/local_model/request_otp_model.dart';
import 'package:chat_glopr/@core/network/repository/user_repo.dart';
import 'package:chat_glopr/@share/utils/utils.dart';
import 'package:chat_glopr/screen/verify_otp/ui/verify_otp_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../@core/dependence_injection.dart';
import '../../../@share/widgets/flushbar_custom.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<SendOTPEvent>(_sendOTP);
  }
  UserRepo userRepo = inject<UserRepo>();
  Future<void> _sendOTP(SendOTPEvent event, Emitter<RegisterState> emit) async {
    try {
      showLoading(event.context, true);
      var result = await userRepo.requestOTP(RequestOTPModel(
          context: 'CREATE_USERS',
          identity: event.model.identity,
          method: 'EMAIL',
          format: 'NUMBER_ONLY'));
      showLoading(event.context, false);
      if (result.success == true && result.statusCode == 200) {
        event.model.otpCode = result.data?.otpCode ?? '';
        goToScreen(event.context, VerifyOTPPage(model: event.model));
        return;
      }

      showFlushBar(event.context,
          msg: result.message ?? '', status: FLUSHBAR_ERROR);
    } catch (ex) {
      showFlushBar(event.context,
          msg: 'Some thing wrong! Try again', status: FLUSHBAR_ERROR);
    }
  }
}
