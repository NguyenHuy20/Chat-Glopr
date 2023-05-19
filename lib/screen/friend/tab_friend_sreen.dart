import 'package:chat_glopr/@share/values/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../@share/values/colors.dart';
import 'friend_request/ui/friend_request_screen.dart';
import 'my_request/ui/my_request_screen.dart';

class FriendScreen extends StatefulWidget {
  const FriendScreen({super.key});

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int indexTabar = 0;
  @override
  void initState() {
    super.initState();

    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets paddingDevice = MediaQuery.of(context).viewPadding;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(30, paddingDevice.top + 15, 30, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios),
                  iconSize: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Friend',
                    style: titlePageStyle.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
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
                                  bottom: 3, // space between underline and text
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
                                  "Friend Request",
                                  style: indexTabar == 0
                                      ? appStyle.copyWith(color: pink)
                                      : appStyle,
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                padding: const EdgeInsets.only(
                                  bottom: 3, // space between underline and text
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
                                  "My Request",
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
                      FriendRequest(),
                      MyRequestScreen(),
                    ]))
              ],
            ),
          )
        ],
      ),
    );
  }
}
