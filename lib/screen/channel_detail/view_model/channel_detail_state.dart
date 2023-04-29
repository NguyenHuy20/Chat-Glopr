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
  List<Object> get props => [];
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
