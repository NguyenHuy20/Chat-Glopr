import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';

import '../../../@share/values/colors.dart';

class PinImageFileOption extends StatefulWidget {
  const PinImageFileOption({super.key});

  @override
  State<PinImageFileOption> createState() => _PinImageFileOptionState();
}

class _PinImageFileOptionState extends State<PinImageFileOption> {
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
          'Pin, image and file',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        children: <Widget>[],
      ),
    );
  }
}
