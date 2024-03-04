import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_home_travel/screens/home/home_screen.dart';
import 'package:mobile_home_travel/screens/settings/settings_screen.dart';

class Navigator extends StatefulWidget {
  const Navigator({super.key});

  @override
  State<Navigator> createState() => _NavigatorState();
}

class _NavigatorState extends State<Navigator> {
  final _pageController = PageController(initialPage: 0);
  final _controller = NotchBottomBarController(index: 0);
  int maxCount = 5;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> bottomBarPages = [
    const HomePage(),
    const SettingsScreen(),
    const HomePage(),
    const HomePage(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _pageController,
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      bottomNavigationBar: AnimatedNotchBottomBar(
        notchBottomBarController: _controller,
        color: Colors.white,
        showLabel: false,
        notchColor: const Color.fromARGB(235, 136, 78, 207),
        removeMargins: false,
        bottomBarWidth: 500,
        durationInMilliSeconds: 400,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(
              Icons.home_filled,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.home_filled,
              color: Colors.white,
            ),
            itemLabel: 'Home',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.chat,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.chat,
              color: Colors.white,
            ),
            itemLabel: 'Chat',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.payment,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.payment,
              color: Colors.white,
            ),
            itemLabel: 'Payment',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.history,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.history,
              color: Colors.white,
            ),
            itemLabel: 'History',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.settings,
              color: Colors.blueGrey,
            ),
            activeItem: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            itemLabel: 'Settings',
          ),
        ],
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
        kIconSize: 24,
        kBottomRadius: 28,
      ),
    );
  }
}
