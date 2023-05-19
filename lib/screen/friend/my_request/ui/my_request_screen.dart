import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../@core/network_model/result_list_friend_mode.dart';
import '../../../../@share/utils/utils.dart';
import '../../../../@share/values/colors.dart';
import '../../../../@share/values/shadow.dart';
import '../../../../@share/values/styles.dart';
import '../../friend_request/view_model/friend_request_bloc.dart';

class MyRequestScreen extends StatefulWidget {
  const MyRequestScreen({super.key});

  @override
  State<MyRequestScreen> createState() => _MyRequestScreenState();
}

class _MyRequestScreenState extends State<MyRequestScreen> {
  late FriendRequestBloc friendRequestBloc;
  late StreamController<List<FriendData>> myReqController;
  final ScrollController _scrollController = ScrollController();
  bool endPage = false;
  @override
  void initState() {
    friendRequestBloc = BlocProvider.of<FriendRequestBloc>(context);
    friendRequestBloc.add(GetMyRequestEvent());
    myReqController = StreamController<List<FriendData>>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FriendRequestBloc, FriendRequestState>(
        listener: (context, state) {
          if (state is GetListMyRequestSuccessState) {
            myReqController.add(state.data);
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
                      stream: myReqController.stream,
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
                                        return myRequest(snapshot.data![index]);
                                      }))
                              : const Center(
                                  child: Text('Friend Request Empty'),
                                );
                          ;
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Image.asset(
                                  'assets/images/bg_not_found.webp'));
                        }
                        return SizedBox(
                            width: double.infinity,
                            child: cupertinoLoading(color: pink));
                      }),
                )
              ]),
            ),
          ),
        ));
  }

  Widget myRequest(FriendData data) => Container(
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
        ],
      ));
}
