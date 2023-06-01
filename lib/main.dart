import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:upgrader/upgrader.dart';

import '@core/dependence_injection.dart';
import '@core/storage/base.dart';
import 'firebase_options.dart';
import 'my_app.dart';

Future<void> _firebaseOnBackgroundHander(RemoteMessage msg) async {
  await Firebase.initializeApp();
}

void firebaseCloudMessagingListeners() {
  FirebaseMessaging.onMessage.listen((event) async {});

  FirebaseMessaging.onMessageOpenedApp.listen((event) {});
}

void main() async {
  runZonedGuarded<Future<void>>(() async {
    initDependence();
    WidgetsFlutterBinding.ensureInitialized();
    await Upgrader.clearSavedSettings();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    firebaseCloudMessagingListeners();
    FirebaseMessaging.onBackgroundMessage(_firebaseOnBackgroundHander);
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
    runApp(Phoenix(
        child: EasyLocalization(
            supportedLocales: const [Locale('vi', 'VN'), Locale('en', 'US')],
            path: 'assets/langs',
            startLocale: startLocale,
            child: MyApp.runWidget())));
  }, (error, stack) {
    print('');
  });
}
