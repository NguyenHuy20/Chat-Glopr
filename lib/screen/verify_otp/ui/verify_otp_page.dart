import 'package:chat_glopr/screen/verify_otp/ui/verify_otp_screen.dart';
import 'package:chat_glopr/screen/verify_otp/view_model/verify_otp_bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../@core/local_model/register_model.dart';

class VerifyOTPPage extends StatelessWidget {
  const VerifyOTPPage({super.key, required this.model});
  final RegisterModel model;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VerifyOTPBloc(),
      child: VerifyOTPScreen(
        model: model,
      ),
    );
  }
}
