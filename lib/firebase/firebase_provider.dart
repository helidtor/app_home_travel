import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mobile_home_travel/models/chat/message_firebase.dart';
import 'package:mobile_home_travel/models/chat/user_chat_model.dart';
import 'package:mobile_home_travel/utils/shared_preferences_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class FirebaseProvider extends ChangeNotifier {
  // List<UserChatModel> users = [];

  // List<UserChatModel> getAllUserChat() {
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .orderBy('lastChatTime', descending: true)
  //       .snapshots(includeMetadataChanges: true)
  //       .listen((users) {
  //     this.users = users.docs
  //         .map((e) => UserChatModel.fromJson(e.data() as String))
  //         .toList();
  //     notifyListeners();
  //   });
  //   return users;
  // }
  List<MessageFirebase> messages = [];

  Future<List<MessageFirebase>> getMessage() async {
    var userId = SharedPreferencesUtil.getIdUserCurrent();
    FirebaseFirestore.instance
        .collection('messages')
        .doc(userId)
        .collection('with-user')
        .doc('1')
        .collection('messages')
        .orderBy('createdAt')
        .snapshots(includeMetadataChanges: true)
        .listen((messageFirebase) {
      messages = messageFirebase.docs
          .map(
            (doc) => MessageFirebase.fromJson(
              doc.data(),
            ),
          )
          .toList();
      notifyListeners();
    });
    return messages;
  }
}
