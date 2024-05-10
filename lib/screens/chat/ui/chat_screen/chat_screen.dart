import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_home_travel/firebase/firebase_chat_provider.dart';
import 'package:mobile_home_travel/models/chat/user_chat_model.dart';
import 'package:mobile_home_travel/screens/chat/ui/chat_screen/user_chat_row.dart';
import 'package:mobile_home_travel/utils/shared_preferences_util.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? idCurrentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idCurrentUser = SharedPreferencesUtil.getIdUserCurrent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Tin nhắn",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<List<UserChatModel>>(
        stream: Provider.of<FirebaseChatProvider>(context).getAllUserChat(
            idCurrentUser:
                idCurrentUser!), //lấy tất cả user đang có cuộc trò chuyện
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: Image.asset(
                  "assets/gifs/loading.gif",
                  fit: BoxFit.cover,
                ),
              ),
            );
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Đã xảy ra lỗi"));
          }

          List<UserChatModel> users =
              (snapshot.hasData && snapshot.data!.isNotEmpty)
                  ? snapshot.data!
                  : [];

          return users.isNotEmpty
              ? ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  // padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: users.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemBuilder: (context, index) => users[index].phoneNumber !=
                          FirebaseAuth.instance.currentUser?.phoneNumber
                      ? UserChatRow(
                          userChatModel: users[index],
                          idUserCurrent: idCurrentUser!,
                        )
                      : const SizedBox(),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.asset(
                          'assets/images/no_message.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Text(
                        'Tin nhắn trống!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black38,
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
