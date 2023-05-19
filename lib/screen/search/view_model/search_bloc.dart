import 'package:chat_glopr/@core/network/repository/friend_repo.dart';
import 'package:chat_glopr/@core/network/repository/user_repo.dart';
import 'package:chat_glopr/@core/network_model/result_list_friend_mode.dart';
import 'package:chat_glopr/@share/utils/utils.dart';
import 'package:chat_glopr/screen/detail_user/ui/detail_user_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../@core/dependence_injection.dart';
import '../../../@core/network_model/result_search_user_model.dart';
import '../../../@share/widgets/flushbar_custom.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<GetListFriend>(_getListFriend);
    on<SearchUserEvent>(_searchUser);
    on<GetDetailUserEvent>(_getDeatilUser);
  }
  FriendRepo friendRepo = inject<FriendRepo>();
  UserRepo userRepo = inject<UserRepo>();
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

  Future<void> _searchUser(
      SearchUserEvent event, Emitter<SearchState> emit) async {
    try {
      var result = await userRepo.searchUser(event.key);
      if (result.data != null && result.success == true) {
        emit(SearchSuccessState(data: result.data!));
        return;
      }
      emit(SearchFailState());
    } catch (e) {
      emit(SearchFailState());
    }
  }

  Future<void> _getDeatilUser(
      GetDetailUserEvent event, Emitter<SearchState> emit) async {
    try {
      showLoading(event.context, true);
      var result = await userRepo.getDetailUserInfo(event.key);
      showLoading(event.context, false);

      if (result.data != null && result.success == true) {
        goToScreen(event.context, DetailUserScreen(data: result.data!),
            type: ToScreenType.nomal);
        return;
      }
      showFlushBar(event.context,
          msg: result.message ?? '', status: FLUSHBAR_ERROR);
    } catch (e) {
      showFlushBar(event.context, msg: 'Hãy thử lại', status: FLUSHBAR_ERROR);
    }
  }
}
