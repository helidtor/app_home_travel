// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_home_travel/api/api_user.dart';
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
  File? selectedImage;
  String? userId;
  String? contentImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId = SharedPreferencesUtil.getIdUserCurrent();
  }

  void sendMessage({required String typeMessage, String? content}) async {
    try {
      await FirebaseChatProvider().addMessage(
          typeMessage: typeMessage,
          content: content ?? _messageController.text,
          idOwner: widget.owner.id!);
      _messageController.clear();
    } catch (e) {
      if (mounted) {
        ErrorNotiProvider().ToastError(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            toolbarHeight: screenSize.height * 0.09,
            backgroundColor: Colors.black.withOpacity(0),
            foregroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.keyboard_arrow_left),
            ),
            title: Row(
              children: [
                widget.owner.avatar != null
                    ? CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          widget.owner.avatar!,
                        ),
                      )
                    : const CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            AssetImage('assets/images/no_avatar.png'),
                      ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  '${widget.owner.lastName} ${widget.owner.firstName}',
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
              Padding(
                padding: EdgeInsets.only(top: screenSize.height * 0.09),
                child: Column(
                  children: [
                    Expanded(
                      child: StreamBuilder<List<MessageFirebase>>(
                        stream: Provider.of<FirebaseChatProvider>(context)
                            .getMessage(
                                idOwner: widget.owner.id!), //lấy tin nhắn
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: SizedBox(
                                width: screenSize.width,
                                height: screenSize.height,
                                child: Image.asset(
                                  "assets/images/background_chat.jpeg",
                                  fit: BoxFit.fill,
                                ),
                              ),
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
                              final messageReserved =
                                  messages.reversed.toList();
                              return ChatRow(
                                typeMessage:
                                    messageReserved[index].typeMessage!,
                                content: messageReserved[index].content!,
                                createdAt: messageReserved[index].createdAt!,
                                isMeSend: messageReserved[index].userSentId ==
                                    userId!,
                              );
                            },
                            itemCount: messages.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                          );
                        },
                      ),
                    ),
                    Container(
                      color: Colors.black.withOpacity(0),
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                fillColor: Colors.white, // Màu nền
                                filled: true,
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                  borderSide: BorderSide(color: Colors.black38),
                                ),
                                labelText: '    Soạn tin nhắn...',
                                hintText: 'Soạn tin nhắn...',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                prefix: const SizedBox(
                                  width: 20,
                                ),
                                contentPadding: const EdgeInsets.all(15),
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1)),
                              ),
                              controller: _messageController,
                            ),
                          ),
                          const SizedBox(width: 10),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: () => (_messageController.text != '')
                                  ? sendMessage(
                                      typeMessage: 'text', content: null)
                                  : {},
                              icon: Center(
                                child: Icon(
                                  size: 25,
                                  Icons.send,
                                  color:
                                      AppColors.primaryColor3.withOpacity(0.9),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: IconButton(
                              onPressed: () async {
                                await pickImage();
                              },
                              icon: Center(
                                child: Icon(
                                  size: 25,
                                  Icons.image,
                                  color:
                                      AppColors.primaryColor3.withOpacity(0.9),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }

  // Hàm xử lý khi chọn ảnh
  Future<void> pickImage() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() async {
      selectedImage = File(returnedImage!.path);
      if (selectedImage != null) {
        var result = await ApiUser.uploadImage(
          selectedImage!,
          selectedImage!.path,
        );
        if (result != null) {
          setState(() {
            contentImage = result;
            print('content img: $contentImage');
          });
          if (contentImage != null) {
            sendMessage(typeMessage: 'image', content: contentImage);
            setState(
              () {
                contentImage = null;
              },
            );
          } else {
            print('Ảnh chat null');
          }
        }
      }
    });
  }
}
