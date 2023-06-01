import 'package:chat_glopr/@share/utils/utils.dart';
import 'package:chat_glopr/@share/values/colors.dart';
import 'package:chat_glopr/@share/values/styles.dart';
import 'package:chat_glopr/@share/widgets/button_custom.dart';
import 'package:chat_glopr/screen/chose_image/complete_choose_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChoseImageScreen extends StatelessWidget {
  const ChoseImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg_chose_image.webp'),
                fit: BoxFit.fill)),
        child: Padding(
          padding: const EdgeInsets.only(left: 30, top: 200, right: 30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Complete',
              style: titleStyle,
            ),
            Text(
              'profile',
              style: appStyle.copyWith(fontSize: 32),
            ),
            const SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: pink, width: 5)),
                      child: Image.asset(
                        'assets/icons/camera.webp',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Take picture',
                      style: appStyle.copyWith(fontSize: 20),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: pink, width: 5)),
                      child: Image.asset(
                        'assets/icons/image.webp',
                        width: 70,
                        height: 60,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Chose picture',
                      style: appStyle.copyWith(fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                  width: 133,
                  child: btnPink(
                      onTap: () => goToScreen(context, CompleteChooseImage()),
                      content: 'Later',
                      contentColor: Colors.white,
                      icon: Icons.arrow_right_alt)),
            )
          ]),
        ),
      ),
    );
  }
}
