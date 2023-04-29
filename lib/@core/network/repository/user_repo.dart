import 'package:chat_glopr/@core/network_model/result_detail_user_info.dart';
import 'package:chat_glopr/@core/network_model/result_send_otp_model.dart';
import 'package:chat_glopr/@core/network_model/result_update_user_info.dart';
import 'package:dio/dio.dart';

import '../../dependence_injection.dart';
import '../../local_model/request_otp_model.dart';
import '../../local_model/update_user_info_model.dart';
import '../../network_model/result_profile_model.dart';
import '../api_client.dart';

class UserRepo {
  ApiClient apiClient = inject<ApiClient>();

  Future<ResultSendOTPModel> requestOTP(RequestOTPModel model) async {
    try {
      return await apiClient.userServices!.requestOTP(model);
    } on DioError catch (e) {
      final value = ResultSendOTPModel.fromJson(e.response!.data);
      return value;
    }
  }

  Future<ResultProfileModel> fecthProfile() async {
    try {
      return await apiClient.userServices!.fetchProfile();
    } on DioError catch (e) {
      final value = ResultProfileModel.fromJson(e.response!.data);
      return value;
    }
  }

  Future<ResultUpdateUserInfoModel> updateUserInfo(
      UpdateUserInfoModel model) async {
    try {
      return await apiClient.userServices!.updateUserInfo(model);
    } on DioError catch (e) {
      final value = ResultUpdateUserInfoModel.fromJson(e.response!.data);
      return value;
    }
  }

  Future<ResultDetailUserInfoModel> getDetailUserInfo(String key) async {
    try {
      return await apiClient.userServices!.getDetailUserInfo(key);
    } on DioError catch (e) {
      final value = ResultDetailUserInfoModel.fromJson(e.response!.data);
      return value;
    }
  }
}
