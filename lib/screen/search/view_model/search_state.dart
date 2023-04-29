part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class GetListFriendSuccessState extends SearchState {
  final List<FriendData> lstFriend;
  const GetListFriendSuccessState({required this.lstFriend});
  @override
  List<Object> get props => [];
}

class GetListFriendFailState extends SearchState {
  @override
  List<Object> get props => [];
}
