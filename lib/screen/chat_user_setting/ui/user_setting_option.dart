import 'package:chat_glopr/@share/values/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

import '../../../@share/values/colors.dart';

class UserSettingOption extends StatelessWidget {
  const UserSettingOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Wrap(
        runSpacing: 30,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Change Nickname',
                style: appStyle.copyWith(fontSize: 16),
              ),
              Image.asset(
                'assets/icons/change_nickname.webp',
                width: 20,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notification',
                style: appStyle.copyWith(fontSize: 16),
              ),
              SizedBox(
                width: 20,
                height: 20,
                child: CupertinoSwitch(
                    activeColor: pink,
                    trackColor: pink,
                    value: true,
                    onChanged: (value) async {
                      // log(locale.toString(), name: toString());
                    }),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Change Background',
                style: appStyle.copyWith(fontSize: 16),
              ),
              Image.asset(
                'assets/icons/change_bg.webp',
                width: 20,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Change Background Chat',
                style: appStyle.copyWith(fontSize: 16),
              ),
              Image.asset(
                'assets/icons/change_bg.webp',
                width: 20,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'File & Image',
                style: appStyle.copyWith(fontSize: 16),
              ),
              Image.asset(
                'assets/icons/file_image.webp',
                width: 20,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Find Conversation',
                style: appStyle.copyWith(fontSize: 16),
              ),
              Image.asset(
                'assets/icons/find_conversation.webp',
                width: 20,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Block',
                style: appStyle.copyWith(fontSize: 16),
              ),
              Image.asset(
                'assets/icons/block.webp',
                width: 20,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Delete Friend',
                style: appStyle.copyWith(fontSize: 16),
              ),
              Image.asset(
                'assets/icons/delete_friend.webp',
                width: 20,
              )
            ],
          ),
        ],
      ),
    );
  }
}
