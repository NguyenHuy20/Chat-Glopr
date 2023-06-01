import 'package:chat_glopr/screen/search/view_model/search_bloc.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'search_screen.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchBloc(),
      child: const SearchScreen(),
    );
  }
}
