import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';

void showError(BuildContext context, String errorMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: const Color.fromARGB(255, 164, 29, 19),
      content: Text(
        errorMessage,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}
