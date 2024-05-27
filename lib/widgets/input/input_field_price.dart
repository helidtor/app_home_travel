// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/widgets/input/text_content.dart';

class InputField extends StatefulWidget {
  final String? hintText;
  final TextEditingController controller;
  final double widthInput;
  final double? heightInput;
  final String? content;
  final Function? onChangeText;
  final Color? textColor;
  const InputField({
    super.key,
    this.hintText,
    required this.controller,
    required this.widthInput,
    this.heightInput,
    this.content,
    this.onChangeText,
    this.textColor,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  static const _locale = 'vi_VN';
  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));
  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    double? height;
    height = widget.heightInput;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5, left: 5),
          child: TextContent(
            contentText: widget.content ?? "",
            color: Colors.black,
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: widget.widthInput,
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.left,
            textAlignVertical: TextAlignVertical.top,
            minLines: 1,
            maxLines: null,
            style:
                TextStyle(color: widget.textColor ?? Colors.black.withOpacity(0.6), fontSize: 17),
            decoration: InputDecoration(
              suffixText: 'VNĐ',
              suffixStyle: TextStyle(
                color: widget.textColor ?? Colors.black.withOpacity(0.4),
                fontSize: 17,
              ),
              labelText: widget.hintText,
              labelStyle: TextStyle(
                color: Colors.black.withOpacity(0.5),
              ),
              contentPadding: EdgeInsets.all((height != null) ? height : 15),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.1),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.primaryColor3,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: "",
              hintStyle: TextStyle(
                color: Colors.grey[350],
                fontSize: 12,
              ),
            ),
            onChanged: (text) {
              text = _formatNumber(text.replaceAll('.', ''));
              controller.value = TextEditingValue(
                text: text,
                selection: TextSelection.collapsed(offset: text.length),
              );
              widget.onChangeText!(text);
            },
          ),
        ),
      ],
    );
  }
}
