import 'package:chat_glopr/@core/local_model/create_group_conver_model.dart';
import 'package:chat_glopr/@core/network/repository/conversation_repo.dart';
import 'package:chat_glopr/@core/network_model/result_get_conversation_group_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../@core/dependence_injection.dart';
import '../../../@core/network_model/result_get_conversation_model.dart';
import '../../../@share/base.dart';
import '../../../@share/utils/utils.dart';
import '../../../@share/widgets/flushbar_custom.dart';
import '../../channel_detail/ui/widget_dialog_delete_conversation.dart';
import '../../channel_detail/ui/widget_dialog_join_channel.dart';
import '../../chat_detail/ui/chat_detail_page.dart';

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
    on<CreatePerConversationEvent>(_createPerConversation);
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
        model = result.data!;
        emit(GetConversationSuccessState(lstConservation: model));
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
        modelGroup = result.data!;
        emit(GetConversationGroupSuccessState(lstConservation: modelGroup));
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
            event.type, pageGroupIndex);
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

  Future<void> _createPerConversation(
      CreatePerConversationEvent event, Emitter<ChatState> emit) async {
    try {
      var result = await conversationRepo.createPerConversation(event.userId);
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
        builder: (context) => AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            shadowColor: Colors.white,
            content: WidgetDialogDeleteConservation(onTap: () async {
              try {
                showLoading(context, true);
                var result =
                    await conversationRepo.deleteConversation(event.converId);
                showLoading(context, false);
                if (result.success == true) {
                  Navigator.pop(context);

                  for (var element in model) {
                    if (element.id == event.converId) {
                      model.remove(element);

                      return;
                    }
                  }
                }

                showFlushBar(event.context,
                    msg: result.message ?? '', status: FLUSHBAR_ERROR);
              } catch (ex) {
                print(ex);
              }
            })));
  }

  Future<void> _showDialogJoinChannel(
      ShowDialogJoinChannelEvent event, Emitter<ChatState> emit) async {
    return showCupertinoDialog(
        context: event.context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            shadowColor: Colors.white,
            content: WidgetDialogJoinChannel(
              onTap: (e) async {
                if (e == '') {
                  showFlushBar(event.context,
                      msg: 'Name Field Empty', status: FLUSHBAR_ERROR);
                  return;
                }
                List<String> lstUserId = [event.userId];
                try {
                  showLoading(context, true);
                  var result = await conversationRepo.createGroupConversation(
                      CreateGroupConverModel(name: e, userIds: lstUserId));
                  if (result.success == true) {
                    var resultGetConver = await conversationRepo
                        .getOneConversation(result.data?.conversationId ?? '');
                    showLoading(event.context, false);
                    Navigator.pop(event.context);
                    if (resultGetConver.success == true &&
                        resultGetConver.data != null) {
                      goToScreen(
                          event.context,
                          ChatDetailPage(
                            name: resultGetConver.data?.name ?? '',
                            id: resultGetConver.data?.id ?? '',
                            avatar: resultGetConver.data?.avatar ?? '',
                            isOnline: resultGetConver.data?.isOnline ?? false,
                          ));
                      return;
                    }
                    showFlushBar(event.context,
                        msg: resultGetConver.message ?? '',
                        status: FLUSHBAR_ERROR);
                    return;
                  }
                  showLoading(context, false);
                  showFlushBar(event.context,
                      msg: result.message ?? '', status: FLUSHBAR_ERROR);
                } catch (ex) {
                  showFlushBar(event.context,
                      msg: 'ERROR', status: FLUSHBAR_ERROR);
                }
              },
            )));
  }
}
