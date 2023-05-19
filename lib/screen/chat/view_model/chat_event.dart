part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class GetConversationEvent extends ChatEvent {
  final int type;
  const GetConversationEvent({required this.type});
  @override
  List<Object> get props => [];
}

class GetConversationGroupEvent extends ChatEvent {
  final int type;
  const GetConversationGroupEvent({required this.type});
  @override
  List<Object> get props => [];
}

class PagingConversationEvent extends ChatEvent {
  final int type;
  const PagingConversationEvent({required this.type});
  @override
  List<Object> get props => [];
}

class PagingConversationGroupEvent extends ChatEvent {
  final int type;
  const PagingConversationGroupEvent({required this.type});
  @override
  List<Object> get props => [];
}

class CreatePerConversationEvent extends ChatEvent {
  final String userId;
  const CreatePerConversationEvent({required this.userId});
  @override
  List<Object> get props => [];
}

class ShowDialogDeleteConversation extends ChatEvent {
  final BuildContext context;
  final String converId;
  const ShowDialogDeleteConversation(
      {required this.context, required this.converId});
  @override
  List<Object> get props => [];
}

class ShowDialogJoinChannelEvent extends ChatEvent {
  final BuildContext context;
  final String userId;
  const ShowDialogJoinChannelEvent(
      {required this.context, required this.userId});
  @override
  List<Object> get props => [];
}
