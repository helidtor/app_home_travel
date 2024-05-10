import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_home_travel/models/chat/message_firebase.dart';
import 'package:mobile_home_travel/models/chat/user_chat_model.dart';
import 'package:mobile_home_travel/models/user/profile_user_model.dart';
import 'package:mobile_home_travel/utils/shared_preferences_util.dart';

class FirebaseChatProvider extends ChangeNotifier {
  static final fireStore = FirebaseFirestore.instance;
  List<MessageFirebase> messages = [];

  //lấy tất cả user đang chat với bản thân
  Stream<List<UserChatModel>> getAllUserChat({required String idCurrentUser}) {
    return FirebaseFirestore.instance
        .collection('userChat')
        .doc(idCurrentUser)
        .collection('withUser')
        .orderBy('lastTimeChat', descending: true)
        .snapshots(includeMetadataChanges: true)
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => UserChatModel.fromJson(doc.data()))
            .toList());
  }

  //lấy tất cả tin nhắn đang chat với 1 user
  Stream<List<MessageFirebase>> getMessage(
      {required String idOwner, required String idCurrentUser}) {
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
      required String idCurrentUser,
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

    await updateTimeChat(idCurrentUser, idOwner);
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

  //update time chat
  Future<void> updateTimeChat(String idUserCurrent, String idUserOwner) async {
    CollectionReference userChatCollection =
        FirebaseFirestore.instance.collection('userChat');

    try {
      await userChatCollection
          .doc(idUserCurrent)
          .collection('withUser')
          .doc(idUserOwner)
          .update({'lastTimeChat': Timestamp.now()});

      await userChatCollection
          .doc(idUserOwner)
          .collection('withUser')
          .doc(idUserCurrent)
          .update({'lastTimeChat': Timestamp.now()});

      print('Update time chat successfully!');
    } catch (e) {
      print('Failed to update time chat: $e');
    }
  }

  //Delete box chat
  Future<void> deleteBoxChat(String idUserCurrent, String idUserOwner) async {
    CollectionReference userChatCollection =
        FirebaseFirestore.instance.collection('userChat');
    CollectionReference boxChatCollection =
        FirebaseFirestore.instance.collection('messages');

    try {
      await boxChatCollection
          .doc(idUserCurrent)
          .collection('withUser')
          .doc(idUserOwner)
          .delete();

      await userChatCollection
          .doc(idUserCurrent)
          .collection('withUser')
          .doc(idUserOwner)
          .delete();

      print('Delete box chat successfully!');
    } catch (e) {
      print('Failed to delete box chat: $e');
    }
  }
}
