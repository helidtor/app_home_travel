import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';

class RoundGradientButton extends StatelessWidget {
  final String title;
  final double? width;
  final double? height;
  final double? textSize;
  final double? circular;
  final VoidCallback? onPressed;

  const RoundGradientButton(
      {Key? key,
      required this.title,
      required this.onPressed,
      this.width,
      this.height,
      this.textSize,
      this.circular})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: AppColors.primaryG,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight),
            borderRadius: BorderRadius.circular(circular ?? 25),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26, blurRadius: 2, offset: Offset(0, 2))
            ]),
        child: MaterialButton(
          minWidth: width ?? double.maxFinite,
          height: height ?? 50,
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(circular ?? 25)),
          textColor: AppColors.primaryColor1,
          child: Text(
            title,
            style: TextStyle(
              fontSize: textSize ?? 16,
              color: AppColors.whiteColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
