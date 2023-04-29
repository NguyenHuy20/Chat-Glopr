import 'package:chat_glopr/@core/network/repository/conversation_repo.dart';
import 'package:chat_glopr/@core/network_model/result_get_conversation_group_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../@core/dependence_injection.dart';
import '../../../@core/network_model/result_get_conversation_model.dart';
import '../../channel_detail/ui/widget_dialog_delete_conversation.dart';
import '../../channel_detail/ui/widget_dialog_join_channel.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  int pageIndex = 1;
  bool endPage = false;
  int pageGroupIndex = 1;
  bool endPageGroup = false;
  List<ConversationGroupData> modelGroup = [];
  List<ConversationData> model = [];

  ChatBloc() : super(ChatInitial()) {
    on<GetConversationEvent>(_getConversation);
    on<CreateConversationEvent>(_createConversation);
    on<PagingConversationEvent>(_pagingConversation);
    on<PagingConversationGroupEvent>(_pagingConversationGroup);
    on<ShowDialogJoinChannelEvent>(_showDialogJoinChannel);
    on<ShowDialogDeleteConversation>(_showDialogDeleteConversation);
    on<GetConversationGroupEvent>(_getConversationGroup);
  }
  ConversationRepo conversationRepo = inject<ConversationRepo>();
  Future<void> _getConversation(
      GetConversationEvent event, Emitter<ChatState> emit) async {
    try {
      var result = await conversationRepo.getConversation(event.type);
      if (result.success == true &&
          result.statusCode == 200 &&
          result.data != null) {
        emit(GetConversationSuccessState(lstConservation: result.data!));
        return;
      }
      emit(GetConversationFailState());
    } catch (ex) {
      emit(GetConversationFailState());
    }
  }

  Future<void> _getConversationGroup(
      GetConversationGroupEvent event, Emitter<ChatState> emit) async {
    try {
      var result = await conversationRepo.getConversationGroup(event.type);
      if (result.success == true &&
          result.statusCode == 200 &&
          result.data != null) {
        emit(GetConversationGroupSuccessState(lstConservation: result.data!));
        return;
      }
      emit(GetConversationGroupFailState());
    } catch (ex) {
      emit(GetConversationGroupFailState());
    }
  }

  Future<void> _pagingConversation(
      PagingConversationEvent event, Emitter<ChatState> emit) async {
    if (endPage == false) {
      try {
        pageIndex++;
        var result =
            await conversationRepo.pagingConversation(event.type, pageIndex);
        if (result.success == true &&
            result.statusCode == 200 &&
            result.data != null) {
          if (result.data!.isEmpty) {
            endPage = true;
            emit(LostPagingState());
            return;
          }
          result.data?.forEach((element) {
            model.add(element);
          });

          emit(PagingConversationSuccessState(data: model));
          return;
        }
        emit(PagingConversationFailState());
      } catch (ex) {
        emit(PagingConversationFailState());
      }
    }
  }

  Future<void> _pagingConversationGroup(
      PagingConversationGroupEvent event, Emitter<ChatState> emit) async {
    if (endPageGroup == false) {
      try {
        pageGroupIndex++;
        var result = await conversationRepo.pagingConversationGroup(
            event.type, pageIndex);
        if (result.success == true &&
            result.statusCode == 200 &&
            result.data != null) {
          if (result.data!.isEmpty) {
            endPageGroup = true;
            emit(LostPagingGroupState());
            return;
          }
          result.data?.forEach((element) {
            modelGroup.add(element);
          });

          emit(PagingConversationGroupSuccessState(data: modelGroup));
          return;
        }
        emit(PagingConversationGroupFailState());
      } catch (ex) {
        emit(PagingConversationGroupFailState());
      }
    }
  }

  Future<void> _createConversation(
      CreateConversationEvent event, Emitter<ChatState> emit) async {
    try {
      var result = await conversationRepo.createConversation(event.userId);
      if (result.success == true &&
          result.statusCode == 200 &&
          result.data != null) {
        return;
      }
    } catch (ex) {}
  }

  Future<void> _showDialogDeleteConversation(
      ShowDialogDeleteConversation event, Emitter<ChatState> emit) async {
    return showCupertinoDialog(
        context: event.context,
        barrierDismissible: true,
        builder: (context) => const AlertDialog(
            contentPadding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            shadowColor: Colors.white,
            content: WidgetDialogDeleteConservation()));
  }

  Future<void> _showDialogJoinChannel(
      ShowDialogJoinChannelEvent event, Emitter<ChatState> emit) async {
    return showCupertinoDialog(
        context: event.context,
        barrierDismissible: true,
        builder: (context) => const AlertDialog(
            contentPadding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            shadowColor: Colors.white,
            content: WidgetDialogJoinChannel()));
  }
}
