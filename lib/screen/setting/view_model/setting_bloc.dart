import 'package:chat_glopr/@core/dependence_injection.dart';
import 'package:chat_glopr/@core/local_model/update_user_info_model.dart';
import 'package:chat_glopr/@core/network/repository/user_repo.dart';
import 'package:chat_glopr/@core/network_model/result_profile_model.dart';
import 'package:chat_glopr/@share/applicationmodel/profile/profile_bloc.dart';
import 'package:chat_glopr/screen/setting/ui/widget_dialog_sign_out.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../@share/base.dart';
import '../../../@share/utils/utils.dart';
import '../../../@share/widgets/flushbar_custom.dart';
import '../../login/ui/login_page.dart';
import '../ui/widget_dialog_change_name.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingInitial()) {
    on<ShowDialogChangeNameEvent>(_showDialogChangeName);
    on<SignOutEvent>(_signOut);
  }
  UserRepo userRepo = inject<UserRepo>();
  Future<void> _showDialogChangeName(
      ShowDialogChangeNameEvent event, Emitter<SettingState> emit) async {
    TextEditingController nameController = TextEditingController(
        text: event.profileBloc.profileDataModel?.fullName);
    return showCupertinoDialog(
        context: event.context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            shadowColor: Colors.white,
            content: WidgetDialogChangeName(
              onTap: (e) {
                _updateUserInfo(
                    emit,
                    e,
                    event.profileBloc.profileDataModel ?? ProfileData(),
                    context);
              },
              nameController: nameController,
            )));
  }

  Future<void> _signOut(SignOutEvent event, Emitter<SettingState> emit) async {
    return showCupertinoDialog(
        context: event.context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            shadowColor: Colors.white,
            content: WidgetDialogSingOut(
              onTap: () async {
                showcirle(context, true);
                event.profileBloc.profileDataModel = null;
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.clear();
                showcirle(context, false);
                goToScreen(context, const LoginPage());
              },
            )));
  }

  Future<void> _updateUserInfo(Emitter<SettingState> emit, String name,
      ProfileData profileData, BuildContext context) async {
    try {
      showLoading(context, true);
      var result = await userRepo.updateUserInfo(UpdateUserInfoModel(
          email: profileData.email ?? '',
          fullName: name,
          phoneNumber: profileData.phoneNumber ?? '',
          gender: profileData.gender ?? '',
          dob: profileData.dob ?? '',
          avatar: profileData.avatar ?? ''));
      showLoading(context, false);
      if (result.success == true && result.statusCode == 200) {
        Navigator.pop(context);
        emit(ChangeNameSuccessState(name: result.data?.fullName ?? ''));
        showFlushBar(context, msg: result.message, status: FLUSHBAR_SUCCESS);
        return;
      }
      showFlushBar(context, msg: result.message, status: FLUSHBAR_ERROR);
    } catch (e) {
      showLoading(context, false);

      showFlushBar(context, msg: 'ERROR', status: FLUSHBAR_ERROR);
    }
  }
}
