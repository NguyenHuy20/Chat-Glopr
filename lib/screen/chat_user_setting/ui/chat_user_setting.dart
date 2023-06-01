import 'package:badges/badges.dart';
import 'package:chat_glopr/screen/chat_user_setting/ui/user_setting_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:badges/src/badge.dart' as badge;

import '../../../@share/values/styles.dart';
import 'clipper_bg_user.dart';

class ChatUserSetting extends StatelessWidget {
  const ChatUserSetting(
      {super.key,
      required this.name,
      required this.avatar,
      required this.isOnline});
  final String name;
  final String avatar;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    EdgeInsets paddingDevice = MediaQuery.of(context).viewPadding;
    return Scaffold(
        body: Column(
      children: [
        ClipPath(
          clipper: RoundedClipper(),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg_chat_user.webp'),
                    fit: BoxFit.fill)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: paddingDevice.top + 20, left: 30),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
                Center(
                  child: badge.Badge(
                    animationDuration: const Duration(milliseconds: 0),
                    showBadge: isOnline,
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
                            image:
                                DecorationImage(image: NetworkImage(avatar))),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    name,
                    style: titleStyle.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Expanded(child: UserSettingOption())
      ],
    ));
  }
}
