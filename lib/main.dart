import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import '@core/dependence_injection.dart';
import '@core/storage/base.dart';
import 'my_app.dart';

// Future<void> _firebaseOnBackgroundHander(RemoteMessage msg) async {

// }

void main() async {
  runZonedGuarded<Future<void>>(() async {
    initDependence();
    WidgetsFlutterBinding.ensureInitialized();
    // final GoogleMapsFlutterPlatform mapsImplementation =
    //   GoogleMapsFlutterPlatform.instance;
    // if (mapsImplementation is GoogleMapsFlutterAndroid) {
    //   mapsImplementation.useAndroidViewSurface = true;
    // }

    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    // FirebaseMessaging.onBackgroundMessage(_firebaseOnBackgroundHander);
    // FirebaseMessaging messaging = FirebaseMessaging.instance;
    MyApp.initSystemDefault();

    //UserAgent
    await FkUserAgent.init();
    await EasyLocalization.ensureInitialized();
    var startLocale = await getLocale();
    runApp(MyApp.runWidget());
  }, (error, stack) {
    print('');
  });
}
