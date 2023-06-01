import 'package:badges/badges.dart';
import 'package:chat_glopr/@share/values/styles.dart';
import 'package:chat_glopr/screen/setting/view_model/setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/src/badge.dart' as badge;
import 'package:touchable_opacity/touchable_opacity.dart';
import '../../../@share/applicationmodel/profile/profile_bloc.dart';
import 'widget_setting_option.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late ProfileBloc profileBloc;
  late SettingBloc settingBloc;

  @override
  void initState() {
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    settingBloc = BlocProvider.of<SettingBloc>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingBloc, SettingState>(
      listener: (context, state) {
        if (state is ChangeNameSuccessState) {
          setState(() {
            profileBloc.profileDataModel?.fullName = state.name;
          });
        }
        if (state is ChangeAvatarSuccessState) {
          setState(() {
            profileBloc.profileDataModel?.avatar = state.avatar;
          });
        }
      },
      child: Scaffold(
          body: Container(
              padding: const EdgeInsets.only(top: 75),
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/bg_setting.webp'),
                      fit: BoxFit.fill)),
              child: ListView(
                padding: const EdgeInsets.all(0),
                children: [
                  TouchableOpacity(
                    onTap: () {
                      settingBloc.add(ShowBottomImagePickerEvent(
                          profileBloc: profileBloc,
                          context: context,
                          settingBloc: settingBloc));
                    },
                    child: Center(
                      child: badge.Badge(
                        animationDuration: const Duration(milliseconds: 0),
                        badgeContent: Container(
                          padding: const EdgeInsets.all(17),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xff29B113)),
                        ),
                        badgeColor: Colors.white,
                        position: BadgePosition.bottomEnd(bottom: 5, end: 18),
                        padding: const EdgeInsets.all(3),
                        toAnimate: true,
                        animationType: BadgeAnimationType.slide,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          width: 206,
                          height: 206,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        profileBloc.profileDataModel?.avatar ??
                                            ''))),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      profileBloc.profileDataModel?.fullName ?? '',
                      style: titleStyle.copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  WidgetSettingOption(
                    profileBloc: profileBloc,
                    settingBloc: settingBloc,
                  )
                ],
              ))),
    );
  }
}
