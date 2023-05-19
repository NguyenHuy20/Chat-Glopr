part of 'detail_user_bloc.dart';

abstract class DetailUserEvent extends Equatable {
  const DetailUserEvent();

  @override
  List<Object> get props => [];
}

class AddFriendEvent extends DetailUserEvent {
  final String userId;
  final BuildContext context;
  const AddFriendEvent({required this.userId, required this.context});
  @override
  List<Object> get props => [];
}

class CreateConversationEvent extends DetailUserEvent {
  final String userId;
  final BuildContext context;
  const CreateConversationEvent({required this.userId, required this.context});
  @override
  List<Object> get props => [];
}
