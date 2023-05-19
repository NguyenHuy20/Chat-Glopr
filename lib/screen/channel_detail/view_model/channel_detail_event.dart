part of 'channel_detail_bloc.dart';

abstract class ChannelDetailEvent extends Equatable {
  const ChannelDetailEvent();
  @override
  List<Object> get props => [];
}

class GetListMessageEvent extends ChannelDetailEvent {
  final String converId;
  const GetListMessageEvent({required this.converId});
  @override
  List<Object> get props => [];
}

class SendMessageEvent extends ChannelDetailEvent {
  final String content;
  final String desId;
  final String fullName;
  final String avatar;
  const SendMessageEvent(
      {required this.content,
      required this.desId,
      required this.avatar,
      required this.fullName});
  @override
  List<Object> get props => [];
}

class ShowDialogGroupSettingEvent extends ChannelDetailEvent {
  final BuildContext context;
  final ConversationGroupData data;
  const ShowDialogGroupSettingEvent(
      {required this.context, required this.data});
  @override
  List<Object> get props => [];
}

class ReciveMessageEvent extends ChannelDetailEvent {
  final dynamic data;
  const ReciveMessageEvent({required this.data});
  @override
  List<Object> get props => [];
}

class PagingListMessageChannelEvent extends ChannelDetailEvent {
  final String converId;
  const PagingListMessageChannelEvent({required this.converId});
  @override
  List<Object> get props => [];
}

class GetMemberConversationEvent extends ChannelDetailEvent {
  final String converId;
  const GetMemberConversationEvent({required this.converId});
  @override
  List<Object> get props => [];
}

class ShowDialogAddMemberEvent extends ChannelDetailEvent {
  final String conversationId;

  final BuildContext context;
  const ShowDialogAddMemberEvent({
    required this.conversationId,
    required this.context,
  });
  @override
  List<Object> get props => [];
}

class LeaveChannelEvent extends ChannelDetailEvent {
  final BuildContext context;
  final String conversationId;
  const LeaveChannelEvent(
      {required this.conversationId, required this.context});
  @override
  List<Object> get props => [];
}

class AddUserEvent extends ChannelDetailEvent {
  final BuildContext context;
  final String userName;
  final String converId;
  const AddUserEvent(
      {required this.context, required this.converId, required this.userName});
  @override
  List<Object> get props => [];
}
