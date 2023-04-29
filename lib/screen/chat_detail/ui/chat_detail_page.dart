import 'package:chat_glopr/@core/network_model/result_get_conversation_model.dart';
import 'package:chat_glopr/screen/chat_detail/ui/chat_detail_screen.dart';
import 'package:chat_glopr/screen/chat_detail/view_model/chat_detail_bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailPage extends StatelessWidget {
  const ChatDetailPage({super.key, required this.data});
  final ConversationData data;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatDetailBloc(),
      child: ChatDetailScreen(
        data: data,
      ),
    );
  }
}
