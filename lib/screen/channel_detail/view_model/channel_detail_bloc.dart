import 'dart:io';
import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:chat_glopr/@core/local_model/send_message_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../@core/dependence_injection.dart';
import '../../../@core/network/repository/message_repo.dart';
import '../../../@core/network_model/result_get_conversation_group_model.dart';
import '../../../@core/network_model/result_get_list_message_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../@share/utils/socket_client_util.dart';
import '../ui/widget_dialog_channel_setting.dart';

part 'channel_detail_event.dart';
part 'channel_detail_state.dart';

class ChannelDetailBloc extends Bloc<ChannelDetailEvent, ChannelDetailState> {
  List<MessageData> messData = [];
  int pageIndex = 1;
  bool endPage = false;
  ChannelDetailBloc() : super(ChannelDetailInitial()) {
    on<GetListMessageEvent>(_getListMessage);
    on<SendMessageEvent>(_sendMessage);
    on<ShowDialogGroupSettingEvent>(_showGroupSetting);
    on<ReciveMessageEvent>(_reciveMessage);
    on<PagingListMessageChannelEvent>(_pagingListMessage);
  }
  MessageRepo messageRepo = inject<MessageRepo>();

  Future<void> _getListMessage(
      GetListMessageEvent event, Emitter<ChannelDetailState> emit) async {
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

  Future<void> _pagingListMessage(PagingListMessageChannelEvent event,
      Emitter<ChannelDetailState> emit) async {
    if (endPage == false) {
      try {
        pageIndex++;
        emit(ShowLoadingMessage());
        var result =
            await messageRepo.pagingListMessage(event.converId, pageIndex);
        emit(NotShowLoadingMessage());
        if (result.success == true &&
            result.statusCode == 200 &&
            result.data != null) {
          if (result.data!.isEmpty) {
            endPage = true;
            emit(LostPagingMessageChannelState());
            return;
          }
          result.data?.forEach((element) {
            messData.add(element);
          });

          emit(PagingMessageChannelSuccessState(data: messData));
          return;
        }
        emit(PagingMessageChannelFailState());
      } catch (ex) {
        emit(PagingMessageChannelFailState());
      }
    }
  }

  Future<void> _sendMessage(
      SendMessageEvent event, Emitter<ChannelDetailState> emit) async {
    try {
      messData.insert(
          0,
          MessageData(
            id: '',
            content: event.content,
            type: '',
            createdAt: 'Đang gửi',
            user: UserMessing(
                id: event.desId,
                fullName: event.fullName,
                avatar: event.avatar),
            manipulatedUsers: [],
            replyMessage: [],
          ));
      emit(SendingMessageState(data: messData));
      var result = await messageRepo.sendMessage(
          SendMessageModel(content: event.content, desId: event.desId));
      if (result.success == true) {
        messData[0] = MessageData(
          id: result.data?.id,
          content: result.data?.content,
          type: result.data?.type,
          createdAt: result.data?.createdAt,
          user: UserMessing(
              id: result.data?.user?.id,
              fullName: result.data?.user?.fullName,
              avatar: result.data?.user?.avatar),
          manipulatedUsers: [],
          replyMessage: [],
        );
        emit(SendMessageSuccessState(data: messData));
        return;
      }
      messData[0] = MessageData(
        id: '',
        content: event.content,
        type: '',
        createdAt: 'Lỗi hãy gửi lại',
        user: UserMessing(
            id: event.desId, fullName: event.fullName, avatar: event.avatar),
        manipulatedUsers: [],
        replyMessage: [],
      );
      emit(SendMessageFailState(data: messData));
    } catch (ex) {}
  }

  Future<void> _showGroupSetting(ShowDialogGroupSettingEvent event,
      Emitter<ChannelDetailState> emit) async {
    return showCupertinoDialog(
        context: event.context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
            backgroundColor: Colors.transparent,
            contentPadding: const EdgeInsets.all(0),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            content: Container(
              height: 700,
              width: 400,
            ).blurred(
                colorOpacity: 0.84,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                blur: 6,
                overlay: DialogChannelSetting(
                  data: event.data,
                ))));
  }

  Future<void> _reciveMessage(
      ReciveMessageEvent event, Emitter<ChannelDetailState> emit) async {
    Map<String, dynamic> userMessing = event.data[1]['user'];
    messData.insert(
        0,
        MessageData(
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
