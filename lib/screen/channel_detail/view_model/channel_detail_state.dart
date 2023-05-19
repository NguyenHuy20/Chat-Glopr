part of 'channel_detail_bloc.dart';

abstract class ChannelDetailState extends Equatable {
  const ChannelDetailState();
}

class ChannelDetailInitial extends ChannelDetailState {
  @override
  List<Object> get props => [];
}

class GetListMessageSuccessState extends ChannelDetailState {
  final List<MessageData> data;
  const GetListMessageSuccessState({required this.data});
  @override
  List<Object> get props => [identityHashCode(this), data];
}

class GetListMessageFailState extends ChannelDetailState {
  @override
  List<Object> get props => [];
}

class ReciveMessageState extends ChannelDetailState {
  final List<MessageData> data;
  const ReciveMessageState({required this.data});
  @override
  List<Object> get props => [identityHashCode(this), data];
}

class PagingMessageChannelFailState extends ChannelDetailState {
  @override
  List<Object> get props => [];
}

class LostPagingMessageChannelState extends ChannelDetailState {
  @override
  List<Object> get props => [];
}

class PagingMessageChannelSuccessState extends ChannelDetailState {
  final List<MessageData> data;

  const PagingMessageChannelSuccessState({required this.data});
  @override
  List<Object> get props => [identityHashCode(this), data];
}

class ShowLoadingMessage extends ChannelDetailState {
  @override
  List<Object> get props => [];
}

class NotShowLoadingMessage extends ChannelDetailState {
  @override
  List<Object> get props => [];
}

class SendingMessageState extends ChannelDetailState {
  final List<MessageData> data;
  const SendingMessageState({required this.data});
  @override
  List<Object> get props => [];
}

class SendMessageSuccessState extends ChannelDetailState {
  final List<MessageData> data;

  const SendMessageSuccessState({required this.data});
  @override
  List<Object> get props => [];
}

class SendMessageFailState extends ChannelDetailState {
  final List<MessageData> data;
  const SendMessageFailState({required this.data});
  @override
  List<Object> get props => [];
}

class GetMemberSuccessState extends ChannelDetailState {
  final List<MemberConversationData> data;
  const GetMemberSuccessState({required this.data});
  @override
  List<Object> get props => [identityHashCode(this), data];
}

class GetMemberFailState extends ChannelDetailState {
  @override
  List<Object> get props => [];
}
