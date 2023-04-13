import 'package:badges/badges.dart';
import 'package:chat_glopr/@share/values/shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:badges/src/badge.dart' as badge;

import '../../../@share/applicationmodel/profile/profile_bloc.dart';
import '../../../@share/values/colors.dart';
import '../../../@share/values/styles.dart';
import 'channel/channel_page.dart';
import 'chat/chat_page.dart';

class TabChatChannelScreen extends StatefulWidget {
  const TabChatChannelScreen({super.key});

  @override
  State<TabChatChannelScreen> createState() => _TabChatChannelScreenState();
}

class _TabChatChannelScreenState extends State<TabChatChannelScreen>
    with SingleTickerProviderStateMixin {
  late ProfileBloc profileBloc;
  late TabController _tabController;
  int indexTabar = 0;
  @override
  void initState() {
    profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(const GetDataProfile());
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets paddingDevice = MediaQuery.of(context).padding;
    return BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSuccessState) {}
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Padding(
                    padding:
                        EdgeInsets.fromLTRB(30, paddingDevice.top + 10, 30, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            profileBloc.profileDataModel?.avatar != null
                                ? badge.Badge(
                                    animationDuration:
                                        const Duration(milliseconds: 0),
                                    badgeColor: const Color(0xff29B113),
                                    position: BadgePosition.bottomEnd(
                                        bottom: 1, end: 1),
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 8, 8, 6),
                                    toAnimate: true,
                                    animationType: BadgeAnimationType.slide,
                                    child: Container(
                                      width: 53,
                                      height: 53,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: NetworkImage(profileBloc
                                                  .profileDataModel?.avatar ??
                                              ''),
                                          onError: (_, e) {
                                            print("get img err");
                                          },
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                : badge.Badge(
                                    animationDuration:
                                        const Duration(milliseconds: 0),
                                    badgeColor: const Color(0xff29B113),
                                    position: BadgePosition.bottomEnd(
                                        bottom: 2, end: 4),
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 6, 5, 5),
                                    toAnimate: true,
                                    animationType: BadgeAnimationType.slide,
                                    child: Container(
                                      width: 53,
                                      height: 53,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey),
                                      child: const Icon(Icons.image),
                                    ),
                                  ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              profileBloc.profileDataModel?.fullName ?? '',
                              style: appStyle.copyWith(
                                  fontWeight: FontWeight.w700, fontSize: 20),
                            )
                          ],
                        ),
                        const Icon(
                          Icons.search,
                          size: 25,
                        ),
                      ],
                    )),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 100, right: 100),
                        child: PreferredSize(
                          preferredSize: const Size.fromHeight(30.0),
                          child: Container(
                            color: Colors.white,
                            child: TabBar(
                                controller: _tabController,
                                onTap: (value) {
                                  setState(() {
                                    indexTabar = value;
                                  });
                                },
                                tabs: [
                                  Tab(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                        bottom:
                                            3, // space between underline and text
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                        color: indexTabar == 0
                                            ? pink
                                            : Colors.white, // Text colour here
                                        width: 1.0, // Underline width
                                      ))),
                                      child: Text(
                                        "Chat",
                                        style: indexTabar == 0
                                            ? appStyle.copyWith(color: pink)
                                            : appStyle,
                                      ),
                                    ),
                                  ),
                                  Tab(
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                        bottom:
                                            3, // space between underline and text
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                        color: indexTabar != 0
                                            ? pink
                                            : Colors.white, // Text colour here
                                        width: 1.0, // Underline width
                                      ))),
                                      child: Text(
                                        "Channel",
                                        style: indexTabar != 0
                                            ? appStyle.copyWith(color: pink)
                                            : appStyle,
                                      ),
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                      Flexible(
                          child: TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: _tabController,
                              children: const <Widget>[
                            ChatPage(),
                            ChannelPage(),
                          ]))
                    ],
                  ),
                )
              ],
            )));
  }
}
