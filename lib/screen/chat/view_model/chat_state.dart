part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();
}

class ChatInitial extends ChatState {
  @override
  List<Object> get props => [];
}

class GetConversationSuccessState extends ChatState {
  final List<ConversationData> lstConservation;
  const GetConversationSuccessState({required this.lstConservation});
  @override
  List<Object> get props => [];
}

class GetConversationFailState extends ChatState {
  @override
  List<Object> get props => [];
}

class GetConversationGroupSuccessState extends ChatState {
  final List<ConversationData> lstConservation;
  const GetConversationGroupSuccessState({required this.lstConservation});
  @override
  List<Object> get props => [];
}

class GetConversationGroupFailState extends ChatState {
  @override
  List<Object> get props => [];
}

class PagingConversationSuccessState extends ChatState {
  final List<ConversationData> data;
  const PagingConversationSuccessState({required this.data});
  @override
  List<Object> get props => [identityHashCode(this), data];
}

class PagingConversationFailState extends ChatState {
  @override
  List<Object> get props => [];
}

class LostPagingState extends ChatState {
  @override
  List<Object> get props => [];
}

class PagingConversationGroupSuccessState extends ChatState {
  final List<ConversationData> data;
  const PagingConversationGroupSuccessState({required this.data});
  @override
  List<Object> get props => [identityHashCode(this), data];
}

class PagingConversationGroupFailState extends ChatState {
  @override
  List<Object> get props => [];
}

class LostPagingGroupState extends ChatState {
  @override
  List<Object> get props => [];
}
