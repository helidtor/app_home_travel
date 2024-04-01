import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';

void showError(BuildContext context, String errorMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        errorMessage,
        style: TextStyle(
            fontFamily: GoogleFonts.nunito().fontFamily,
            color: Colors.white,
            fontSize: 15),
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}
