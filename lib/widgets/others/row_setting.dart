// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';

class RowSetting extends StatefulWidget {
  final double weightLine;
  final String? textHeader;
  final String? textDescribe;
  final IconData icon;
  final VoidCallback? onPressed;

  const RowSetting({
    Key? key,
    required this.weightLine,
    this.textHeader,
    this.textDescribe,
    required this.icon, this.onPressed,
  }) : super(key: key);

  @override
  State<RowSetting> createState() => _RowSettingState();
}

class _RowSettingState extends State<RowSetting> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Column(
        children: [
          Container(
            height: widget.weightLine,
            color: Colors.grey[300],
          ),
          Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              Icon(
                widget.icon,
                size: 25,
                color: const Color.fromARGB(255, 119, 118, 118),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, top: 15, bottom: 15, right: 20),
                child: Row(
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '${widget.textHeader}',
                            style: const TextStyle(
                              color: Color.fromARGB(169, 0, 0, 0),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: (widget.textDescribe != null)
                                ? '\n${widget.textDescribe}'
                                : "",
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(132, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
