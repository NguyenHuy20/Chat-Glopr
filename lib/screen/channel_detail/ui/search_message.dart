import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../@share/values/colors.dart';

class SearchMessage extends StatefulWidget {
  const SearchMessage({super.key});

  @override
  State<SearchMessage> createState() => _SearchMessageState();
}

class _SearchMessageState extends State<SearchMessage> {
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
          'Search Message',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        children: <Widget>[],
      ),
    );
  }
}
