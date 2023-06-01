import 'dart:io';

import 'package:chat_glopr/screen/introduce/introduce_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upgrader/upgrader.dart';

import '../../../@share/applicationmodel/profile/profile_bloc.dart';
import '../../../@share/utils/utils.dart';
import '../../bottom_navigator/bottom_navigator_screen.dart';
import '../view_model/splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late ProfileBloc profileBloc;
  late SplashBloc splashBloc;
  late FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    splashBloc = BlocProvider.of<SplashBloc>(context)
      ..add(SplashInitialEvent(context: context));
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    onInit();
    super.initState();
  }

  onInit() async {
    await setupFirebaseMessaging();
  }

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: MultiBlocListener(
            listeners: [
              BlocListener<SplashBloc, SplashState>(listener: (context, state) {
                if (state is GeneralSettingsSuccessState) {
                  //Check logged
                  profileBloc.add(SplashCheckProfile());
                }
                if (state is GeneralSettingsErrorState) {
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                    return;
                  }
                  exit(0);
                }
              }),
              BlocListener<ProfileBloc, ProfileState>(
                  listener: (context, state) async {
                if (state is CheckProfileSuccessState) {
                  if (!mounted) {
                    return;
                  }
                  goToScreen(context, const BottomNavigatorScreen());
                  return;
                }
                if (state is CheckProfileErrorState) {
                  if (!mounted) {
                    return;
                  }
                  goToScreen(context, const IntroduceScreen());
                  return;
                }
              }),
            ],
            child: ConstrainedBox(
              constraints: const BoxConstraints.expand(),
              child: Image.asset(
                'assets/images/splash_scr.webp',
                fit: BoxFit.fill,
              ),
            )),
      ),
    );
  }

  Future<void> setupFirebaseMessaging() async {
    // requestPermission
    await firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print(message.notification);
      }
    });

    await firebaseMessaging.getToken().then((token) async {
      print('FCM token: ${token ?? ''}');
    });

    //  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    //   flutterLocalNotificationsPlugin.cancelAll();
    // });
  }
}
