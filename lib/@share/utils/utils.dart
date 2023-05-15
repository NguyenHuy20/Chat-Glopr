import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../../@core/network/environment_config.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:permission_handler/permission_handler.dart';

import '../values/styles.dart';

Future goToScreen(BuildContext context, Widget screen,
    {int milliseconds = 100,
    String? routeName,
    ToScreenType type = ToScreenType.fade}) async {
  if (type == ToScreenType.fade) {
    return await Navigator.push(
      context,
      PageRouteBuilder(
          transitionDuration: Duration(milliseconds: milliseconds),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return screen;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return Align(
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          settings: RouteSettings(name: routeName ?? "")),
    );
  }

  if (type == ToScreenType.remove) {
    return await Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute<void>(builder: (BuildContext context) => screen),
        (Route<dynamic> route) => false);
  }

  if (type == ToScreenType.replacement) {
    return await Navigator.pushReplacement(context,
        MaterialPageRoute<void>(builder: (BuildContext context) => screen));
  }

  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => screen));
}

enum ToScreenType { nomal, fade, replacement, remove }

bool isNullOrEmpty(String? value) {
  return value == null || value.isEmpty;
}

String convertNumberTextToCurrencyText(String text,
    {String currencySymbol = "đ"}) {
  return convertNumberToCurrencyText(parseStringToDouble(text),
      currencySymbol: currencySymbol);
}

String convertNumberToCurrencyText(double number,
    {String currencySymbol = "₫"}) {
  number = number;
  final oCcy = NumberFormat("#,##0$currencySymbol", "vi_VN");
  return oCcy.format(number);
}

double parseStringToDouble(String text) {
  if (isNullOrEmpty(text)) return 0;

  return double.parse(text);
}

double paddingTopPlatform(BuildContext context) {
  return MediaQuery.of(context).viewPadding.top;
}

bool isNullOrEmptyString(String? value) {
  return value == null || value.trim() == "";
}

double getHeight(BuildContext context) => MediaQuery.of(context).size.height;

void popToScreen(BuildContext context, [dynamic params]) =>
    Navigator.pop(context, params);

Future<bool> checkPermission() async {
  if (await Permission.location.isGranted
      // ||     await Permission.location.request() ==
      //         PermissionStatus.permanentlyDenied
      ) {
    return true;
  }
  return false;
}

Widget loadingWidget({Color color = Colors.white}) => ColorFiltered(
      colorFilter: ColorFilter.mode(
        color,
        BlendMode.srcATop,
      ),
      child: Platform.isIOS
          ? const CupertinoActivityIndicator()
          : const CircularProgressIndicator(),
    );
void showLoading(BuildContext context, bool turn, {Color? color}) async {
  return turn
      ? showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return GestureDetector(
              onTap: () {
                popToScreen(context);
              },
              child: Center(
                child: loadingWidget(color: color ?? Colors.grey),
              ),
            );
          })
      : popToScreen(context);
}

Widget cupertinoLoading({Color color = Colors.white}) => ColorFiltered(
      colorFilter: ColorFilter.mode(
        color,
        BlendMode.srcATop,
      ),
      child: const CupertinoActivityIndicator(),
    );
dynamic translateContentApi(
    BuildContext context, dynamic languageVi, dynamic languageEn) {
  return getLanguageCurrent(context) == "vi" ? languageVi : languageEn;
}

String? getLanguageCurrent(BuildContext context) {
  return EasyLocalization.of(context)?.locale.languageCode;
}

DateTime? convertTextToDateTime(String? text) {
  if (isNullOrEmptyString(text) == false) {
    var dt = DateTime.parse(text!).toLocal();
    return dt;
  }
  return null;
}

String convertDateTimeToText(DateTime dt, {DateFormat? format}) {
  dt = dt.toUtc();

  if (format != null) {
    return format.format(dt);
  }

  return dt.toIso8601String();
}

String getImageNetwork(String? id) {
  if (id == null || id.trim() == "" || id == "") {
    return "";
  }
  return "${EnvironmentConfig.BASE_IMAGE_URL}?id=$id";
}

String getImageAvatar(String idimg) {
  return "${EnvironmentConfig.BASE_IMAGE_URL}?id=$idimg&width=117&height=117&format=${idimg.split(".").last}";
}

Future<File> createImageFile(bytes) async {
  await initializeDateFormatting('vi_VN');
  final directory = await getApplicationDocumentsDirectory();
  DateTime now = DateTime.now();
  String timeStamp = DateFormat('yyyyMMdd_HHmmss').format(now);
  String imageFileName = "JPEG_$timeStamp";
  File image = await File('${directory.path}/$imageFileName.jpg')
      .create(recursive: true);
  await image.writeAsBytes(base64Decode(bytes));
  return image;
}

// Future<String> getUUID() async {
//   String uuid = "";
//   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//   if (Platform.isIOS == true) {
//     IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
//     uuid = iosDeviceInfo.identifierForVendor ?? ''; // unique ID on iOS
//   } else {
//     AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
//     uuid = androidDeviceInfo.id; // unique ID on Android
//   }
//   return uuid;
// }

///Latest Version
// Future<bool> latestVersion(String storeVersion, String linkStore) async {
//   try {
//     PackageInfo packageInfo = await PackageInfo.fromPlatform();
//     print(packageInfo.version);
//     await saveAppVersion(packageInfo.version);
//     return checkVersion(packageInfo.version, storeVersion);
//   } catch (ex) {
//     // send ex to Slack
//     return false;
//   }
// }

bool checkVersion(String localVersion, String storeVersion) {
  List<String> slipLocalVersion = localVersion.split(".");
  List<String> slipStoreVersion = storeVersion.split(".");
  return int.parse(slipLocalVersion[slipLocalVersion.length - 2]) <
          int.parse(slipStoreVersion[slipStoreVersion.length - 2]) ||
      (slipLocalVersion[slipLocalVersion.length - 2]) ==
              slipStoreVersion[slipStoreVersion.length - 2] &&
          int.parse(slipLocalVersion.last) < int.parse(slipStoreVersion.last);
}

Widget loadMore(
    ScrollController scrollController, Widget widget, bool isEndPage) {
  return ListView(
    padding: EdgeInsets.zero,
    controller: scrollController,
    physics: const AlwaysScrollableScrollPhysics(),
    shrinkWrap: false,
    children: [
      widget,
      isEndPage
          ? Center(
              child: Text("Đã xem hết danh sách",
                  style: appStyle.copyWith(color: Colors.grey, fontSize: 12)))
          : const SizedBox()
    ],
  );
}

Future<String> getUUID() async {
  String uuid = "";
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS == true) {
    IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
    uuid = iosDeviceInfo.identifierForVendor ?? ''; // unique ID on iOS
  } else {
    AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
    uuid = androidDeviceInfo.id; // unique ID on Android
  }
  return uuid;
}
