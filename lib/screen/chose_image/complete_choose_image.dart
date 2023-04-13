import 'package:badges/badges.dart';
import 'package:chat_glopr/@share/values/shadow.dart';
import 'package:chat_glopr/@share/values/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:badges/src/badge.dart' as badge;

class CompleteChooseImage extends StatefulWidget {
  const CompleteChooseImage({super.key});

  @override
  State<CompleteChooseImage> createState() => _CompleteChooseImageState();
}

class _CompleteChooseImageState extends State<CompleteChooseImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 48),
        height: 150,
        decoration: BoxDecoration(boxShadow: shadow3, color: Colors.white),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              badge.Badge(
                animationDuration: const Duration(milliseconds: 0),
                badgeColor: const Color(0xff29B113),
                position: BadgePosition.bottomEnd(bottom: 2, end: 4),
                padding: const EdgeInsets.fromLTRB(5, 6, 5, 5),
                toAnimate: true,
                animationType: BadgeAnimationType.slide,
                child: Container(
                  width: 53,
                  height: 53,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey),
                  child: const Icon(Icons.image),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Jane Rose',
                style: appStyle.copyWith(
                    fontWeight: FontWeight.w700, fontSize: 20),
              )
            ],
          ),
          Icon(Icons.check)
        ]),
      ),
    );
  }
}
