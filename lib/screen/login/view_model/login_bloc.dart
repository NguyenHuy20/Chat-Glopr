import 'package:chat_glopr/@core/dependence_injection.dart';
import 'package:chat_glopr/@core/local_model/login_model.dart';
import 'package:chat_glopr/@core/local_model/token_model.dart';
import 'package:chat_glopr/@core/network/repository/auth_repo.dart';
import 'package:chat_glopr/@core/network/repository/notification_repo.dart';
import 'package:chat_glopr/@core/storage/base.dart';
import 'package:chat_glopr/@share/utils/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../@core/local_model/fcm_model.dart';
import '../../../@share/base.dart';
import '../../../@share/widgets/flushbar_custom.dart';
import '../../bottom_navigator/bottom_navigator_screen.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<SubmitLoginEvent>(_submitLogin);
  }
  AuthRepo authRepo = inject<AuthRepo>();
  NotificationRepo notificationRepo = inject<NotificationRepo>();

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> _submitLogin(
      SubmitLoginEvent event, Emitter<LoginState> emit) async {
    try {
      showLoading(event.context, true);
      var result = await authRepo.login(event.model);
      showLoading(event.context, false);
      if (result.success == true && result.statusCode == 200) {
        saveToken(TokenModel(
            accessToken: result.data?.accessToken ?? '',
            refreshToken: result.data?.refreshToken ?? ''));
        await firebaseMessaging.getToken().then((token) async {
          assert(token != null);

          ///save UUID
          var uuid = await getUUID();
          await saveDeviceUUID(uuid);
          await notificationRepo.addFcmToken(FCMModel(
            deviceUuid: uuid,
            fcmToken: token ?? '',
          ));
          // ignore: avoid_print
          print("Firebase token: $token");
        });
        goToScreen(event.context, const BottomNavigatorScreen());
        return;
      }
      showFlushBar(event.context, msg: result.message, status: FLUSHBAR_ERROR);
    } catch (ex) {
      showLoading(event.context, false);
      showFlushBar(event.context, msg: 'Login Fail', status: FLUSHBAR_ERROR);
    }
  }
}
