import 'package:chat_glopr/@core/network/repository/friend_repo.dart';
import 'package:chat_glopr/@core/network_model/result_list_friend_mode.dart';
import 'package:chat_glopr/@share/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../@core/dependence_injection.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<GetListFriend>(_getListFriend);
  }
  FriendRepo friendRepo = inject<FriendRepo>();
  Future<void> _getListFriend(
      GetListFriend event, Emitter<SearchState> emit) async {
    try {
      var result = await friendRepo.getListFriend();
      if (result.data != null && result.success == true) {
        emit(GetListFriendSuccessState(lstFriend: result.data!));
        return;
      }
      emit(GetListFriendFailState());
    } catch (e) {
      emit(GetListFriendFailState());
    }
  }
}
