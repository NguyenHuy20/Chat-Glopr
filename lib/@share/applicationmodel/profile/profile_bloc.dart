import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../@core/dependence_injection.dart';
import '../../../@core/network/repository/user_repo.dart';
import '../../../@core/network_model/result_profile_model.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileData? profileDataModel;

  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<GetDataProfile>(_fetchProfile);
    on<SplashCheckProfile>(_splashCheckProfile);
  }

  UserRepo userRepo = inject<UserRepo>();

  Future<void> _splashCheckProfile(
      SplashCheckProfile event, Emitter<ProfileState> emit) async {
    try {
      var result = await userRepo.fecthProfile();
      if (result.statusCode == 200) {
        profileDataModel = result.data ?? ProfileData();
        emit(const CheckProfileSuccessState(''));
        return;
      }
      emit(const CheckProfileErrorState());
    } catch (ex) {
      emit(const CheckProfileErrorState());
    }
  }

  Future<void> _fetchProfile(
      GetDataProfile event, Emitter<ProfileState> emit) async {
    if (profileDataModel != null) {
      emit(ProfileSuccessState(data: profileDataModel!));
      return;
    }
    var result = await userRepo.fecthProfile();
    if (result.statusCode == 200) {
      profileDataModel = result.data ?? ProfileData();

      emit(ProfileSuccessState(data: profileDataModel!));
      return;
    }
    emit(ProfileErrorState(msg: result.message));
    return;
  }
}
