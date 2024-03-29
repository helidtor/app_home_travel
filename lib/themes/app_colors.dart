import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor0 = Color.fromARGB(255, 160, 106, 225);
  static const primaryColor1 = Color.fromARGB(235, 124, 70, 191);
  static const primaryColor2 = Color.fromARGB(255, 168, 50, 165);
  static const primaryColor3 = Color.fromARGB(255, 111, 77, 202);
  static const primaryColor4 = Color.fromARGB(255, 239, 18, 18);
  static const primaryColor5 = Color.fromARGB(255, 234, 19, 101);
  static const secondaryColor1 = Color.fromARGB(235, 255, 214, 0);
  static const secondaryColor2 = Color.fromARGB(255, 81, 90, 226);

  static const backgroundApp = Color.fromARGB(255, 245, 242, 242);

  static const successColor = Color.fromARGB(255, 76, 203, 48);
  static const failColor = Color.fromARGB(255, 219, 54, 54);
  static const whiteColor = Color(0xFFFFFFFF);
  static const blackColor = Color(0xFF1D1617);
  static const grayColor = Color(0xFF7B6F72);
  static const lightGrayColor = Color(0xFFF7F8F8);
  static const midGrayColor = Color(0xFFADA4A5);

  static List<Color> get primaryG => [primaryColor1, primaryColor2];
  static List<Color> get secondaryG => [secondaryColor1, secondaryColor2];

  static Color get lightGray => const Color(0xffF7F8F8);
  static Color get black => const Color(0xff1D1617);
  static Color get gray => const Color(0xff786F72);
  static Color get white => Colors.white;
  static Gradient myGradient = const LinearGradient(
    colors: [
      Color.fromARGB(255, 111, 77, 202),
      Color.fromARGB(255, 146, 88, 218),
      Color.fromARGB(255, 168, 50, 165),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.5, 1.0],
  );
}
