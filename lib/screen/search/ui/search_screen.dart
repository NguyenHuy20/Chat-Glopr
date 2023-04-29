import 'dart:async';

import 'package:chat_glopr/@core/network_model/result_list_friend_mode.dart';
import 'package:chat_glopr/@share/utils/utils.dart';
import 'package:chat_glopr/@share/widgets/text_field_custom.dart';
import 'package:chat_glopr/screen/search/view_model/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../@share/values/colors.dart';
import '../../../@share/values/styles.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchBloc searchBloc;
  late StreamController<List<FriendData>> friendController;
  @override
  void initState() {
    super.initState();

    searchBloc = BlocProvider.of<SearchBloc>(context)
      ..add(GetListFriend(context: context));
    friendController = StreamController<List<FriendData>>();
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets paddingDevice = MediaQuery.of(context).viewPadding;

    return BlocListener<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is GetListFriendSuccessState) {
          friendController.add(state.lstFriend);
          return;
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(30, paddingDevice.top + 15, 30, 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios),
                    iconSize: 20,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: SizedBox(
                          height: 50,
                          child: textSearchFieldCustom(
                              prefixIcon: const Icon(Icons.search))))
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.grey.shade200, Colors.white],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(0.0, 0.1),
                      stops: const [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Friend',
                          style: appStyle.copyWith(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: StreamBuilder<List<FriendData>>(
                              stream: friendController.stream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data!.isNotEmpty) {
                                    return ListView.builder(
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) {
                                          return friendBox(
                                              snapshot.data![index]);
                                        });
                                  }
                                }
                                if (snapshot.data != null &&
                                    snapshot.data!.isEmpty) {
                                  return Center(
                                    child: Text(
                                      'Not have friennd',
                                      style: appStyle,
                                    ),
                                  );
                                }
                                return Center(
                                  child: cupertinoLoading(color: pink),
                                );
                              }),
                        )
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget friendBox(FriendData data) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              width: 53,
              height: 53,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(data.avatar ?? ''),
                  onError: (_, e) {
                    print("get img err");
                  },
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              data.userName ?? '',
              style: appStyle,
            )
          ],
        ),
      );
}
