import 'package:chat_glopr/@core/network_model/result_send_message_model.dart';
import 'package:dio/dio.dart';

import '../../dependence_injection.dart';
import '../../local_model/send_message_model.dart';
import '../../network_model/result_get_list_message_model.dart';
import '../api_client.dart';

class MessageRepo {
  ApiClient apiClient = inject<ApiClient>();

  Future<ResultListMessageModel> getListMessage(String converId) async {
    try {
      return await apiClient.messageServices!.getListMessage(converId);
    } on DioError catch (e) {
      final value = ResultListMessageModel.fromJson(e.response!.data);
      return value;
    }
  }

  Future<ResultListMessageModel> pagingListMessage(
      String converId, int page) async {
    try {
      return await apiClient.messageServices!.pagingListMessage(converId, page);
    } on DioError catch (e) {
      final value = ResultListMessageModel.fromJson(e.response!.data);
      return value;
    }
  }

  Future<ResultSendMessageModel> sendMessage(SendMessageModel model) async {
    try {
      return await apiClient.messageServices!.sendMessage(model);
    } on DioError catch (e) {
      final value = ResultSendMessageModel.fromJson(e.response!.data);
      return value;
    }
  }
}
