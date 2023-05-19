import 'package:chat_glopr/@core/network_model/base_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../network_model/result_create_conversation_model.dart';
import '../../network_model/result_create_group_conversation.dart';
import '../../network_model/result_get_conversation_group_model.dart';
import '../../network_model/result_get_conversation_model.dart';
import '../../network_model/result_get_one_conver_model.dart';
import '../../network_model/result_member_conversation_model.dart';

part 'conversation_service.g.dart';

@RestApi()
abstract class ConversationServices {
  factory ConversationServices(Dio dio, {String baseUrl}) =
      _ConversationServices;

  @POST('conversation/individuals/{userId}')
  Future<ResultCreateConversationModel> createPerConversation(
      @Path() String userId, @Body() userDict);

  @POST('conversation/group')
  Future<ResultCreateGroupConverModel> createGroupConversation(
      @Body() userDict);

  @GET('conversation')
  Future<ResultGetConversationGroupModel> getConversationGroup(
      @Query("type") int type);

  @GET('conversation/{converId}')
  Future<ResultGetOneConverModel> getOneConversation(
      @Path("converId") String converId);

  @GET('conversation')
  Future<ResultGetConversationGroupModel> pagingConversationGroup(
      @Query("type") int type, @Query("page") int page);

  @GET('conversation')
  Future<ResultGetConversationModel> getConversation(@Query("type") int type);

  @GET('conversation')
  Future<ResultGetConversationModel> pagingConversation(
      @Query("type") int type, @Query("page") int page);

  @GET('conversation/{id}/members')
  Future<ResultMemberConversationModel> getMemberConversation(
      @Path("id") String id);

  @POST('conversation/members')
  Future<BaseModel> addMemberConversation(@Body() userDict);

  @DELETE('conversation/{converId}/members/leave')
  Future<BaseModel> leaveConversation(@Path() String converId);

  @DELETE('conversation/{converId}')
  Future<BaseModel> deleteConversation(@Path() String converId);

  @DELETE('conversation/{converId}/members/{userId}')
  Future<BaseModel> deleteMemberConver(@Path() String converId, String userId);
}
