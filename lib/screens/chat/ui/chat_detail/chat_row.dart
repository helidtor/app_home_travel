// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/utils/format/format.dart';

class ChatRow extends StatefulWidget {
  String typeMessage;
  String content;
  Timestamp createdAt;
  bool isMeSend;
  ChatRow({
    super.key,
    required this.typeMessage,
    required this.content,
    required this.createdAt,
    required this.isMeSend,
  });

  @override
  State<ChatRow> createState() => _ChatRowState();
}

class _ChatRowState extends State<ChatRow> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Align(
      alignment: widget.isMeSend ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        constraints: BoxConstraints(
            minHeight:
                widget.typeMessage == 'text' ? 50 : screenSize.height * 0.3,
            maxWidth: screenSize.width * 0.8,
            minWidth: widget.typeMessage == 'text'
                ? screenSize.width * 0.3
                : screenSize.width * 0.5),
        padding: widget.isMeSend
            ? const EdgeInsets.only(left: 15, right: 20, top: 8, bottom: 10)
            : const EdgeInsets.only(left: 20, right: 15, top: 8, bottom: 10),
        decoration: widget.typeMessage == 'text' //nếu là type text
            ? BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.2)),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                color: widget.isMeSend
                    ? const Color.fromARGB(235, 99, 44, 166).withOpacity(0.9)
                    : Colors.white.withOpacity(0.9),
              )
            : BoxDecoration(
                //nếu là type image
                border: Border.all(color: Colors.black.withOpacity(0.2)),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                image: DecorationImage(
                  image: Image.network(widget.content).image, //hiển thị ảnh từ link
                  fit: BoxFit.cover,
                ),
              ),
        child: widget.typeMessage == 'text'
            ? Column(
                crossAxisAlignment: widget.isMeSend
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.content,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize: 18,
                          color: widget.isMeSend ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        FormatProvider().formatDateChat(widget.createdAt),
                        style: TextStyle(
                          fontSize: 12,
                          color: widget.isMeSend
                              ? Colors.white.withOpacity(0.85)
                              : Colors.black.withOpacity(0.85),
                        ),
                      ),
                    ],
                  )
                ],
              )
            : const SizedBox(),
      ),
    );
  }
}
