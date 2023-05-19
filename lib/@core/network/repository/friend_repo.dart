import 'package:chat_glopr/@core/network_model/base_model.dart';
import 'package:chat_glopr/@core/network_model/result_list_friend_mode.dart';
import 'package:dio/dio.dart';

import '../../dependence_injection.dart';
import '../api_client.dart';

class FriendRepo {
  ApiClient apiClient = inject<ApiClient>();

  Future<ResultListFriendModel> getListFriend() async {
    try {
      return await apiClient.friendServices!.getListFriend();
    } on DioError catch (e) {
      final value = ResultListFriendModel.fromJson(e.response!.data);
      return value;
    }
  }

  Future<BaseModel> sendFriendRequest(String userId) async {
    Map<String, dynamic> addFriendModel = {"userId": userId};
    try {
      return await apiClient.friendServices!.sendFriendRequest(addFriendModel);
    } on DioError catch (e) {
      final value = BaseModel.fromJson(e.response!.data);
      return value;
    }
  }

  Future<BaseModel> acceptFriendRequest(String userId) async {
    Map<String, dynamic> acptFriendModel = {"userId": userId};
    try {
      return await apiClient.friendServices!
          .acceptFriendRequest(acptFriendModel);
    } on DioError catch (e) {
      final value = BaseModel.fromJson(e.response!.data);
      return value;
    }
  }

  Future<ResultListFriendModel> getListFriendRequest() async {
    try {
      return await apiClient.friendServices!.getListFriendRequest();
    } on DioError catch (e) {
      final value = ResultListFriendModel.fromJson(e.response!.data);
      return value;
    }
  }

  Future<BaseModel> deleteFriendRequest(String userId) async {
    try {
      return await apiClient.friendServices!.deleteFriendRequest(userId);
    } on DioError catch (e) {
      final value = BaseModel.fromJson(e.response!.data);
      return value;
    }
  }

  Future<ResultListFriendModel> getListFriendRequestSendYourself() async {
    try {
      return await apiClient.friendServices!.getListFriendRequestSendYourself();
    } on DioError catch (e) {
      final value = ResultListFriendModel.fromJson(e.response!.data);
      return value;
    }
  }
}
