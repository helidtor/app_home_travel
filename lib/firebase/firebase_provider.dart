import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_home_travel/models/chat/user_chat_model.dart';

class FirebaseProvider extends ChangeNotifier {
  List<UserChatModel> users = [];

  List<UserChatModel> getAllUserChat() {
    FirebaseFirestore.instance
        .collection('users')
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
