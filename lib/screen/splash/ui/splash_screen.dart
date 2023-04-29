import 'dart:io';

import 'package:chat_glopr/screen/introduce/introduce_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  void initState() {
    splashBloc = BlocProvider.of<SplashBloc>(context)
      ..add(SplashInitialEvent(context: context));
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
