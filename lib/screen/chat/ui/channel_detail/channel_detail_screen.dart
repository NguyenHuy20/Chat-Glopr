import 'dart:async';

import 'package:chat_glopr/@share/values/shadow.dart';
import 'package:chat_glopr/@share/values/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../../@core/network_model/result_get_conversation_model.dart';
import '../../../../@share/widgets/text_field_custom.dart';

class ChannelDetailScreen extends StatefulWidget {
  const ChannelDetailScreen({super.key, required this.data});
  final ConversationData data;
  @override
  State<ChannelDetailScreen> createState() => _ChannelDetailScreenState();
}

class _ChannelDetailScreenState extends State<ChannelDetailScreen> {
  bool showKeyboard = false;
  FocusNode chatFocus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets paddingDevice = MediaQuery.of(context).viewPadding;
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: EdgeInsets.fromLTRB(30, paddingDevice.top + 15, 30, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
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
                  Text(
                    widget.data.name ?? '',
                    style: titleStyle.copyWith(fontSize: 20),
                  )
                ],
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
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.grey.shade200, Colors.white],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.0, 0.1),
                  stops: const [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
        ),
        Container(
          height: 70,
          padding: const EdgeInsets.only(left: 30, right: 30),
          decoration: BoxDecoration(
              boxShadow: shadowTop,
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              showKeyboard
                  ? Row(
                      children: [
                        Image.asset(
                          'assets/icons/right_arrow.webp',
                          width: 50,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Image.asset(
                          'assets/icons/more_info_gr.webp',
                          width: 50,
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
                      onFieldSubmitted: (p0) {
                        setState(() {
                          showKeyboard = false;
                        });
                      },
                      onChanged: (p0) {
                        setState(() {
                          showKeyboard = true;
                        });
                      },
                      hintText: 'Aa',
                      focusNode: chatFocus)),
              showKeyboard
                  ? Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Image.asset(
                          'assets/icons/send_message.webp',
                          width: 50,
                        )
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        )
      ]),
    );
  }
}
