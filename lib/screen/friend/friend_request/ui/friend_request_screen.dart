import 'dart:async';

import 'package:chat_glopr/@core/network_model/result_list_friend_mode.dart';
import 'package:chat_glopr/@share/utils/utils.dart';
import 'package:chat_glopr/@share/values/shadow.dart';
import 'package:chat_glopr/@share/values/styles.dart';
import 'package:chat_glopr/screen/friend/friend_request/view_model/friend_request_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../@share/values/colors.dart';

class FriendRequest extends StatefulWidget {
  const FriendRequest({super.key});

  @override
  State<FriendRequest> createState() => _FriendRequestState();
}

class _FriendRequestState extends State<FriendRequest> {
  late FriendRequestBloc friendRequestBloc;
  late StreamController<List<FriendData>> friendReqController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    friendRequestBloc = BlocProvider.of<FriendRequestBloc>(context);
    friendRequestBloc.add(GetListFriendRequestEvent());
    friendReqController = StreamController<List<FriendData>>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FriendRequestBloc, FriendRequestState>(
      listener: (context, state) {
        if (state is GetListFriendRequestSuccessState) {
          friendReqController.add(state.data);
          return;
        }
        if (state is AcceptRequestSuccessState) {
          friendReqController.add(state.data);
          return;
        }
        if (state is DeleteRequestSuccessState) {
          friendReqController.add(state.data);
          return;
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.grey.shade200, Colors.white],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 0.1),
                stops: const [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(children: [
              Expanded(
                child: StreamBuilder<List<FriendData>>(
                    stream: friendReqController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data!.isNotEmpty
                            ? RefreshIndicator(
                                color: pink,
                                onRefresh: () async {
                                  return;
                                },
                                child: ListView.builder(
                                    controller: _scrollController,
                                    padding: EdgeInsets.zero,
                                    physics: const ClampingScrollPhysics(),
                                    itemCount: snapshot.data?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      return friendRequest(
                                          snapshot.data![index]);
                                    }))
                            : const Center(
                                child: Text('My Request Empty'),
                              );
                        ;
                      }
                      if (snapshot.hasError) {
                        return Center(
                            child:
                                Image.asset('assets/images/bg_not_found.webp'));
                      }
                      return SizedBox(
                          width: double.infinity,
                          child: cupertinoLoading(color: pink));
                    }),
              )
            ]),
          ),
        ),
      ),
    );
  }

  Widget friendRequest(FriendData data) => Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: shadow3),
      width: double.infinity,
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
            width: 5,
          ),
          Expanded(
            child: Text(
              data.userName ?? '',
              style: appStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GestureDetector(
            onTap: () {
              friendRequestBloc.add(AcceptFriendRequestEvent(
                  userId: data.id ?? '', context: context));
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: pink, width: 2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check,
                color: pink,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              friendRequestBloc.add(DeleteFriendRequestEvent(
                  userId: data.id ?? '', context: context));
            },
            child: Icon(
              Icons.cancel,
              color: pink,
              size: 48,
            ),
          ),
        ],
      ));
}
