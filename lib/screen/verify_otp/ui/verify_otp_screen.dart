import 'package:chat_glopr/@core/local_model/request_otp_model.dart';
import 'package:chat_glopr/@share/values/styles.dart';
import 'package:chat_glopr/screen/verify_otp/view_model/verify_otp_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../@core/local_model/register_model.dart';
import '../../../@share/values/colors.dart';
import '../../../@share/widgets/flushbar_custom.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({super.key, required this.model});
  final RegisterModel model;
  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  late VerifyOTPBloc verifyOTPBloc;
  @override
  void initState() {
    super.initState();
    verifyOTPBloc = BlocProvider.of<VerifyOTPBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerifyOTPBloc, VerifyOTPState>(
      listener: (context, state) {
        if (state is ResendCodeSuccessState) {
          setState(() {
            widget.model.otpCode = state.otp;
          });
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_verify.webp'),
                  fit: BoxFit.fill)),
          child: Padding(
            padding: const EdgeInsets.only(top: 70, left: 38, right: 38),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                const SizedBox(
                  height: 70,
                ),
                Text(
                  'Verification',
                  style: titleStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Enter your code what was send to your phone',
                  style: heading1,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      disabledColor: Colors.grey,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 44,
                      fieldWidth: 44,
                      borderWidth: 1.5,
                      activeColor: pink,
                      inactiveColor: Colors.grey,
                      selectedColor: pink,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    textStyle: appStyle.copyWith(
                        fontWeight: FontWeight.w700, fontSize: 15),
                    backgroundColor: Colors.transparent,
                    keyboardType: TextInputType.number,
                    onCompleted: (code) async {
                      if (code != widget.model.otpCode) {
                        showFlushBar(context,
                            msg: 'OTP không đúng', status: FLUSHBAR_ERROR);
                        return;
                      }
                      verifyOTPBloc.add(RegisterAccountEvent(
                          model: widget.model, context: context));
                    },
                    onChanged: (String value) {},
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TouchableOpacity(
                  onTap: () => verifyOTPBloc.add(ResendOTPEvent(
                      context: context,
                      otp: widget.model.otpCode,
                      model: RequestOTPModel(
                          context: 'CREATE_USERS',
                          identity: widget.model.identity,
                          method: 'EMAIL',
                          format: 'NUMBER_ONLY'))),
                  child: Center(
                    child: Text(
                      'Resend',
                      style: appStyle.copyWith(
                          color: pink, decoration: TextDecoration.underline),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
