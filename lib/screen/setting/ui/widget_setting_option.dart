import 'package:chat_glopr/@share/applicationmodel/profile/profile_bloc.dart';
import 'package:chat_glopr/@share/utils/utils.dart';
import 'package:chat_glopr/@share/values/styles.dart';
import 'package:chat_glopr/screen/setting/view_model/setting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:touchable_opacity/touchable_opacity.dart';

import '../../friend/tab_friend_sreen.dart';

class WidgetSettingOption extends StatelessWidget {
  const WidgetSettingOption(
      {super.key, required this.settingBloc, required this.profileBloc});
  final SettingBloc settingBloc;
  final ProfileBloc profileBloc;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      direction: Axis.vertical,
      children: [
        option(
          context,
          title: 'Change Name',
          iconOption: 'assets/icons/change_name.webp',
          onTap: () {
            settingBloc.add(ShowDialogChangeNameEvent(
                profileBloc: profileBloc, context: context));
          },
        ),
        option(
          context,
          title: 'Change Password',
          iconOption: 'assets/icons/change_pass.webp',
          onTap: () {
            settingBloc.add(ShowDialogChangePassEvent(context: context));
          },
        ),
        option(
          context,
          title: 'Change Background',
          iconOption: 'assets/icons/change_name.webp',
        ),
        option(
          context,
          title: 'QR Code',
          iconOption: 'assets/icons/qr_code.webp',
        ),
        option(
          context,
          title: 'Friends',
          iconOption: 'assets/icons/find_friend.webp',
          onTap: () {
            goToScreen(context, const FriendScreen());
          },
        ),
        option(
          context,
          title: 'Sign Out',
          iconOption: 'assets/icons/sign_out.webp',
          onTap: () {
            settingBloc
                .add(SignOutEvent(context: context, profileBloc: profileBloc));
          },
        ),
        option(
          context,
          title: 'Lock Account',
          colorTitle: Colors.red,
          iconOption: 'assets/icons/lock_acc.webp',
        ),
      ],
    );
  }

  Widget option(BuildContext context,
          {required String title,
          Color? colorTitle,
          required String iconOption,
          Function()? onTap}) =>
      TouchableOpacity(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.3,
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Text(
                title,
                style: appStyle.copyWith(fontSize: 16, color: colorTitle),
              ),
            ),
            const SizedBox(
              width: 25,
            ),
            Image.asset(
              iconOption,
              width: 40,
            )
          ],
        ),
      );
}
