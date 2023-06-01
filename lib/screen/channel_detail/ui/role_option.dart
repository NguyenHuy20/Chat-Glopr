import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../@share/values/colors.dart';

class RoleOption extends StatefulWidget {
  const RoleOption({super.key});

  @override
  State<RoleOption> createState() => _RoleOptionState();
}

class _RoleOptionState extends State<RoleOption> {
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
          'Role',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        children: <Widget>[],
      ),
    );
  }
}
