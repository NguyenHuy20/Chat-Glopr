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
}
