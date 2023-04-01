import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget hashLineHorizonal() => Row(
      children: List.generate(
          550 ~/ 10,
          (index) => Expanded(
                child: Container(
                  color: index % 2 == 0 ? Colors.transparent : Colors.grey,
                  height: 0.5,
                ),
              )),
    );
