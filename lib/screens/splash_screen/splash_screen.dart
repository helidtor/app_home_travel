import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Image.asset(
          'assets/images/logo-new.png',
          width: 50,
          height: 50,
        ),
      ),
    );
  }
}
