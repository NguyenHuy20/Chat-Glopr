part of 'friend_request_bloc.dart';

abstract class FriendRequestEvent extends Equatable {
  const FriendRequestEvent();

  @override
  List<Object> get props => [];
}

class GetListFriendRequestEvent extends FriendRequestEvent {
  @override
  List<Object> get props => [];
}

class AcceptFriendRequestEvent extends FriendRequestEvent {
  final String userId;
  final BuildContext context;
  const AcceptFriendRequestEvent({required this.userId, required this.context});
  @override
  List<Object> get props => [];
}

class DeleteFriendRequestEvent extends FriendRequestEvent {
  final String userId;
  final BuildContext context;

  const DeleteFriendRequestEvent({required this.userId, required this.context});
  @override
  List<Object> get props => [];
}

class GetMyRequestEvent extends FriendRequestEvent {
  @override
  List<Object> get props => [];
}
