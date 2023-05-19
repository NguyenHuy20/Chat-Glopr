import 'package:another_flushbar/flushbar.dart';
import 'package:chat_glopr/@core/network_model/result_member_conversation_model.dart';
import 'package:chat_glopr/@share/values/styles.dart';
import 'package:chat_glopr/screen/channel_detail/view_model/channel_detail_bloc.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../@core/network_model/result_get_conversation_group_model.dart';
import '../../../@share/values/colors.dart';
import 'channel_setting/channel_setting_option.dart';
import 'member_option/member_option.dart';
import 'pin_image_file_option.dart';
import 'role_option.dart';
import 'search_message.dart';

class DialogChannelSetting extends StatefulWidget {
  const DialogChannelSetting({super.key, required this.data});
  final ConversationGroupData data;
  @override
  State<DialogChannelSetting> createState() => _DialogChannelSettingState();
}

class _DialogChannelSettingState extends State<DialogChannelSetting> {
  late ChannelDetailBloc channelDetailBloc;
  late BehaviorSubject<List<MemberConversationData>> lstMemberController;
  @override
  void initState() {
    super.initState();
    channelDetailBloc = BlocProvider.of<ChannelDetailBloc>(context);
    lstMemberController = BehaviorSubject<List<MemberConversationData>>();
    channelDetailBloc
        .add(GetMemberConversationEvent(converId: widget.data.id ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChannelDetailBloc, ChannelDetailState>(
        listener: (context, state) {
          if (state is GetMemberSuccessState) {
            lstMemberController.add(state.data);
            return;
          }
        },
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        weight: 50,
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 65,
                      height: 65,
                      margin: const EdgeInsets.only(left: 20),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('assets/images/logo.webp'))),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.data.name ?? '',
                            style: titlePageStyle.copyWith(
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            'Welcome to ${widget.data.name}',
                            style: appStyle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const PinImageFileOption(),
                MemberOption(
                  channelDetailBloc: channelDetailBloc,
                  lstMemberController: lstMemberController,
                  data: widget.data,
                ),
                const RoleOption(),
                ChannelSettingOption(
                  data: widget.data,
                  channelDetailBloc: channelDetailBloc,
                ),
                const SearchMessage(),
              ],
            ),
          ],
        ));
  }
}
