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
