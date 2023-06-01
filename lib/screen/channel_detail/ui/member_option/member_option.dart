import 'package:chat_glopr/@share/utils/utils.dart';
import 'package:chat_glopr/@share/values/styles.dart';
import 'package:chat_glopr/screen/channel_detail/view_model/channel_detail_bloc.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:rxdart/rxdart.dart';

import '../../../../@core/network_model/result_get_conversation_group_model.dart';
import '../../../../@core/network_model/result_member_conversation_model.dart';
import '../../../../@share/values/colors.dart';

class MemberOption extends StatefulWidget {
  const MemberOption(
      {super.key,
      required this.lstMemberController,
      required this.channelDetailBloc,
      required this.data});
  final BehaviorSubject<List<MemberConversationData>> lstMemberController;
  final ChannelDetailBloc channelDetailBloc;
  final ConversationGroupData data;

  @override
  State<MemberOption> createState() => _MemberOptionState();
}

class _MemberOptionState extends State<MemberOption> {
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
          'Member',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 5, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add member',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      widget.channelDetailBloc.add(ShowDialogAddMemberEvent(
                          conversationId: widget.data.id ?? '',
                          context: context));
                    },
                    icon: const Icon(Icons.add))
              ],
            ),
          ),
          LimitedBox(
              maxHeight: 220,
              child: StreamBuilder<List<MemberConversationData>>(
                stream: widget.lstMemberController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        padding: const EdgeInsets.all(0),
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          return memberCard(snapshot.data![index]);
                        });
                  }
                  return cupertinoLoading(color: pink);
                },
              ))
        ],
      ),
    );
  }

  Widget memberCard(MemberConversationData data) => Container(
      padding: const EdgeInsets.only(left: 16, right: 5, bottom: 15),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(data.avatar ?? ''),
                onError: (_, e) {
                  print("get img err");
                },
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.fullName ?? '',
                  style: appStyle.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  data.nickName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
        ],
      ));
}
