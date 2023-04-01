import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../values/colors.dart';
import '../values/styles.dart';

class FieldVerifyOTP extends StatelessWidget {
  const FieldVerifyOTP(
      {Key? key,
      required this.errorController,
      this.onCompleted,
      this.textEditingController,
      this.onChanged})
      : super(key: key);
  final StreamController<ErrorAnimationType> errorController;
  final Function? onCompleted;
  final TextEditingController? textEditingController;
  final Function? onChanged;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      hintCharacter: '-',
      autoFocus: true,
      appContext: context,
      length: 4,
      obscuringCharacter: '*',
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(8),
          fieldHeight: 55,
          fieldWidth: 50,
          borderWidth: 1,
          activeFillColor: Colors.white,
          activeColor: gray.shade50,
          inactiveColor: gray.shade50,
          selectedColor: bluePrimary,
          selectedFillColor: Colors.white),
      cursorColor: Colors.white,
      cursorWidth: 0,
      animationDuration: const Duration(milliseconds: 300),
      textStyle: appStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w400),
      backgroundColor: Colors.white,
      errorAnimationController: errorController,
      controller: textEditingController,
      keyboardType: TextInputType.number,
      onCompleted: (code) async {
        if (onCompleted != null) {
          onCompleted!(code);
        }
      },
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      beforeTextPaste: (text) {
        return true;
      },
    );
  }
}
