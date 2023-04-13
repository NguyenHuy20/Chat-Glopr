import 'package:chat_glopr/@core/network_model/result_register_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../network_model/result_login_model.dart';

part 'auth_service.g.dart';

@RestApi()
abstract class AuthServices {
  factory AuthServices(Dio dio, {String baseUrl}) = _AuthServices;

  @POST('auth/register')
  Future<ResultRegisterModel> register(@Body() userDict);

  @POST('auth/login')
  Future<ResultLoginModel> login(@Body() userDict);
}
