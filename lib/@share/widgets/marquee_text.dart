import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';

Widget marqueeText(String? content, {TextStyle? style}) => Marquee(
    child: Text(content ?? '', style: style),
    direction: Axis.horizontal,
    textDirection: TextDirection.ltr,
    animationDuration: const Duration(milliseconds: 2500),
    backDuration: const Duration(milliseconds: 2500),
    pauseDuration: const Duration(milliseconds: 600),
    directionMarguee: DirectionMarguee.TwoDirection,
    forwardAnimation: Curves.easeInOut);
