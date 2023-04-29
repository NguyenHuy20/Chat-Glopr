import 'package:chat_glopr/screen/channel_detail/ui/channel_detail_screen.dart';
import 'package:chat_glopr/screen/channel_detail/view_model/channel_detail_bloc.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../@core/network_model/result_get_conversation_group_model.dart';

class ChannelDetailPage extends StatelessWidget {
  const ChannelDetailPage({super.key, required this.data});
  final ConversationGroupData data;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChannelDetailBloc(),
      child: ChannelDetailScreen(
        data: data,
      ),
    );
  }
}
