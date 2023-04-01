// ignore_for_file: constant_identifier_names
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import '../values/colors.dart';
import '../values/styles.dart';

const String FLUSHBAR_SUCCESS = "SUCCESS";
const String FLUSHBAR_ERROR = "ERROR";
const String FLUSHBAR_INFO = "INFO";
const String FLUSHBAR_WARNING = "WARNING";

// void showFlushBar(BuildContext context,
//         {String title = '', String msg = '', Color color = Colors.black}) =>
//     Flushbar(
//       flushbarStyle: FlushbarStyle.GROUNDED,
//       title: title,
//       backgroundColor: color,
//       message: msg,
//       duration: const Duration(seconds: 2),
//     )..show(context);

void showFlushBar(BuildContext context,
        {String title = "",
        String msg = "",
        String status = FLUSHBAR_SUCCESS}) =>
    Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        reverseAnimationCurve: Curves.decelerate,
        backgroundColor: Colors.white,
        margin: const EdgeInsets.fromLTRB(14, 0, 14, 0),
        borderRadius: BorderRadius.circular(10),
        borderColor: flushBarEx[status]["color"],
        isDismissible: false,
        duration: const Duration(milliseconds: 2000),
        icon: Container(
            width: 22,
            height: 22,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: flushBarEx[status]["color"]),
            child: flushBarEx[status]["icon"]),
        progressIndicatorBackgroundColor: black,
        titleText: title.trim() != ""
            ? Text(title,
                style: appStyle.copyWith(
                    color: flushBarEx[status]["color"],
                    fontWeight: FontWeight.w400))
            : null,
        messageText: Text(msg, style: appStyle))
      ..show(context);

Map flushBarEx = {
  "SUCCESS": {
    "color": greenSuccess,
    "icon": const Icon(
      Icons.check,
      color: Colors.white,
      size: 12,
    ),
  },
  "ERROR": {
    "color": redDanger,
    "icon": const Icon(
      Icons.close,
      color: Colors.white,
      size: 12,
    ),
  },
  "INFO": {
    "color": bluePrimary,
    "icon": const Icon(
      Icons.warning,
      color: Colors.white,
      size: 12,
    ),
  },
  "WARNING": {
    "color": yellowSecondary,
    "icon": const Icon(
      Icons.warning,
      color: Colors.white,
      size: 12,
    ),
  },
};
