import 'package:chat_glopr/@core/network_model/base_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../network_model/result_list_friend_mode.dart';

part 'friend_service.g.dart';

@RestApi()
abstract class FriendServices {
  factory FriendServices(Dio dio, {String baseUrl}) = _FriendServices;

  @GET('friend')
  Future<ResultListFriendModel> getListFriend();

  @GET('friend/invites')
  Future<ResultListFriendModel> getListFriendRequest();

  @POST('friend/invites')
  Future<BaseModel> sendFriendRequest(@Body() useDict);

  @POST('friend')
  Future<BaseModel> acceptFriendRequest(@Body() useDict);

  @DELETE('friend/invites/{userId}')
  Future<BaseModel> deleteFriendRequest(@Path("userId") String userId);

  @GET('friend/invites/me')
  Future<ResultListFriendModel> getListFriendRequestSendYourself();
}
