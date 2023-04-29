import 'package:chat_glopr/@share/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../@share/widgets/circle_nav_bar.dart';
import '../call/call_screen.dart';
import '../chat/ui/tab_chat_chanel_screen.dart';
import '../setting/ui/setting_screen.dart';

class BottomNavigatorScreen extends StatefulWidget {
  const BottomNavigatorScreen({super.key});

  @override
  State<BottomNavigatorScreen> createState() => _BottomNavigatorScreenState();
}

class _BottomNavigatorScreenState extends State<BottomNavigatorScreen> {
  final _pageController = PageController(initialPage: 0);
  int _tabIndex = 0;
  int get tabIndex => _tabIndex;
  set tabIndex(int v) {
    _tabIndex = v;
    setState(() {});
  }

  /// widget list
  final List<Widget> bottomBarPages = [
    const TabChatChannelScreen(),
    const CallScreen(),
    const SettingScreen(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  final List<Widget> _activeIcon = [
    Padding(
      padding: const EdgeInsets.all(15.0),
      child: Image.asset(
        'assets/icons/chat_white.webp',
        width: 20,
        height: 20,
        fit: BoxFit.scaleDown,
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(15.0),
      child: Image.asset(
        'assets/icons/phone_white.webp',
        width: 20,
        height: 20,
        fit: BoxFit.scaleDown,
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(15.0),
      child: Image.asset(
        'assets/icons/setting_white.webp',
        width: 20,
        height: 20,
        fit: BoxFit.scaleDown,
      ),
    ),
  ];

  final List<Widget> _inActiveIcon = [
    Image.asset(
      'assets/icons/chat_black.webp',
      width: 20,
      height: 20,
      fit: BoxFit.scaleDown,
    ),
    Image.asset(
      'assets/icons/phone_black.webp',
      width: 20,
      height: 20,
      fit: BoxFit.scaleDown,
    ),
    Image.asset(
      'assets/icons/setting_black.webp',
      width: 20,
      height: 20,
      fit: BoxFit.scaleDown,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (v) {
            tabIndex = v;
          },
          children: const [
            TabChatChannelScreen(),
            CallScreen(),
            SettingScreen(),
          ],
        ),
        extendBody: true,
        bottomNavigationBar: CircleNavBar(
          textActive: const ['Chat', 'History', 'Setting'],
          onTap: (index) {
            tabIndex = index;
            _pageController.jumpToPage(index);
          },
          activeIndex: _tabIndex,
          activeIcons: _activeIcon,
          inactiveIcons: _inActiveIcon,
          height: 80,
          circleWidth: 60,
          circleColor: pink,
          color: Colors.white,
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.1),
          cornerRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ));
  }
}
