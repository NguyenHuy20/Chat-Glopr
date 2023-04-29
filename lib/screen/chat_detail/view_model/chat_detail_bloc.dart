import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../@core/dependence_injection.dart';
import '../../../@core/local_model/send_message_model.dart';
import '../../../@core/network/repository/message_repo.dart';
import '../../../@core/network_model/result_get_list_message_model.dart';

part 'chat_detail_event.dart';
part 'chat_detail_state.dart';

class ChatDetailBloc extends Bloc<ChatDetailEvent, ChatDetailState> {
  List<MessageData> messData = [];
  ChatDetailBloc() : super(ChatDetailInitial()) {
    on<GetListMessageEvent>(_getListMessage);
    on<SendMessageEvent>(_sendMessage);
    on<ReciveMessageEvent>(_reciveMessage);
  }
  MessageRepo messageRepo = inject<MessageRepo>();

  Future<void> _getListMessage(
      GetListMessageEvent event, Emitter<ChatDetailState> emit) async {
    try {
      var result = await messageRepo.getListMessage(event.converId);
      if (result.success == true && result.data != null) {
        messData = result.data!;
        emit(GetListMessageSuccessState(data: messData));
        return;
      }
      emit(GetListMessageFailState());
    } catch (ex) {
      emit(GetListMessageFailState());
    }
  }

  Future<void> _sendMessage(
      SendMessageEvent event, Emitter<ChatDetailState> emit) async {
    try {
      var result = await messageRepo.sendMessage(
          SendMessageModel(content: event.content, desId: event.desId));
      if (result.success == true) {
        return;
      }
    } catch (ex) {
      print(ex);
    }
  }

  Future<void> _reciveMessage(
      ReciveMessageEvent event, Emitter<ChatDetailState> emit) async {
    Map<String, dynamic> userMessing = event.data[1]['user'];

    messData.add(MessageData(
      id: event.data[1]['_id'],
      content: event.data[1]['content'],
      type: event.data[1]['type'],
      createdAt: event.data[1]['createdAt'],
      user: UserMessing(
          id: userMessing['_id'],
          fullName: userMessing['fullName'],
          avatar: userMessing['avatar']),
      manipulatedUsers: [],
      replyMessage: [],
    ));
    emit(ReciveMessageState(data: messData));
  }
}
