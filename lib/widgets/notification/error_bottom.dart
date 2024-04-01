import 'package:flutter/material.dart';

void showError(BuildContext context, String errorMessage) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(errorMessage),
      duration: const Duration(seconds: 2),
    ),
  );
}
