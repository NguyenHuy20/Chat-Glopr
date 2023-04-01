import 'package:chat_glopr/@share/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../@core/storage/base.dart';
import '../@core/storage/shared_storage_constants.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void showcirle(BuildContext context, bool turn) async {
  return turn
      ? showDialog(
          builder: (context) => GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: cupertinoLoading(color: Colors.grey),
                ),
              ),
          barrierDismissible: false,
          context: context)
      : Navigator.pop(context);
}

// save appversion
Future<String> getAppVersion() async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  String? jsonText = pref.getString(SharedStorageConstants.appVersion);
  return jsonText ?? '';
}

Future saveAppVersion(String? version) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var jsonText = version ?? '';

  await pref.setString(SharedStorageConstants.appVersion, jsonText);
}

Future removeAppVersion() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.remove(SharedStorageConstants.appVersion);
}

/// DEVICE UUID
Future<String> getDeviceUUID() async {
  return await getStringValue(SharedStorageConstants.deviceUUID) ?? '';
}

Future saveDeviceUUID(String deviceUUID) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString(SharedStorageConstants.deviceUUID, deviceUUID);
}

Future removeDeviceUUID() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.remove(SharedStorageConstants.deviceUUID);
}
