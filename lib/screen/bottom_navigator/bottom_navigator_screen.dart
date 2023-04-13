import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:chat_glopr/@share/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
        pageController: _pageController,
        color: Colors.white,
        showLabel: true,
        notchColor: pink,
        bottomBarItems: [
          BottomBarItem(
            inActiveItem: Image.asset('assets/icons/chat_black.webp'),
            activeItem: Image.asset('assets/icons/chat_white.webp'),
            itemLabel: 'Chat',
          ),
          BottomBarItem(
            inActiveItem: Image.asset('assets/icons/phone_black.webp'),
            activeItem: Image.asset('assets/icons/phone_white.webp'),
            itemLabel: 'Calls',
          ),
          BottomBarItem(
            inActiveItem: Image.asset('assets/icons/setting_black.webp'),
            activeItem: Image.asset('assets/icons/setting_white.webp'),
            itemLabel: 'Setting',
          ),
        ],
        onTap: (index) {
          /// control your animation using page controller
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeIn,
          );
        },
      ),
    );
  }
}
