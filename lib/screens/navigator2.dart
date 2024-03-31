import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_home_travel/screens/autocomplete_map/autocomplete_map.dart';
import 'package:mobile_home_travel/screens/home/home_screen.dart';
import 'package:mobile_home_travel/screens/settings/settings_screen.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';

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
    AutocompleteMap(
      isHaveBtnClose: false,
    ),
    const SettingsScreen(),
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
        showShadow: true,
        notchGradient: AppColors.myGradient,
        notchBottomBarController: _controller,
        color: const Color.fromARGB(255, 136, 78, 207),
        showLabel: false,
        removeMargins: false,
        bottomBarWidth: 500,
        bottomBarHeight: 50,
        durationInMilliSeconds: 300,
        bottomBarItems: [
          BottomBarItem(
            inActiveItem: Icon(
              Icons.home_filled,
              color: Colors.grey[200],
            ),
            activeItem: const Icon(
              Icons.home_filled,
              color: Colors.white,
            ),
            itemLabel: 'Trang chủ',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.chat,
              color: Colors.grey[200],
            ),
            activeItem: const Icon(
              Icons.chat,
              color: Colors.white,
            ),
            itemLabel: 'Tìm kiếm',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.payment,
              color: Colors.grey[200],
            ),
            activeItem: const Icon(
              Icons.payment,
              color: Colors.white,
            ),
            itemLabel: 'Chat',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.history,
              color: Colors.grey[200],
            ),
            activeItem: const Icon(
              Icons.history,
              color: Colors.white,
            ),
            itemLabel: 'Lịch sử',
          ),
          BottomBarItem(
            inActiveItem: Icon(
              Icons.settings,
              color: Colors.grey[200],
            ),
            activeItem: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            itemLabel: 'Cài đặt',
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
