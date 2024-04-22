import 'package:flutter/material.dart';
import 'package:mobile_home_travel/widgets/input/text_content.dart';
import 'package:toastification/toastification.dart';

class ErrorNotiProvider {
  void showError(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(255, 164, 29, 19),
        content: Text(
          errorMessage,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void ToastError(BuildContext context, String errorMessage) {
    toastification.show(
        showProgressBar: false,
        pauseOnHover: false,
        progressBarTheme: const ProgressIndicatorThemeData(
          color: Colors.red,
        ),
        icon: const Icon(
          Icons.check_circle,
          color: Colors.green,
        ),
        foregroundColor: Colors.black,
        context: context,
        type: ToastificationType.error,
        style: ToastificationStyle.flatColored,
        title: TextContent(
          contentText: errorMessage,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        autoCloseDuration: const Duration(milliseconds: 1500),
        animationDuration: const Duration(milliseconds: 500),
        alignment: Alignment.topRight);
  }
}
