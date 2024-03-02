import 'package:flutter/material.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';

class FieldProfile extends StatefulWidget {
  final String content;
  final bool readOnly;
  final String label;
  final TextEditingController? controller;
  final double widthInput;
  final Function? onChangeText;
  final IconData? icon;
  const FieldProfile({
    Key? key,
    required this.label,
    this.controller,
    required this.widthInput,
    required this.readOnly,
    required this.content,
    this.onChangeText,
    this.icon,
  }) : super(key: key);

  @override
  State<FieldProfile> createState() => _FieldProfileState();
}

class _FieldProfileState extends State<FieldProfile> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 2, left: 5),
          child: Text(
            widget.label,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 15),
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: screenWidth * widget.widthInput,
          ),
          child: TextFormField(
            initialValue: widget.content,
            readOnly: widget.readOnly,
            style: const TextStyle(
                color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
            decoration: InputDecoration(
              labelStyle: const TextStyle(
                color: Color.fromARGB(255, 159, 159, 159),
              ),
              contentPadding: const EdgeInsets.all(22),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromRGBO(168, 167, 167, 0.344),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(40),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.primaryColor3,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              hintText: "",
              hintStyle:
                  const TextStyle(color: Color.fromARGB(255, 28, 27, 27)),
              prefixIcon: widget.icon != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20, right: 10),
                      child: Icon(widget.icon,
                          color: AppColors.primaryColor3, size: 30),
                    )
                  : null,
            ),
            onChanged: (text) {
              widget.onChangeText!(text);
            },
          ),
        ),
      ],
    );
  }
}
