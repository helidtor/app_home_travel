// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mobile_home_travel/firebase/firebase_chat_provider.dart';
import 'package:mobile_home_travel/models/chat/user_chat_model.dart';
import 'package:mobile_home_travel/screens/chat/ui/chat_detail/chat_detail_screen.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/utils/format/format.dart';
import 'package:mobile_home_travel/widgets/notification/success_provider.dart';

class UserChatRow extends StatefulWidget {
  UserChatModel userChatModel;
  String idUserCurrent;
  UserChatRow({
    Key? key,
    required this.userChatModel,
    required this.idUserCurrent,
  }) : super(key: key);

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
      leading: widget.userChatModel.avatar != null
          ? CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(widget.userChatModel.avatar!),
            )
          : const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/no_avatar.png'),
            ),
      trailing: IconButton(
        onPressed: () async {
          showCupertinoDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: const Text(
                  'Cảnh báo',
                  style: TextStyle(
                    color: AppColors.primaryColor3,
                    fontSize: 20,
                  ),
                ),
                content: const Text(
                  'Bạn có chắc muốn xóa\ncuộc trò chuyện này không?',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                actions: [
                  CupertinoDialogAction(
                    child: TextButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        SuccessNotiProvider().ToastSuccess(
                            context, 'Xóa cuộc trò chuyện thành công!');
                        await FirebaseChatProvider().deleteBoxChat(
                            widget.idUserCurrent, widget.userChatModel.id!);
                      },
                      child: const Text(
                        'Có',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor3,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  //xóa chat
                  CupertinoDialogAction(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Không',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor3,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        icon: const Icon(
          Icons.delete,
          color: Color.fromARGB(255, 223, 41, 28),
        ),
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
