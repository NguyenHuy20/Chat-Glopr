import 'package:chat_glopr/@core/dependence_injection.dart';
import 'package:chat_glopr/@core/network/repository/friend_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../@core/network_model/result_list_friend_mode.dart';
import '../../../../@share/widgets/flushbar_custom.dart';

part 'friend_request_event.dart';
part 'friend_request_state.dart';

class FriendRequestBloc extends Bloc<FriendRequestEvent, FriendRequestState> {
  List<FriendData> lstFriend = [];
  FriendRequestBloc() : super(FriendRequestInitial()) {
    on<GetListFriendRequestEvent>(_getListFriendReq);
    on<AcceptFriendRequestEvent>(_acceptRequest);
    on<DeleteFriendRequestEvent>(_deleteRequest);
    on<GetMyRequestEvent>(_getMyRequest);
  }
  FriendRepo friendRepo = inject<FriendRepo>();
  Future<void> _getListFriendReq(
      GetListFriendRequestEvent event, Emitter<FriendRequestState> emit) async {
    try {
      var result = await friendRepo.getListFriendRequest();
      if (result.success == true && result.data != null) {
        lstFriend = result.data!;
        emit(GetListFriendRequestSuccessState(data: result.data!));
        return;
      }
      emit(GetListFriendRequestFailState());
    } catch (ex) {
      emit(GetListFriendRequestFailState());
    }
  }

  Future<void> _getMyRequest(
      GetMyRequestEvent event, Emitter<FriendRequestState> emit) async {
    try {
      var result = await friendRepo.getListFriendRequestSendYourself();
      if (result.success == true && result.data != null) {
        emit(GetListMyRequestSuccessState(data: result.data!));
        return;
      }
      emit(GetListMyRequestFailState());
    } catch (ex) {
      emit(GetListMyRequestFailState());
    }
  }

  Future<void> _acceptRequest(
      AcceptFriendRequestEvent event, Emitter<FriendRequestState> emit) async {
    try {
      var result = await friendRepo.acceptFriendRequest(event.userId);
      if (result.success == true) {
        for (var element in lstFriend) {
          if (element.id == event.userId) {
            lstFriend.remove(element);
            showFlushBar(event.context,
                msg: result.message ?? '', status: FLUSHBAR_SUCCESS);
            emit(AcceptRequestSuccessState(data: lstFriend));
            return;
          }
        }
      }
      showFlushBar(event.context,
          msg: result.message ?? '', status: FLUSHBAR_ERROR);
    } catch (ex) {
      showFlushBar(event.context, msg: 'ERROR', status: FLUSHBAR_ERROR);
    }
  }

  Future<void> _deleteRequest(
      DeleteFriendRequestEvent event, Emitter<FriendRequestState> emit) async {
    try {
      var result = await friendRepo.deleteFriendRequest(event.userId);
      if (result.success == true) {
        for (var element in lstFriend) {
          if (element.id == event.userId) {
            lstFriend.remove(element);
            showFlushBar(event.context,
                msg: result.message ?? '', status: FLUSHBAR_SUCCESS);
            emit(DeleteRequestSuccessState(data: lstFriend));

            return;
          }
        }
      }
      showFlushBar(event.context,
          msg: result.message ?? '', status: FLUSHBAR_ERROR);
    } catch (ex) {
      showFlushBar(event.context, msg: 'ERROR', status: FLUSHBAR_ERROR);
    }
  }
}
