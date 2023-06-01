import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../@core/dependence_injection.dart';
import '../../../@core/local_model/send_message_model.dart';
import '../../../@core/network/repository/message_repo.dart';
import '../../../@core/network_model/result_get_list_message_model.dart';

part 'chat_detail_event.dart';
part 'chat_detail_state.dart';

class ChatDetailBloc extends Bloc<ChatDetailEvent, ChatDetailState> {
  List<MessageData> messData = [];
  int pageIndex = 1;
  bool endPage = false;
  ChatDetailBloc() : super(ChatDetailInitial()) {
    on<GetListMessageEvent>(_getListMessage);
    on<SendMessageEvent>(_sendMessage);
    on<ReciveMessageEvent>(_reciveMessage);
    on<PagingListMessageEvent>(_pagingListMessage);
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

  Future<void> _pagingListMessage(
      PagingListMessageEvent event, Emitter<ChatDetailState> emit) async {
    if (endPage == false) {
      try {
        pageIndex++;
        var result =
            await messageRepo.pagingListMessage(event.converId, pageIndex);

        if (result.success == true &&
            result.statusCode == 200 &&
            result.data != null) {
          if (result.data!.isEmpty) {
            endPage = true;
            emit(LostPagingMessageState());
            return;
          }
          result.data?.forEach((element) {
            messData.add(element);
          });

          emit(PagingMessageSuccessState(data: messData));
          return;
        }
        emit(PagingMessageFailState());
      } catch (ex) {
        emit(PagingMessageFailState());
      }
    }
  }

  Future<void> _sendMessage(
      SendMessageEvent event, Emitter<ChatDetailState> emit) async {
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
    } catch (ex) {
      print(ex);
    }
  }

  Future<void> _reciveMessage(
      ReciveMessageEvent event, Emitter<ChatDetailState> emit) async {
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
