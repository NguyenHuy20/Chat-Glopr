import 'package:chat_glopr/@share/values/colors.dart';
import 'package:chat_glopr/@share/values/styles.dart';
import 'package:chat_glopr/screen/detail_user/view_model/detail_user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../../@core/network_model/result_detail_user_info.dart';

class DetailUserScreen extends StatefulWidget {
  const DetailUserScreen({super.key, required this.data});
  final DetailUserInfoData data;

  @override
  State<DetailUserScreen> createState() => _DetailUserScreenState();
}

class _DetailUserScreenState extends State<DetailUserScreen> {
  late DetailUserBloc detailUserBloc;
  @override
  void initState() {
    super.initState();
    detailUserBloc = BlocProvider.of<DetailUserBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets paddingDevice = MediaQuery.of(context).viewPadding;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Padding(
          padding: EdgeInsets.fromLTRB(30, paddingDevice.top + 15, 30, 15),
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
                  child: Text(
                "${widget.data.fullName}'s profile",
                style: titlePageStyle.copyWith(
                    fontSize: 18, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ))
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
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Container(
                              alignment: Alignment.center,
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(widget.data.avatar ?? ''),
                                  onError: (_, e) {
                                    print("get img err");
                                  },
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TouchableOpacity(
                                  onTap: () {
                                    detailUserBloc.add(AddFriendEvent(
                                        userId: widget.data.id ?? '',
                                        context: context));
                                  },
                                  child: Container(
                                    width: 125,
                                    height: 45,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        border:
                                            Border.all(color: pink, width: 2),
                                        color: Colors.white),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.person_add,
                                          color: pink,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Add friend',
                                          style: appStyle.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: pink),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                TouchableOpacity(
                                  onTap: () {
                                    detailUserBloc.add(CreateConversationEvent(
                                        userId: widget.data.id ?? '',
                                        context: context));
                                  },
                                  child: Container(
                                    width: 125,
                                    height: 45,
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: pink),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.message,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Message',
                                          style: appStyle.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Wrap(
                            direction: Axis.vertical,
                            spacing: 20,
                            children: [
                              Text(
                                'Full Name: ${widget.data.fullName}',
                                style: appStyle,
                              ),
                              Text(
                                'Email: ${widget.data.email}',
                                style: appStyle,
                              ),
                              Text(
                                'Phone Number: ${widget.data.phoneNumber}',
                                style: appStyle,
                              ),
                              Text(
                                'Birthday: ${widget.data.dob}',
                                style: appStyle,
                              ),
                              Text(
                                'Gender: ${widget.data.gender}',
                                style: appStyle,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Image:',
                            style: appStyle,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 65,
                            height: 65,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(widget.data.avatar ?? ''),
                                onError: (_, e) {
                                  print("get img err");
                                },
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Favorite:',
                            style: appStyle,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.favorite),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Fun things',
                                style: appStyle,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.music_note_sharp),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Play Piano',
                                style: appStyle,
                              )
                            ],
                          )
                        ]),
                  ),
                ],
              )),
        ),
      ]),
    );
  }
}
