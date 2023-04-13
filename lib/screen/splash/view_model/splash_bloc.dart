import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../@core/dependence_injection.dart';
import '../../../@share/base.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashInitialEvent>(_onSplashInitialEvent);
  }

  Future<void> _onSplashInitialEvent(
      SplashInitialEvent event, Emitter<SplashState> emit) async {
    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // await saveAppVersion(packageInfo.version);
    emit(const GeneralSettingsSuccessState());
  }
}
