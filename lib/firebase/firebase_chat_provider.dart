import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_home_travel/models/chat/message_firebase.dart';
import 'package:mobile_home_travel/models/chat/user_chat_model.dart';
import 'package:mobile_home_travel/models/user/profile_user_model.dart';
import 'package:mobile_home_travel/utils/shared_preferences_util.dart';

class FirebaseChatProvider extends ChangeNotifier {
  static final fireStore = FirebaseFirestore.instance;
  List<MessageFirebase> messages = [];
  String? idCurrentUser = SharedPreferencesUtil.getIdUserCurrent();

  //lấy tất cả user đang chat với bản thân
  Stream<List<UserChatModel>> getAllUserChat() {
    return FirebaseFirestore.instance
        .collection('userChat')
        .doc(idCurrentUser)
        .collection('withUser')
        .orderBy('lastTimeChat')
        .snapshots(includeMetadataChanges: true)
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => UserChatModel.fromJson(doc.data()))
            .toList());
  }

  //lấy tất cả tin nhắn đang chat với 1 user
  Stream<List<MessageFirebase>> getMessage({required String idOwner}) {
    return FirebaseFirestore.instance
        .collection('messages')
        .doc(idCurrentUser)
        .collection('withUser')
        .doc(idOwner)
        .collection('message')
        .orderBy('createdAt', descending: false)
        .snapshots(includeMetadataChanges: true)
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => MessageFirebase.fromJson(doc.data()))
            .toList());
  }

  //gửi 1 tin nhắn mới
  Future<void> addMessage(
      {required String content,
      required String typeMessage,
      required String idOwner}) async {
    MessageFirebase messageFirebase = MessageFirebase(
      userSentId: idCurrentUser,
      content: content,
      createdAt: Timestamp.now(),
      typeMessage: typeMessage,
      phoneNumber: SharedPreferencesUtil.getPhoneNumber(),
    );

    await fireStore
        .collection('messages')
        .doc(idCurrentUser)
        .collection('withUser')
        .doc(idOwner)
        .collection('message')
        .add(messageFirebase.toJson());

    await fireStore
        .collection('messages')
        .doc(idOwner)
        .collection('withUser')
        .doc(idCurrentUser)
        .collection('message')
        .add(messageFirebase.toJson());
  }

  //tạo box chat với user khác
  Future<void> createUserChat(
      UserProfileModel userCurrent, UserProfileModel userOwner) async {
    CollectionReference userChatCollection =
        FirebaseFirestore.instance.collection('userChat');

    try {
      await userChatCollection
          .doc(userCurrent.id)
          .collection('withUser')
          .doc(userOwner.id)
          .set({
        'id': userOwner.id,
        'avatar': userOwner.avatar,
        'email': userOwner.email,
        'firstName': userOwner.firstName,
        'lastName': userOwner.lastName,
        'lastTimeChat': Timestamp.now(),
        'phoneNumber': userOwner.phoneNumber,
      });
      await userChatCollection
          .doc(userOwner.id)
          .collection('withUser')
          .doc(userCurrent.id)
          .set({
        'id': userCurrent.id,
        'avatar': userCurrent.avatar,
        'email': userCurrent.email,
        'firstName': userCurrent.firstName,
        'lastName': userCurrent.lastName,
        'lastTimeChat': Timestamp.now(),
        'phoneNumber': userCurrent.phoneNumber,
      });
      print('User chat created successfully!');
    } catch (e) {
      print('Failed to create user chat: $e');
    }
  }
}
