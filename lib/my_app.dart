import 'dart:io';

import 'package:chat_glopr/screen/splash/ui/splash_page.dart';
import 'package:chat_glopr/screen/splash/view_model/splash_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '@share/base.dart';
import '@share/values/colors.dart';
import 'screen/introduce/introduce_screen.dart';
import 'screen/splash/ui/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: MaterialApp(
          title: 'Chat Glopr',
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
            EasyLocalization.of(context)!.delegate,
          ],
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: ThemeData(
              primarySwatch: black,
              platform: TargetPlatform.iOS,
              fontFamily: 'SVN-Poppins'),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  textScaleFactor:
                      MediaQuery.of(context).size.height > 850 ? 1.1 : 1),
              child: child!,
            );
          },
          home: const IntroduceScreen(),
        ));
  }

  static void initSystemDefault() async {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
          Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
  }

  static Widget runWidget() {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SplashBloc(),
        ),
      ],
      child: const MyApp(),
    );
  }
}
