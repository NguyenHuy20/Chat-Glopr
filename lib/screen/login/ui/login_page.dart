import 'package:chat_glopr/screen/login/ui/login_screen.dart';
import 'package:chat_glopr/screen/login/view_model/login_bloc.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: const LoginScreen(),
    );
  }
}
