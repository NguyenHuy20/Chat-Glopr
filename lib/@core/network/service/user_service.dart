import 'package:chat_glopr/@core/network_model/result_send_otp_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../network_model/result_profile_model.dart';

part 'user_service.g.dart';

@RestApi()
abstract class UserServices {
  factory UserServices(Dio dio, {String baseUrl}) = _UserServices;

  @POST('users/request-send-otp')
  Future<ResultSendOTPModel> requestOTP(@Body() userDict);

  @GET('users/me')
  Future<ResultProfileModel> fetchProfile();
}
