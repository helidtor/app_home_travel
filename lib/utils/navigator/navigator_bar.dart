// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:mobile_home_travel/screens/autocomplete_map/autocomplete_map.dart';
import 'package:mobile_home_travel/screens/chat/ui/chat_screen.dart';
import 'package:mobile_home_travel/screens/history_booking/ui/history_screen.dart';
import 'package:mobile_home_travel/screens/home/home_screen.dart';
import 'package:mobile_home_travel/screens/settings/settings_screen.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';

class NavigatorBar extends StatefulWidget {
  final int? stt;
  const NavigatorBar({
    super.key,
    this.stt,
  });

  @override
  State<NavigatorBar> createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  late int sttPage;
  late Widget body;

  @override
  void initState() {
    super.initState();
    sttPage = widget.stt ?? 0;
    body = _screenDisplay(sttPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: body,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 300),
        index: sttPage,
        onTap: (value) async {
          setState(() {
            sttPage = value;
            body = _screenDisplay(sttPage);
          });
        },
        height: 52,
        gradient: AppColors.myGradient,
        // backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        buttonBackgroundColor: const Color.fromARGB(255, 136, 78, 207),
        items: const [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.search, color: Colors.white),
          Icon(Icons.chat, color: Colors.white),
          Icon(FontAwesomeIcons.bagShopping, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
        ],
      ),
    );
  }

  Widget _screenDisplay(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return AutocompleteMap(
          isHaveBtnClose: false,
        );
      case 2:
        return const ChatScreen();
      case 3:
        return const HistoryScreen();
      case 4:
        return const SettingsScreen();
      default:
        return const HomePage();
    }
  }
}
