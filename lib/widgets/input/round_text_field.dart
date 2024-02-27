import 'package:flutter/material.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';

class RoundTextField extends StatefulWidget {
  final TextEditingController? textEditingController;
  final String hintText;
  final String icon;
  final TextInputType textInputType;
  final bool isObscureText;
  final Widget? rightIcon;
  final String? errorText; // Thêm thuộc tính errorText
  final Function()? onTap;
  final Function? onChangeText;

  const RoundTextField({
    Key? key,
    this.textEditingController,
    required this.hintText,
    required this.icon,
    required this.textInputType,
    this.isObscureText = false,
    this.rightIcon,
    this.errorText,
    this.onTap,
    this.onChangeText,
  }) : super(key: key);

  @override
  State<RoundTextField> createState() => _RoundTextFieldState();
}

class _RoundTextFieldState extends State<RoundTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.lightGrayColor,
          borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        controller: widget.textEditingController,
        keyboardType: widget.textInputType,
        obscureText: widget.isObscureText,
        onTap: widget.onTap,
        decoration: InputDecoration(
            errorText: widget.errorText,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: widget.hintText,
            prefixIcon: Container(
                alignment: Alignment.center,
                width: 20,
                height: 20,
                child: Image.asset(
                  widget.icon,
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                  color: AppColors.grayColor,
                )),
            suffixIcon: widget.rightIcon,
            hintStyle:
                const TextStyle(fontSize: 12, color: AppColors.grayColor)),
        onChanged: (text) {
          widget.onChangeText!(text);
        },
      ),
    );
  }
}
