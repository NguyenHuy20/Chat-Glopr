part of 'chat_detail_bloc.dart';

abstract class ChatDetailState extends Equatable {
  const ChatDetailState();
}

class ChatDetailInitial extends ChatDetailState {
  @override
  List<Object> get props => [];
}

class GetListMessageSuccessState extends ChatDetailState {
  final List<MessageData> data;
  const GetListMessageSuccessState({required this.data});
  @override
  List<Object> get props => [];
}

class GetListMessageFailState extends ChatDetailState {
  @override
  List<Object> get props => [];
}

class ReciveMessageState extends ChatDetailState {
  final List<MessageData> data;
  const ReciveMessageState({required this.data});
  @override
  List<Object> get props => [identityHashCode(this), data];
}

class PagingMessageFailState extends ChatDetailState {
  @override
  List<Object> get props => [];
}

class LostPagingMessageState extends ChatDetailState {
  @override
  List<Object> get props => [];
}

class PagingMessageSuccessState extends ChatDetailState {
  final List<MessageData> data;

  const PagingMessageSuccessState({required this.data});
  @override
  List<Object> get props => [identityHashCode(this), data];
}

class SendingMessageState extends ChatDetailState {
  final List<MessageData> data;
  const SendingMessageState({required this.data});
  @override
  List<Object> get props => [];
}

class SendMessageFailState extends ChatDetailState {
  final List<MessageData> data;
  const SendMessageFailState({required this.data});
  @override
  List<Object> get props => [];
}

class SendMessageSuccessState extends ChatDetailState {
  final List<MessageData> data;

  const SendMessageSuccessState({required this.data});
  @override
  List<Object> get props => [];
}
