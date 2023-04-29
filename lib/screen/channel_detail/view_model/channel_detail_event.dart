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
  const SendMessageEvent({required this.content, required this.desId});
  @override
  List<Object> get props => [];
}

class ShowDialogGroupSettingEvent extends ChannelDetailEvent {
  final BuildContext context;
  const ShowDialogGroupSettingEvent({required this.context});
  @override
  List<Object> get props => [];
}

class ReciveMessageEvent extends ChannelDetailEvent {
  final dynamic data;
  const ReciveMessageEvent({required this.data});
  @override
  List<Object> get props => [];
}
