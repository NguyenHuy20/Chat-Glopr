import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../values/colors.dart';
import '../values/styles.dart';

TouchableOpacity btnPrimaryDefaut(
        {required String content,
        Color? btnColor,
        Color? contentColor,
        void Function()? onTap,
        Color? borderColor}) =>
    TouchableOpacity(
      onTap: onTap,
      child: Container(
        height: 52,
        width: double.infinity,
        decoration: BoxDecoration(
            color: btnColor ?? Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor ?? Colors.transparent)),
        child: Center(
            child: Text(content,
                style: appStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: contentColor ?? Colors.black))),
      ),
    );

TouchableOpacity btnPink(
        {required String content,
        Color? contentColor,
        void Function()? onTap,
        Color? borderColor,
        IconData? icon}) =>
    TouchableOpacity(
      onTap: onTap,
      child: Container(
          height: 52,
          width: double.infinity,
          decoration: BoxDecoration(
              color: const Color(0xFF9381FF),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: borderColor ?? Colors.transparent)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(content,
                  style: appStyle.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: contentColor ?? Colors.black)),
              icon != null
                  ? Icon(
                      icon,
                      color: Colors.white,
                    )
                  : const SizedBox()
            ],
          )),
    );
TouchableOpacity btnPrimaryHover({
  required String content,
  Color? btnColor,
  void Function()? onTap,
  bool isLockBtn = false,
}) =>
    TouchableOpacity(
      onTap: isLockBtn ? null : onTap,
      child: Container(
        height: 52,
        width: double.infinity,
        decoration: BoxDecoration(
            color: isLockBtn ? gray.shade300 : btnColor ?? bluePrimary.shade500,
            borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Text(
          content,
          style: bodyParagraph2.apply(color: Colors.white),
        )),
      ),
    );
TouchableOpacity btnPrimaryPressed(
        {required String content, Color? btnColor, void Function()? onTap}) =>
    TouchableOpacity(
      onTap: onTap,
      child: Container(
        height: 52,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: bluePrimary.shade700),
            color: bluePrimary.shade500,
            borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Text(
          content,
          style: bodyParagraph2.apply(color: Colors.white),
        )),
      ),
    );
TouchableOpacity btnPrimaryDisabled(
        {required String content, Color? btnColor, void Function()? onTap}) =>
    TouchableOpacity(
      onTap: onTap,
      child: Container(
        height: 52,
        width: double.infinity,
        decoration: BoxDecoration(
            color: gray.shade300, borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Text(
          content,
          style: bodyParagraph2.apply(color: gray.shade700),
        )),
      ),
    );

TouchableOpacity btnSecondaryDefault(
        {required String content, Color? btnColor, void Function()? onTap}) =>
    TouchableOpacity(
      onTap: onTap,
      child: Container(
        height: 52,
        width: double.infinity,
        decoration: BoxDecoration(
            color: bluePrimary.shade50, borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Text(
          content,
          style: bodyParagraph2.apply(color: bluePrimary.shade700),
        )),
      ),
    );
TouchableOpacity btnSecondaryHover(
        {required String content, Color? btnColor, void Function()? onTap}) =>
    TouchableOpacity(
      onTap: onTap,
      child: Container(
        height: 52,
        width: double.infinity,
        decoration: BoxDecoration(
            color: bluePrimary.shade200,
            borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Text(
          content,
          style: bodyParagraph2.apply(color: bluePrimary.shade700),
        )),
      ),
    );
TouchableOpacity btnSecondaryPressed(
        {required String content, Color? btnColor, void Function()? onTap}) =>
    TouchableOpacity(
      onTap: onTap,
      child: Container(
          height: 52,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: bluePrimary.shade700),
              color: bluePrimary.shade200,
              borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text(content,
                style: bodyParagraph2.apply(color: bluePrimary.shade700)),
          )),
    );
TouchableOpacity btnLineDefault(
        {required String content, Color? btnColor, void Function()? onTap}) =>
    TouchableOpacity(
      onTap: onTap,
      child: Container(
        height: 52,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: gray.shade600),
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Text(
          content,
          style: bodyParagraph2.apply(color: bluePrimary.shade700),
        )),
      ),
    );
TouchableOpacity btnLineHover(
        {required String content, Color? btnColor, void Function()? onTap}) =>
    TouchableOpacity(
      onTap: onTap,
      child: Container(
        height: 52,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: gray.shade600),
            color: const Color(0xFFFAFBFB),
            borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Text(
          content,
          style: bodyParagraph2.apply(color: bluePrimary.shade700),
        )),
      ),
    );
TouchableOpacity btnLinePressed(
        {required String content, Color? btnColor, void Function()? onTap}) =>
    TouchableOpacity(
      onTap: onTap,
      child: Container(
        height: 52,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: bluePrimary.shade700),
            color: const Color(0xFFF5F6F7),
            borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Text(
          content,
          style: bodyParagraph2.apply(color: bluePrimary.shade700),
        )),
      ),
    );
