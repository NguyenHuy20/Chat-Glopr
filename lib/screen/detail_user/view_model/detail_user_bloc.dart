import 'package:chat_glopr/@core/dependence_injection.dart';
import 'package:chat_glopr/@core/network/repository/conversation_repo.dart';
import 'package:chat_glopr/@core/network/repository/friend_repo.dart';
import 'package:chat_glopr/@share/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../@share/widgets/flushbar_custom.dart';
import '../../chat_detail/ui/chat_detail_page.dart';

part 'detail_user_event.dart';
part 'detail_user_state.dart';

class DetailUserBloc extends Bloc<DetailUserEvent, DetailUserState> {
  DetailUserBloc() : super(DetailUserInitial()) {
    on<AddFriendEvent>(_addFriend);
    on<CreateConversationEvent>(_createConversation);
  }
  FriendRepo friendRepo = inject<FriendRepo>();
  ConversationRepo conversationRepo = inject<ConversationRepo>();
  Future<void> _addFriend(
      AddFriendEvent event, Emitter<DetailUserState> emit) async {
    try {
      showLoading(event.context, true);
      var result = await friendRepo.sendFriendRequest(event.userId);
      showLoading(event.context, false);
      if (result.success == true) {
        showFlushBar(event.context,
            msg: result.message ?? '', status: FLUSHBAR_SUCCESS);
        return;
      }
      showFlushBar(event.context,
          msg: result.message ?? '', status: FLUSHBAR_ERROR);
    } catch (ex) {}
  }

  Future<void> _createConversation(
      CreateConversationEvent event, Emitter<DetailUserState> emit) async {
    try {
      showLoading(event.context, true);
      var result = await conversationRepo.createPerConversation(event.userId);
      if (result.success == true && result.data != null) {
        var resultGetConver =
            await conversationRepo.getOneConversation(result.data?.id ?? '');
        showLoading(event.context, false);

        if (resultGetConver.success == true && resultGetConver.data != null) {
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
            msg: resultGetConver.message ?? '', status: FLUSHBAR_ERROR);
        return;
      }
      showLoading(event.context, false);

      showFlushBar(event.context,
          msg: result.message ?? '', status: FLUSHBAR_ERROR);
    } catch (ex) {}
  }
}
