import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';

class NavigationBarWidget extends StatelessWidget {
  const NavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      height: 60,
      gradient: AppColors.myGradient,
      backgroundColor: Colors.white,
      buttonBackgroundColor: const Color.fromARGB(235, 136, 78, 207),
      items: const [
        Icon(Icons.home, color: Colors.white),
        Icon(Icons.chat, color: Colors.white),
        Icon(Icons.payment, color: Colors.white),
        Icon(Icons.history, color: Colors.white),
        Icon(Icons.settings, color: Colors.white),
      ],
    );
  }
}
