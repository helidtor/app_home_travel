// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mobile_home_travel/models/chat/user_chat_model.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/utils/format/format.dart';

class ChatRow extends StatefulWidget {
  UserChatModel userChatModel;
  ChatRow({
    super.key,
    required this.userChatModel,
  });

  @override
  State<ChatRow> createState() => _ChatRowState();
}

class _ChatRowState extends State<ChatRow> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(widget.userChatModel.image!),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CircleAvatar(
              backgroundColor:
                  widget.userChatModel.isOnline! ? Colors.green : Colors.red,
              radius: 5,
            ),
          )
        ],
      ),
      title: Text(
        widget.userChatModel.name!,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        'Online ${FormatProvider().convertTime(widget.userChatModel.lastChatTime!)} trước',
        maxLines: 2,
        style: const TextStyle(
          color: AppColors.primaryColor3,
          fontSize: 15,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
