import 'package:flutter/material.dart';
import 'package:mobile_home_travel/constants/myToken.dart';
import 'package:mobile_home_travel/routers/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> clearToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(myToken, "token");
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text(
              'Profile',
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                clearToken();
                router.go(RouteName.login);
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
