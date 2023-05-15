import 'package:chat_glopr/@core/local_model/login_model.dart';
import 'package:chat_glopr/@core/network_model/result_login_model.dart';
import 'package:chat_glopr/@core/network_model/result_register_model.dart';
import 'package:dio/dio.dart';

import '../../dependence_injection.dart';
import '../../local_model/fcm_model.dart';
import '../../local_model/register_model.dart';
import '../../network_model/result_add_fcm_model.dart';
import '../api_client.dart';

class NotificationRepo {
  ApiClient apiClient = inject<ApiClient>();

  Future<ResultFcmModel> addFcmToken(FCMModel model) async {
    try {
      return await apiClient.notificationServices!.addFcmToken(model);
    } on DioError catch (e) {
      final value = ResultFcmModel.fromJson(e.response!.data);
      return value;
    }
  }

  Future<ResultFcmModel> removeFcmToken(String deviceUuid) async {
    Map<String, dynamic> deviceId = {'deviceUuid': deviceUuid};
    try {
      return await apiClient.notificationServices!.removeFcmToken(deviceId);
    } on DioError catch (e) {
      final value = ResultFcmModel.fromJson(e.response!.data);
      return value;
    }
  }
}
