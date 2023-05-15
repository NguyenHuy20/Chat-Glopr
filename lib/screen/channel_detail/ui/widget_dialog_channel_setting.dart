import 'package:chat_glopr/@share/values/styles.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../@core/network_model/result_get_conversation_group_model.dart';
import '../../../@share/values/colors.dart';

class DialogChannelSetting extends StatefulWidget {
  const DialogChannelSetting({super.key, required this.data});
  final ConversationGroupData data;
  @override
  State<DialogChannelSetting> createState() => _DialogChannelSettingState();
}

class _DialogChannelSettingState extends State<DialogChannelSetting> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                    style: titlePageStyle.copyWith(fontWeight: FontWeight.bold),
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
        cardSetting(
          titlecard: 'Pin, image and file',
        ),
        cardSetting(titlecard: 'Member'),
        cardSetting(titlecard: 'Role'),
        cardSetting(titlecard: 'Channel Setting'),
        cardSetting(titlecard: 'Search Message'),
      ],
    );
  }

  cardSetting({required String titlecard}) => Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: ExpansionTileCard(
          shadowColor: Colors.transparent,
          baseColor: Colors.transparent,
          expandedColor: Colors.transparent,
          expandedTextColor: pink,
          title: Text(
            titlecard,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          children: <Widget>[],
        ),
      );
}
