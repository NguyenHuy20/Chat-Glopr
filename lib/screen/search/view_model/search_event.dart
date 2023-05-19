part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class GetListFriend extends SearchEvent {
  final BuildContext context;
  const GetListFriend({required this.context});
  @override
  List<Object> get props => [];
}

class SearchUserEvent extends SearchEvent {
  final String key;
  const SearchUserEvent({required this.key});
  @override
  List<Object> get props => [];
}

class GetDetailUserEvent extends SearchEvent {
  final String key;
  final BuildContext context;
  const GetDetailUserEvent({required this.key, required this.context});
  @override
  List<Object> get props => [];
}
