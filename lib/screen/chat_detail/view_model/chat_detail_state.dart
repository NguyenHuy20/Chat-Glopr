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
