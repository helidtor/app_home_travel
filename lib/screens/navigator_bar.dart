// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:mobile_home_travel/screens/autocomplete_map/autocomplete_map.dart';
import 'package:mobile_home_travel/screens/home/home_screen.dart';
import 'package:mobile_home_travel/screens/settings/settings_screen.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';

class NavigatorBar extends StatefulWidget {
  final int? stt;
  const NavigatorBar({
    Key? key,
    this.stt,
  }) : super(key: key);

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
    body = (sttPage == 0) ? const HomePage() : const SettingsScreen();
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
            if (sttPage == 0) {
              body = const HomePage();
            } else if (value == 1) {
              body = AutocompleteMap(
                isHaveBtnClose: false,
              );
            } else if (value == 2) {
              body = const SettingsScreen();
            } else if (value == 3) {
              body = const HomePage();
            } else if (value == 4) {
              body = const SettingsScreen();
            }
          });
        },
        height: 52,
        gradient: AppColors.myGradient,
        // backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        buttonBackgroundColor: Color.fromARGB(255, 136, 78, 207),
        items: const [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.search, color: Colors.white),
          Icon(Icons.chat, color: Colors.white),
          Icon(Icons.history, color: Colors.white),
          Icon(Icons.settings, color: Colors.white),
        ],
      ),
    );
  }
}
