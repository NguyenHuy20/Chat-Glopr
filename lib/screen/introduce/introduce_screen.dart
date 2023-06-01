import 'package:chat_glopr/@share/utils/utils.dart';
import 'package:chat_glopr/@share/values/styles.dart';
import 'package:chat_glopr/screen/login/ui/login_page.dart';
import 'package:chat_glopr/screen/register/ui/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../@share/widgets/button_custom.dart';

class IntroduceScreen extends StatelessWidget {
  const IntroduceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/bg_introduce.webp',
                ),
                fit: BoxFit.fill)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 40),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Text(
              'Meet more friend to',
              style: appStyle.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Text(
              'get more fun in your life',
              style: appStyle.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
            btnPrimaryDefaut(
                onTap: () => goToScreen(context, const RegisterPage()),
                content: 'Register'),
            const SizedBox(
              height: 10,
            ),
            btnPrimaryDefaut(
                onTap: () => goToScreen(context, const LoginPage()),
                content: 'I have an account',
                btnColor: Colors.transparent,
                borderColor: Colors.white,
                contentColor: Colors.white),
          ]),
        ),
      ),
    );
  }
}
