import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../ui/widget_dialog_change_name.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingInitial()) {
    on<ShowDialogChangeNameEvent>(_showDialogChangeName);
  }
  Future<void> _showDialogChangeName(
      ShowDialogChangeNameEvent event, Emitter<SettingState> emit) async {
    return showCupertinoDialog(
        context: event.context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            shadowColor: Colors.white,
            content: WidgetDialogChangeName(
              fullName: event.fullName,
            )));
  }
}
