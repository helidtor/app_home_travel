// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mobile_home_travel/models/chat/user_chat_model.dart';
import 'package:mobile_home_travel/screens/chat/ui/chat_detail/chat_detail_screen.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/utils/format/format.dart';

class UserChatRow extends StatefulWidget {
  UserChatModel userChatModel;
  UserChatRow({
    super.key,
    required this.userChatModel,
  });

  @override
  State<UserChatRow> createState() => _UserChatRowState();
}

class _UserChatRowState extends State<UserChatRow> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ChatDetailScreen(owner: widget.userChatModel)),
        );
      },
      leading: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(widget.userChatModel.avatar!),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 10),
          //   child: CircleAvatar(
          //     backgroundColor:
          //         widget.userChatModel.isOnline! ? Colors.green : Colors.red,
          //     radius: 5,
          //   ),
          // )
        ],
      ),
      title: Text(
        '${widget.userChatModel.firstName!} ${widget.userChatModel.lastName!}',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        'online lúc ${FormatProvider().formatDateChat(widget.userChatModel.lastTimeChat!)}',
        // '',
        maxLines: 2,
        style: TextStyle(
          color: Colors.black.withOpacity(0.7),
          fontSize: 13,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
