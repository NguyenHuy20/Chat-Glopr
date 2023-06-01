import 'package:chat_glopr/screen/channel_detail/view_model/channel_detail_bloc.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../../@core/network_model/result_get_conversation_group_model.dart';
import '../../../../@share/values/colors.dart';

class ChannelSettingOption extends StatefulWidget {
  const ChannelSettingOption(
      {super.key, required this.channelDetailBloc, required this.data});
  final ChannelDetailBloc channelDetailBloc;
  final ConversationGroupData data;

  @override
  State<ChannelSettingOption> createState() => _ChannelSettingOptionState();
}

class _ChannelSettingOptionState extends State<ChannelSettingOption> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: ExpansionTileCard(
        shadowColor: Colors.transparent,
        baseColor: Colors.transparent,
        expandedColor: Colors.transparent,
        expandedTextColor: pink,
        title: const Text(
          'Channel Setting',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        children: <Widget>[
          channelSettingOption(
              optionName: 'Notification',
              icon: const Icon(Icons.notifications)),
          channelSettingOption(
              optionName: 'Change group avatar',
              icon: const Icon(Icons.image_outlined)),
          channelSettingOption(
              optionName: 'Change color text', icon: const Icon(Icons.circle)),
          channelSettingOption(
              optionName: 'Change background', icon: const Icon(Icons.circle)),
          channelSettingOption(
            optionName: 'Leave the channel',
            icon: const Icon(
              Icons.block,
              color: Colors.red,
            ),
            coloroption: Colors.red,
            onTap: () {
              widget.channelDetailBloc.add(LeaveChannelEvent(
                  conversationId: widget.data.id ?? '', context: context));
            },
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 35,
              right: 35,
            ),
            child: Divider(color: Colors.black),
          )
        ],
      ),
    );
  }

  Widget channelSettingOption(
          {required String optionName,
          required Widget icon,
          Color? coloroption,
          Function()? onTap}) =>
      TouchableOpacity(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.only(
            left: 20,
            right: 18,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                optionName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: coloroption ?? Colors.black),
              ),
              icon
            ],
          ),
        ),
      );
}
