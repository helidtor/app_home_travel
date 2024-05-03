import 'package:flutter/material.dart';
import 'package:mobile_home_travel/widgets/input/text_content.dart';
import 'package:toastification/toastification.dart';

class SuccessNotiProvider {
  void showSuccess(BuildContext context, String successMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(255, 38, 150, 41),
        content: Text(
          successMessage,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void ToastSuccess(BuildContext context, String successMessage) {
    toastification.show(
        showProgressBar: false,
        pauseOnHover: false,
        progressBarTheme: const ProgressIndicatorThemeData(
          color: Colors.green,
        ),
        icon: const Icon(
          Icons.check_circle,
          color: Colors.green,
        ),
        foregroundColor: Colors.black,
        context: context,
        type: ToastificationType.success,
        style: ToastificationStyle.flatColored,
        title: TextContent(
          contentText: successMessage,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        autoCloseDuration: const Duration(milliseconds: 2000),
        animationDuration: const Duration(milliseconds: 500),
        alignment: Alignment.topRight);
  }
}
