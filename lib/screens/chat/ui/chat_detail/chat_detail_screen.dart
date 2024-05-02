// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mobile_home_travel/models/chat/message_firebase.dart';
import 'package:mobile_home_travel/models/chat/user_chat_model.dart';
import 'package:mobile_home_travel/screens/chat/ui/chat_detail/chat_row.dart';
import 'package:mobile_home_travel/themes/app_colors.dart';
import 'package:mobile_home_travel/widgets/notification/error_provider.dart';
import 'package:provider/provider.dart';
import 'package:mobile_home_travel/firebase/firebase_chat_provider.dart';
import 'package:mobile_home_travel/utils/shared_preferences_util.dart';

class ChatDetailScreen extends StatefulWidget {
  final UserChatModel owner;

  ChatDetailScreen({
    super.key,
    required this.owner,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  String? userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId = SharedPreferencesUtil.getIdUserCurrent();
  }

  void sendMessage() async {
    try {
      await FirebaseChatProvider().addMessage(
          message: _messageController.text, idOwner: widget.owner.id!);
      _messageController.clear();
    } catch (e) {
      if (mounted) {
        ErrorNotiProvider().ToastError(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          backgroundColor:
              const Color.fromARGB(235, 75, 29, 131).withOpacity(0.9),
          foregroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.keyboard_arrow_left),
          ),
          title: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  widget.owner.avatar!,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                '${widget.owner.firstName} ${widget.owner.lastName}',
                style: const TextStyle(
                    color: Color.fromARGB(255, 225, 223, 223),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/background_chat.jpeg'),
              )
                  // gradient: LinearGradient(
                  //     colors: AppColors.thirdG,
                  //     begin: Alignment.topLeft,
                  //     end: Alignment.bottomRight),
                  ),
            ),
            Column(
              children: [
                Expanded(
                  child: StreamBuilder<List<MessageFirebase>>(
                    stream: Provider.of<FirebaseChatProvider>(context)
                        .getMessage(idOwner: widget.owner.id!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (snapshot.hasData && snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('Chưa có tin nhắn'),
                        );
                      }

                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Đã xảy ra lỗi: ${snapshot.error}'),
                        );
                      }

                      final messages = snapshot.data!;

                      return ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 16.0,
                        ),
                        reverse: true,
                        itemBuilder: (context, index) {
                          final messageReserved = messages.reversed.toList();
                          return ChatRow(
                            message: messageReserved[index].content!,
                            createdAt: messageReserved[index].createdAt!,
                            isMeSend:
                                messageReserved[index].userSentId == userId!,
                          );
                        },
                        itemCount: messages.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 20),
                      );
                    },
                  ),
                ),
                Container(
                  color:
                      const Color.fromARGB(235, 72, 30, 124).withOpacity(0.9),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          scrollPadding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.white, // Màu nền
                            filled: true,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black38),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black38),
                            ),
                            labelText: 'Soạn tin nhắn ...',
                            hintText: 'Soạn tin nhắn ...',
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.black, width: 1)),
                          ),
                          controller: _messageController,
                        ),
                      ),
                      const SizedBox(width: 10),
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          onPressed: () => sendMessage(),
                          icon: Icon(
                            size: 25,
                            Icons.edit,
                            color: AppColors.primaryColor3.withOpacity(0.9),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
