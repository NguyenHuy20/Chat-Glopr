import 'package:chat_glopr/screen/setting/ui/setting_screen.dart';
import 'package:chat_glopr/screen/setting/view_model/setting_bloc.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingBloc(),
      child: const SettingScreen(),
    );
  }
}
