import 'dart:io';

import 'package:chat_glopr/@core/network_model/result_send_otp_model.dart';
import 'package:chat_glopr/@core/network_model/result_upload_image_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../network_model/result_detail_user_info.dart';
import '../../network_model/result_profile_model.dart';
import '../../network_model/result_search_user_model.dart';
import '../../network_model/result_update_user_info.dart';

part 'user_service.g.dart';

@RestApi()
abstract class UserServices {
  factory UserServices(Dio dio, {String baseUrl}) = _UserServices;

  @POST('users/request-send-otp')
  Future<ResultSendOTPModel> requestOTP(@Body() userDict);

  @GET('users/me')
  Future<ResultProfileModel> fetchProfile();

  @PATCH('users/me')
  Future<ResultUpdateUserInfoModel> updateUserInfo(@Body() useDict);

  @GET('users/detail/{key}')
  Future<ResultDetailUserInfoModel> getDetailUserInfo(@Path('key') String key);

  @POST("upload/avatar")
  @MultiPart()
  Future<ResultUploadImageModel> uploadFile(@Part() File file);

  @GET('users')
  Future<ResultSearchUserpModel> searchUser(@Query('key') String key);
}
