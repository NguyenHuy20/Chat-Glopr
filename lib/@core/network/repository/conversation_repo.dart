import 'package:chat_glopr/@core/network_model/base_model.dart';
import 'package:dio/dio.dart';

import '../../dependence_injection.dart';
import '../../network_model/result_create_conversation_model.dart';
import '../../network_model/result_get_conversation_group_model.dart';
import '../../network_model/result_get_conversation_model.dart';
import '../api_client.dart';

class ConversationRepo {
  ApiClient apiClient = inject<ApiClient>();

  Future<ResultGetConversationModel> getConversation(int type) async {
    try {
      return await apiClient.conversationServices!.getConversation(type);
    } on DioError catch (e) {
      final value = ResultGetConversationModel.fromJson(e.response!.data);
      return value;
    }
  }

  Future<ResultGetConversationGroupModel> getConversationGroup(int type) async {
    try {
      return await apiClient.conversationServices!.getConversationGroup(type);
    } on DioError catch (e) {
      final value = ResultGetConversationGroupModel.fromJson(e.response!.data);
      return value;
    }
  }

  Future<ResultGetConversationGroupModel> pagingConversationGroup(
      int type, int page) async {
    try {
      return await apiClient.conversationServices!
          .pagingConversationGroup(type, page);
    } on DioError catch (e) {
      final value = ResultGetConversationGroupModel.fromJson(e.response!.data);
      return value;
    }
  }

  Future<ResultGetConversationModel> pagingConversation(
      int type, int page) async {
    try {
      return await apiClient.conversationServices!
          .pagingConversation(type, page);
    } on DioError catch (e) {
      final value = ResultGetConversationModel.fromJson(e.response!.data);
      return value;
    }
  }

  Future<ResultCreateConversationModel> createConversation(
      String userId) async {
    Map<String, String> bodyUserId = {"userId": userId};
    try {
      return await apiClient.conversationServices!
          .createConversation(userId, bodyUserId);
    } on DioError catch (e) {
      final value = ResultCreateConversationModel.fromJson(e.response!.data);
      return value;
    }
  }
}
