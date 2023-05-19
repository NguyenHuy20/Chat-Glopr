import 'package:chat_glopr/@core/local_model/create_group_conver_model.dart';
import 'package:chat_glopr/@core/network_model/base_model.dart';
import 'package:chat_glopr/@core/network_model/result_create_group_conversation.dart';
import 'package:dio/dio.dart';

import '../../dependence_injection.dart';
import '../../local_model/add_member_model.dart';
import '../../network_model/result_create_conversation_model.dart';
import '../../network_model/result_get_conversation_group_model.dart';
import '../../network_model/result_get_conversation_model.dart';
import '../../network_model/result_get_one_conver_model.dart';
import '../../network_model/result_member_conversation_model.dart';
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

  Future<ResultGetOneConverModel> getOneConversation(String converId) async {
    try {
      return await apiClient.conversationServices!.getOneConversation(converId);
    } on DioError catch (e) {
      final value = ResultGetOneConverModel.fromJson(e.response!.data);
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

  Future<ResultCreateConversationModel> createPerConversation(
      String userId) async {
    Map<String, String> bodyUserId = {"userId": userId};
    try {
      return await apiClient.conversationServices!
          .createPerConversation(userId, bodyUserId);
    } on DioError catch (e) {
      final value = ResultCreateConversationModel.fromJson(e.response!.data);
      return value;
    }
  }

  Future<ResultMemberConversationModel> getMemberConversation(String id) async {
    try {
      return await apiClient.conversationServices!.getMemberConversation(id);
    } on DioError catch (e) {
      final value = ResultMemberConversationModel.fromJson(e.response!.data);
      return value;
    }
  }

  Future<BaseModel> addMemberConversation(AddMemberModel model) async {
    try {
      return await apiClient.conversationServices!.addMemberConversation(model);
    } on DioError catch (e) {
      final value = BaseModel.fromJson(e.response!.data);
      return value;
    }
  }

  Future<ResultCreateGroupConverModel> createGroupConversation(
      CreateGroupConverModel model) async {
    try {
      return await apiClient.conversationServices!
          .createGroupConversation(model);
    } on DioError catch (e) {
      final value = ResultCreateGroupConverModel.fromJson(e.response!.data);
      return value;
    }
  }

  Future<BaseModel> deleteMemberConver(String converId, String userId) async {
    try {
      return await apiClient.conversationServices!
          .deleteMemberConver(converId, userId);
    } on DioError catch (e) {
      final value = BaseModel.fromJson(e.response!.data);
      return value;
    }
  }

  Future<BaseModel> leaveConversation(String converId) async {
    try {
      return await apiClient.conversationServices!.leaveConversation(converId);
    } on DioError catch (e) {
      final value = BaseModel.fromJson(e.response!.data);
      return value;
    }
  }

  Future<BaseModel> deleteConversation(String converId) async {
    try {
      return await apiClient.conversationServices!.deleteConversation(converId);
    } on DioError catch (e) {
      final value = BaseModel.fromJson(e.response!.data);
      return value;
    }
  }
}
