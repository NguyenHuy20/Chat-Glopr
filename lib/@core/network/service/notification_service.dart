import 'package:chat_glopr/@core/network_model/result_register_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../network_model/result_add_fcm_model.dart';

part 'notification_service.g.dart';

@RestApi()
abstract class NotificationServices {
  factory NotificationServices(Dio dio, {String baseUrl}) =
      _NotificationServices;

  @POST('notification/fcm-token')
  Future<ResultFcmModel> addFcmToken(@Body() userDict);

  @DELETE('notification/fcm-token')
  Future<ResultFcmModel> removeFcmToken(@Body() userDict);
}
