import 'package:chat_glopr/@core/local_model/change_password_model.dart';
import 'package:chat_glopr/@core/local_model/login_model.dart';
import 'package:chat_glopr/@core/network_model/base_model.dart';
import 'package:chat_glopr/@core/network_model/result_login_model.dart';
import 'package:chat_glopr/@core/network_model/result_register_model.dart';
import 'package:dio/dio.dart';

import '../../dependence_injection.dart';
import '../../local_model/register_model.dart';
import '../api_client.dart';

class AuthRepo {
  ApiClient apiClient = inject<ApiClient>();

  Future<ResultLoginModel> login(LoginModel model) async {
    try {
      return await apiClient.authServices!.login(model);
    } on DioError catch (e) {
      final value = ResultLoginModel.fromJson(e.response!.data);
      return value;
    }
  }

  Future<ResultRegisterModel> register(RegisterModel model) async {
    try {
      return await apiClient.authServices!.register(model);
    } on DioError catch (e) {
      final value = ResultRegisterModel.fromJson(e.response!.data);
      return value;
    }
  }

  Future<BaseModel> changePass(ChangePasswordModel model) async {
    try {
      return await apiClient.authServices!.changePass(model);
    } on DioError catch (e) {
      final value = BaseModel.fromJson(e.response!.data);
      return value;
    }
  }
}
