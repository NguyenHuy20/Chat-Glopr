import 'dart:async';

import 'package:badges/badges.dart';
import 'package:chat_glopr/@share/applicationmodel/profile/profile_bloc.dart';
import 'package:chat_glopr/@share/values/styles.dart';
import 'package:chat_glopr/screen/chat/view_model/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../../@core/network_model/result_get_conversation_model.dart';
import '../../../../@share/utils/utils.dart';
import '../../../../@share/widgets/widget_skeleton_loading.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with AutomaticKeepAliveClientMixin<ChatScreen> {
  late ChatBloc chatBloc;
  late StreamController<List<ConversationData>> conversationController;
  final ScrollController _scrollController = ScrollController();
  bool endPage = false;
  @override
  void initState() {
    chatBloc = BlocProvider.of<ChatBloc>(context);
    chatBloc.add(const GetConversationEvent(type: 1));
    conversationController = StreamController<List<ConversationData>>();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        chatBloc.add(const PagingConversationEvent(type: 2));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is GetConversationSuccessState) {
          setState(() => endPage = true);
          conversationController.add(state.lstConservation);
        }
        if (state is PagingConversationSuccessState) {
          conversationController.add(state.data);
          return;
        }
        if (state is LostPagingState) {
          setState(() => endPage = true);
          return;
        }
        if (state is GetConversationFailState) {
          conversationController.addError('');
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
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: StreamBuilder<List<ConversationData>>(
                    stream: conversationController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data!.isNotEmpty
                            ? loadMore(
                                _scrollController,
                                ListView(
                                    padding: const EdgeInsets.only(
                                        top: 15, bottom: 10),
                                    physics: const ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    children: snapshot.data!.map((element) {
                                      return chatBox(element);
                                    }).toList()),
                                endPage)
                            : const Center(
                                child: Text('No Data'),
                              );
                      }
                      if (snapshot.hasError) {
                        return Center(
                            child:
                                Image.asset('assets/images/bg_not_found.webp'));
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

  Widget chatBox(ConversationData data) => Slidable(
        key: const ValueKey(0),
        enabled: true,
        closeOnScroll: true,
        endActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) async {
                chatBloc.add(ShowDialogDeleteConversation(context: context));
              },
              icon: Icons.delete,
              foregroundColor: Colors.red,
              backgroundColor: const Color(0xFFF8F7FF),
            )
          ],
        ),
        child: TouchableOpacity(
          onTap: () {
            // goToScreen(
            //     context,
            //     ChannelDetailScreen(
            //       data: data,
            //     ));
          },
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
                        data.lastMessage?.content ?? '',
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