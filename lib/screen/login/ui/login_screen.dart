import 'package:chat_glopr/@share/values/styles.dart';
import 'package:chat_glopr/@share/widgets/button_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../@share/widgets/text_field_custom.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DecoratedBox(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg_login.webp'),
                fit: BoxFit.fill)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 200, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Login',
                style: appStyle.copyWith(
                    fontWeight: FontWeight.w700, fontSize: 36),
              ),
              const SizedBox(
                height: 40,
              ),
              textFormFieldCustom(hintText: 'Username'),
              const SizedBox(
                height: 15,
              ),
              textFormFieldCustom(hintText: 'Password'),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100, right: 100.0),
                child: btnPink(
                  content: 'Sign in',
                  contentColor: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 30),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: "Don't have an account?",
                          style:
                              appStyle.copyWith(fontWeight: FontWeight.w300)),
                      TextSpan(
                          text: " Register now",
                          style: appStyle.copyWith(
                              fontWeight: FontWeight.w300,
                              color: const Color(0xFF3300FF),
                              decoration: TextDecoration.underline)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/images/Google.webp',
                      width: 51,
                    ),
                    Image.asset(
                      'assets/images/Facebook.webp',
                      width: 51,
                    ),
                    Image.asset(
                      'assets/images/Apple.webp',
                      width: 51,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
