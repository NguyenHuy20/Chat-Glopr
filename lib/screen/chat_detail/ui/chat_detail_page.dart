import 'package:chat_glopr/screen/chat_detail/ui/chat_detail_screen.dart';
import 'package:chat_glopr/screen/chat_detail/view_model/chat_detail_bloc.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailPage extends StatelessWidget {
  const ChatDetailPage(
      {super.key,
      required this.name,
      required this.avatar,
      required this.id,
      required this.isOnline});
  final String name;
  final String avatar;
  final String id;
  final bool isOnline;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatDetailBloc(),
      child: ChatDetailScreen(
        name: name,
        id: id,
        avatar: avatar,
        isOnline: isOnline,
      ),
    );
  }
}
