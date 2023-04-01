import 'package:flutter/material.dart';

import '../values/colors.dart';
import '../values/styles.dart';

Widget orderScreenError(String msg) => Center(
    child: Container(
        width: 300,
        height: 200,
        padding: const EdgeInsets.only(top: 30, bottom: 8, left: 15, right: 15),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/orderBg.webp',
                ),
                fit: BoxFit.fill)),
        child: Text(
          msg,
          style: appStyle.copyWith(
              fontSize: 20, color: redDanger, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        )));
