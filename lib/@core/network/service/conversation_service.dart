import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../network_model/result_create_conversation_model.dart';
import '../../network_model/result_get_conversation_model.dart';

part 'conversation_service.g.dart';

@RestApi()
abstract class ConversationServices {
  factory ConversationServices(Dio dio, {String baseUrl}) =
      _ConversationServices;

  @POST('conversation/individuals/{userId}')
  Future<ResultCreateConversationModel> createConversation(
      @Path() String userId, @Body() userDict);

  @GET('conversation')
  Future<ResultGetConversationModel> getConversation(@Query("type") int type);

  @GET('conversation')
  Future<ResultGetConversationModel> pagingConversation(
      @Query("type") int type, @Query("page") int page);
}
