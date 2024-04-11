import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';

class RowText {
  Widget richText(String title, String content, IconData? icon) {
    return Row(
      children: [
        (icon != null)
            ? Icon(
                icon,
                color: AppColors.primaryColor3.withOpacity(0.7),
                size: 20,
              )
            : const SizedBox(),
        const SizedBox(
          width: 2,
        ),
        Expanded(
          child: RichText(
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$title: ',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                TextSpan(
                  text: content,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
