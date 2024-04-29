import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mobile_home_travel/models/chat/user_chat_model.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class FirebaseProvider extends ChangeNotifier {
  List<UserChatModel> users = [];

  List<UserChatModel> getAllUserChat() {
    FirebaseFirestore.instance
        .collection('users')
        .orderBy('lastActive', descending: true)
        .snapshots(includeMetadataChanges: true)
        .listen((users) {
      this.users = users.docs
          .map((e) => UserChatModel.fromJson(e.data() as String))
          .toList();
      notifyListeners();
    });
    return users;
  }
}
