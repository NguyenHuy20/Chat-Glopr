part of 'chat_detail_bloc.dart';

abstract class ChatDetailEvent extends Equatable {
  const ChatDetailEvent();
  @override
  List<Object> get props => [];
}

class GetListMessageEvent extends ChatDetailEvent {
  final String converId;
  const GetListMessageEvent({required this.converId});
  @override
  List<Object> get props => [];
}

class SendMessageEvent extends ChatDetailEvent {
  final String content;
  final String desId;
  const SendMessageEvent({required this.content, required this.desId});
  @override
  List<Object> get props => [];
}

class ReciveMessageEvent extends ChatDetailEvent {
  final dynamic data;
  const ReciveMessageEvent({required this.data});
  @override
  List<Object> get props => [];
}
