import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_glopr/@share/applicationmodel/profile/profile_bloc.dart';
import 'package:chat_glopr/@share/utils/utils.dart';
import 'package:chat_glopr/@share/values/colors.dart';
import 'package:chat_glopr/@share/values/shadow.dart';
import 'package:chat_glopr/@share/values/styles.dart';
import 'package:chat_glopr/screen/channel_detail/view_model/channel_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import '../../../../../@core/network_model/result_get_conversation_group_model.dart';
import '../../../../../@share/widgets/text_field_custom.dart';
import '../../../@core/network/environment_config.dart';
import '../../../@core/network_model/result_get_list_message_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../@share/utils/socket_client_util.dart';

class ChannelDetailScreen extends StatefulWidget {
  const ChannelDetailScreen({super.key, required this.data});
  final ConversationGroupData data;
  @override
  State<ChannelDetailScreen> createState() => _ChannelDetailScreenState();
}

class _ChannelDetailScreenState extends State<ChannelDetailScreen> {
  bool showKeyboard = false;
  FocusNode chatFocus = FocusNode();
  late ChannelDetailBloc channelDetailBloc;
  late StreamController<List<MessageData>> messageController;
  late ProfileBloc profileBloc;
  TextEditingController chatController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();

    channelDetailBloc = BlocProvider.of<ChannelDetailBloc>(context)
      ..add(GetListMessageEvent(converId: widget.data.id ?? ''));
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    messageController = StreamController<List<MessageData>>();
    connectSocket();
  }

  connectSocket() {
    IO.Socket socket = IO.io(
        EnvironmentConfig.HOST_URL,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    socket.connect();
    socket.onConnect((_) {
      socket.emit('join-conversation', widget.data.id);
    });
    socket.on('new-message', (data) {
      channelDetailBloc.add(ReciveMessageEvent(data: data));
    });
  }

  @override
  void dispose() {
    super.dispose();
    IO.Socket socket = IO.io(
        EnvironmentConfig.HOST_URL,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    socket.connect();
    socket.onConnect((_) {
      socket.emit('leave-conversation', widget.data.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets paddingDevice = MediaQuery.of(context).viewPadding;
    return BlocListener<ChannelDetailBloc, ChannelDetailState>(
        listener: (context, state) {
          if (state is GetListMessageSuccessState) {
            messageController.add(state.data);
            return;
          }
          if (state is ReciveMessageState) {
            messageController.add(state.data);
            return;
          }
        },
        child: Scaffold(
          body: Column(children: [
            Padding(
              padding: EdgeInsets.fromLTRB(30, paddingDevice.top + 15, 30, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios),
                    iconSize: 20,
                  ),
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
                    child: Text(
                      widget.data.name ?? '',
                      style: titleStyle.copyWith(fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  const Icon(
                    Icons.search,
                    size: 30,
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.grey.shade200, Colors.white],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(0.0, 0.1),
                      stops: const [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: StreamBuilder<List<MessageData>>(
                    stream: messageController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            padding: const EdgeInsets.all(0),
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              return chat(snapshot.data![index]);
                            });
                      }
                      if (snapshot.hasError) {
                        return Center(
                            child:
                                Image.asset('assets/images/bg_not_found.webp'));
                      }
                      return SizedBox(
                          width: double.infinity,
                          child: cupertinoLoading(color: pink));
                    }),
              ),
            ),
            Container(
              height: 70,
              padding: const EdgeInsets.only(left: 30, right: 30),
              decoration: BoxDecoration(
                  boxShadow: shadowTop,
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  showKeyboard
                      ? Row(
                          children: [
                            TouchableOpacity(
                              onTap: () {
                                setState(() {
                                  showKeyboard = !showKeyboard;
                                });
                              },
                              child: Image.asset(
                                'assets/icons/right_arrow.webp',
                                width: 50,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            TouchableOpacity(
                              onTap: () => channelDetailBloc.add(
                                  ShowDialogGroupSettingEvent(
                                      context: context)),
                              child: Image.asset(
                                'assets/icons/more_info_gr.webp',
                                width: 50,
                              ),
                            ),
                            Image.asset(
                              'assets/icons/mic.webp',
                              width: 50,
                            ),
                            Image.asset(
                              'assets/icons/photo.webp',
                              width: 50,
                            ),
                            Image.asset(
                              'assets/icons/react.webp',
                              width: 50,
                            ),
                          ],
                        ),
                  Expanded(
                      child: textFieldChatCustom(
                          controller: chatController,
                          onFieldSubmitted: (p0) {
                            channelDetailBloc.add(SendMessageEvent(
                                content: chatController.text,
                                desId: widget.data.id ?? ''));
                            setState(() {
                              showKeyboard = false;
                              chatController.text = '';
                            });
                          },
                          onChanged: (hhp0) {
                            IO.Socket socket = IO.io(
                                EnvironmentConfig.HOST_URL,
                                IO.OptionBuilder()
                                    .setTransports(
                                        ['websocket']) // for Flutter or Dart VM
                                    .disableAutoConnect() // disable auto-connection
                                    .build());

                            socket.connect();
                            Map<String, dynamic> dataTyping = {
                              'conversationId': widget.data.id ?? '',
                              'userId': profileBloc.profileDataModel?.id ?? '',
                              'isTyping': true,
                            };
                            Map<String, dynamic> dataNotTyping = {
                              'conversationId': widget.data.id ?? '',
                              'userId': profileBloc.profileDataModel?.id ?? '',
                              'isTyping': false,
                            };
                            socket.onConnect((_) {
                              hhp0 == ''
                                  ? socket.emit('typing', dataNotTyping)
                                  : socket.emit('typing', dataTyping);
                            });
                            setState(() {
                              showKeyboard = true;
                            });
                          },
                          hintText: 'Aa',
                          focusNode: chatFocus)),
                  showKeyboard
                      ? TouchableOpacity(
                          onTap: () {
                            channelDetailBloc.add(SendMessageEvent(
                                content: chatController.text,
                                desId: widget.data.id ?? ''));
                            setState(() {
                              showKeyboard = false;
                              chatController.text = '';
                            });
                          },
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              Image.asset(
                                'assets/icons/send_message.webp',
                                width: 50,
                              )
                            ],
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            )
          ]),
        ));
  }

  Widget chat(MessageData data) {
    if (data.type == 'NOTIFY') {
      if (data.manipulatedUsers!.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Text(
            "${data.manipulatedUsers?.first.fullName} ${data.content?.toLowerCase()}",
            textAlign: TextAlign.center,
            style: appStyle.copyWith(fontSize: 13),
          ),
        );
      }
      return Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Text(
          "${data.user?.fullName} ${data.content?.toLowerCase()}",
          textAlign: TextAlign.center,
          style: appStyle.copyWith(fontSize: 13),
        ),
      );
    }
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 15.0, bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 53,
              height: 53,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(65.0),
                child: CachedNetworkImage(
                  imageUrl: data.user?.avatar ?? '',
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      const SizedBox(),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/images/logo.webp'),
                ),
              )),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      profileBloc.profileDataModel?.id != data.user?.id
                          ? data.user?.fullName ?? ''
                          : "You",
                      style: appStyle.copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(data.createdAt ?? '')
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  data.content ?? '',
                  style: appStyle,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
