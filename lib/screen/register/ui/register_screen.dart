import 'package:chat_glopr/@core/local_model/register_model.dart';
import 'package:chat_glopr/@share/values/styles.dart';
import 'package:chat_glopr/@share/widgets/button_custom.dart';
import 'package:chat_glopr/@share/widgets/flushbar_custom.dart';
import 'package:chat_glopr/screen/register/view_model/register_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../@share/utils/utils.dart';
import '../../login/ui/login_page.dart';
import 'widget_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullNameController = TextEditingController(text: '');
  TextEditingController userNameController = TextEditingController(text: '');
  TextEditingController identityController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController rePasswordController = TextEditingController(text: '');
  TextEditingController otpCodeController = TextEditingController(text: '');
  TextEditingController genderController = TextEditingController(text: '');

  late RegisterBloc registerBloc;
  @override
  void initState() {
    super.initState();
    registerBloc = BlocProvider.of<RegisterBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_register.webp'),
                  fit: BoxFit.fill)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 52, 30, 0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Register',
                style: titleStyle,
              ),
              const SizedBox(
                height: 28,
              ),
              WidgetFormField(
                fullNameController: fullNameController,
                userNameController: userNameController,
                identityController: identityController,
                passwordController: passwordController,
                rePasswordController: rePasswordController,
                genderController: genderController,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(75, 20, 75, 10),
                child: btnPink(
                    onTap: () {
                      if (passwordController.text !=
                          rePasswordController.text) {
                        showFlushBar(context,
                            msg: 'Password and Re-Password not right',
                            status: FLUSHBAR_ERROR);
                        return;
                      }
                      RegisterModel registerModel = RegisterModel(
                        fullName: fullNameController.text,
                        userName: userNameController.text,
                        identity: identityController.text,
                        password: passwordController.text,
                        otpCode: '',
                        gender: genderController.text,
                      );
                      registerBloc.add(
                          SendOTPEvent(model: registerModel, context: context));
                    },
                    content: 'Create Account',
                    contentColor: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              TouchableOpacity(
                onTap: () => goToScreen(context, const LoginPage()),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: "Aleady have account?",
                            style:
                                appStyle.copyWith(fontWeight: FontWeight.w300)),
                        TextSpan(
                            text: " Login now",
                            style: appStyle.copyWith(
                                fontWeight: FontWeight.w300,
                                color: const Color(0xFF3300FF),
                                decoration: TextDecoration.underline)),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}
