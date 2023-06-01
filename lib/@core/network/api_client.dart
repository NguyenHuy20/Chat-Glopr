import 'dart:io';
import 'package:chat_glopr/@core/network/service/auth_service.dart';
import 'package:chat_glopr/@core/network/service/conversation_service.dart';
import 'package:chat_glopr/@core/network/service/friend_service.dart';
import 'package:chat_glopr/@core/network/service/message_service.dart';
import 'package:chat_glopr/@core/network/service/notification_service.dart';
import 'package:chat_glopr/@core/network/service/user_service.dart';
import 'package:dio/dio.dart';

import '../storage/base.dart';
import 'environment_config.dart';

class ApiClient {
  final dio = Dio();
  AuthServices? authServices;
  UserServices? userServices;
  ConversationServices? conversationServices;
  FriendServices? friendServices;
  MessageServices? messageServices;
  NotificationServices? notificationServices;
  ApiClient() {
    _setUpDio();
    _setUpRetrofitService();
  }

  void _setUpDio() {
    dio.options.connectTimeout = 20000;
    dio.options.receiveTimeout = 20000;
    dio.options.contentType = 'application/json';
    getLocale().then((value) => dio.options
        .headers[HttpHeaders.acceptLanguageHeader] = value.languageCode);
    // ignore: unnecessary_string_interpolations
    dio.options.baseUrl = EnvironmentConfig.BASE_URL;
    // bool isFirst = true;
    dio.interceptors.addAll([
      /// Log
      LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
      ),

      /// Error
      InterceptorsWrapper(onRequest: (options, handler) async {
        String token = '';
        // String appVersion = await getAppVersion();
        // String? userAgent = await getUserAgent();
        await getToken().then((value) => token = value?.accessToken ?? '');
        options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
        // options.headers[HttpHeaders.userAgentHeader] = userAgent;
        // dio.options.headers['X-Client-Version'] = appVersion;
        return handler.next(options);
      }, onResponse: (response, handler) {
        return handler.next(response); // continue
      }, onError: (DioError e, handler) async {
        try {
          if (e.response == null || e.response!.statusCode != 401) {
            handler.next(e);
            return;
          }
          RequestOptions requestOptions = e.requestOptions;
          String token = '';
          // token = await refreshToken();
          if (token == "") {
            handler.next(e);
            return;
          }
          final opts = Options(method: requestOptions.method);
          dio.options.headers[HttpHeaders.authorizationHeader] =
              "Bearer $token";
          // String appVersion = await getAppVersion();
          // String? userAgent = await getUserAgent();
          // dio.options.headers[HttpHeaders.userAgentHeader] = userAgent;
          // dio.options.headers['X-Client-Version'] = appVersion;
          opts.headers = dio.options.headers;
          var response = await dio.request(requestOptions.path,
              options: opts,
              cancelToken: requestOptions.cancelToken,
              onReceiveProgress: requestOptions.onReceiveProgress,
              data: requestOptions.data,
              queryParameters: requestOptions.queryParameters);
          // redirect to login screen
          handler.resolve(response);
        } catch (ex) {
          print(ex);
        }
      })
    ]);
  }

  _setUpRetrofitService() {
    authServices = AuthServices(dio, baseUrl: dio.options.baseUrl);
    userServices = UserServices(dio, baseUrl: dio.options.baseUrl);
    conversationServices =
        ConversationServices(dio, baseUrl: dio.options.baseUrl);
    friendServices = FriendServices(dio, baseUrl: dio.options.baseUrl);
    messageServices = MessageServices(dio, baseUrl: dio.options.baseUrl);
    notificationServices =
        NotificationServices(dio, baseUrl: dio.options.baseUrl);
  }
}
