import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../network_model/result_get_list_message_model.dart';
import '../../network_model/result_send_message_model.dart';

part 'message_service.g.dart';

@RestApi()
abstract class MessageServices {
  factory MessageServices(Dio dio, {String baseUrl}) = _MessageServices;

  @POST('messages/text')
  Future<ResultSendMessageModel> sendMessage(@Body() useDict);

  @GET('messages/{converId}')
  Future<ResultListMessageModel> getListMessage(
      @Path('converId') String converId);
}
