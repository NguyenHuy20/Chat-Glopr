import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import '../../@share/utils/utils.dart';
import '../local_model/token_model.dart';
import 'shared_storage_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

//base
StreamController<Locale> localeStreamController =
    StreamController<Locale>.broadcast();

Future<String?> getStringValue(String key) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? value = pref.getString(key);
  return value;
}

Future saveStringVaue(String key, String value) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString(key, value);
}

//locale
Future<Locale> getLocale() async {
  String langCode = "vi";
  String countryCode = "VN";
  var localeCode = await getStringValue(SharedStorageConstants.locale);
  if (localeCode != null) {
    var arr = localeCode.split("_");
    langCode = arr[0];
    countryCode = arr[1];
  }
  return Locale(langCode, countryCode);
}

Future saveLocale(Locale locale) async {
  await saveStringVaue(SharedStorageConstants.locale,
      locale.languageCode + "_" + locale.countryCode!);
}

Future<TokenModel?> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  String? jsonText = pref.getString(SharedStorageConstants.token);
  if (isNullOrEmptyString(jsonText)) return null;

  var token = TokenModel.fromJson(json.decode(jsonText!));
  return token;
}

Future saveToken(TokenModel tokenModel) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  var jsonText = tokenModel != null ? jsonEncode(tokenModel.toJson()) : "";

  await pref.setString(SharedStorageConstants.token, jsonText);
}

Future removeToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.remove(SharedStorageConstants.token);
}
