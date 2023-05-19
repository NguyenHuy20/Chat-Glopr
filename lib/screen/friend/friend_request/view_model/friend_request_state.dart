part of 'friend_request_bloc.dart';

abstract class FriendRequestState extends Equatable {
  const FriendRequestState();
}

class FriendRequestInitial extends FriendRequestState {
  @override
  List<Object> get props => [];
}

class GetListFriendRequestSuccessState extends FriendRequestState {
  final List<FriendData> data;
  const GetListFriendRequestSuccessState({required this.data});
  @override
  List<Object> get props => [identityHashCode(this), data];
}

class GetListFriendRequestFailState extends FriendRequestState {
  @override
  List<Object> get props => [];
}

class AcceptRequestSuccessState extends FriendRequestState {
  final List<FriendData> data;
  const AcceptRequestSuccessState({required this.data});
  @override
  List<Object> get props => [];
}

class DeleteRequestSuccessState extends FriendRequestState {
  final List<FriendData> data;
  const DeleteRequestSuccessState({required this.data});
  @override
  List<Object> get props => [];
}

class GetListMyRequestSuccessState extends FriendRequestState {
  final List<FriendData> data;
  const GetListMyRequestSuccessState({required this.data});
  @override
  List<Object> get props => [identityHashCode(this), data];
}

class GetListMyRequestFailState extends FriendRequestState {
  @override
  List<Object> get props => [];
}
