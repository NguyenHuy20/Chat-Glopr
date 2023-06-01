import 'dart:async';

import 'package:chat_glopr/@share/applicationmodel/profile/profile_bloc.dart';
import 'package:chat_glopr/@share/values/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../../../../@core/network_model/result_get_conversation_group_model.dart';
import '../../../../../../@share/utils/utils.dart';
import '../../../../../../@share/widgets/widget_skeleton_loading.dart';
import '../../../channel_detail/ui/channel_detail_page.dart';
import '../../view_model/chat_bloc.dart';

class ChannelScreen extends StatefulWidget {
  const ChannelScreen({super.key});

  @override
  State<ChannelScreen> createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen>
    with AutomaticKeepAliveClientMixin<ChannelScreen> {
  late ChatBloc chatBloc;
  late ProfileBloc profileBloc;
  late StreamController<List<ConversationGroupData>> conversationController;
  final ScrollController _scrollController = ScrollController();
  bool endPage = false;

  @override
  void initState() {
    chatBloc = BlocProvider.of<ChatBloc>(context);
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    chatBloc.add(const GetConversationGroupEvent(type: 2));
    conversationController = StreamController<List<ConversationGroupData>>();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        chatBloc.add(const PagingConversationGroupEvent(type: 2));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is GetConversationGroupSuccessState) {
          setState(() => endPage = true);
          conversationController.add(state.lstConservation);
        }
        if (state is PagingConversationGroupSuccessState) {
          conversationController.add(state.data);
          return;
        }
        if (state is LostPagingGroupState) {
          setState(() => endPage = true);
          return;
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.grey.shade200, Colors.white],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 0.1),
                stops: const [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Channel',
                    style: appStyle.copyWith(fontSize: 16),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_outlined),
                    onPressed: () {
                      chatBloc.add(ShowDialogJoinChannelEvent(
                          context: context,
                          userId: profileBloc.profileDataModel?.id ?? ''));
                    },
                  )
                ],
              ),
              Expanded(
                child: StreamBuilder<List<ConversationGroupData>>(
                    stream: conversationController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data!.isNotEmpty
                            ? RefreshIndicator(
                                onRefresh: () async {
                                  chatBloc.add(
                                      const GetConversationGroupEvent(type: 2));
                                  return;
                                },
                                child: loadMore(
                                    _scrollController,
                                    ListView(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 10),
                                        physics: const ClampingScrollPhysics(),
                                        shrinkWrap: true,
                                        children: snapshot.data!.map((element) {
                                          return chatGroupBox(element);
                                        }).toList()),
                                    endPage),
                              )
                            : const Center(
                                child: Text('Chưa có cuộc trò chuyện'),
                              );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: cupertinoLoading(color: Colors.grey),
                        );
                      }
                      return skeletonLoading(context);
                    }),
              )
            ]),
          ),
        ),
      ),
    );
  }

  Widget chatGroupBox(ConversationGroupData data) => GestureDetector(
        onTap: () {
          goToScreen(
              context,
              ChannelDetailPage(
                data: data,
              ));
        },
        child: Slidable(
          key: const ValueKey(0),
          enabled: true,
          closeOnScroll: true,
          endActionPane: ActionPane(
            extentRatio: 0.25,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) async {
                  chatBloc.add(ShowDialogDeleteConversation(
                      context: context, converId: data.id ?? ''));
                },
                icon: Icons.delete,
                foregroundColor: Colors.red,
                backgroundColor: const Color(0xFFF8F7FF),
              )
            ],
          ),
          child: Container(
            margin: const EdgeInsets.fromLTRB(5, 15, 5, 15),
            width: double.infinity,
            child: Row(
              children: [
                Container(
                  width: 53,
                  height: 53,
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
                        data.name ?? '',
                        style: titleStyle.copyWith(fontSize: 17),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${data.lastMessage?.user?.fullName ?? ''}: ${data.lastMessage?.content ?? ''}',
                        style: appStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      data.lastMessage?.createdAt ?? '',
                      style: appStyle.copyWith(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    data.numberUnread != 0
                        ? Container(
                            width: 16,
                            height: 16,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.red),
                            child: Text(
                              data.numberUnread.toString(),
                              textAlign: TextAlign.center,
                              style: appStyle.copyWith(
                                  color: Colors.white, fontSize: 13),
                            ),
                          )
                        : const SizedBox(
                            width: 16,
                            height: 16,
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  @override
  bool get wantKeepAlive => true;
}
