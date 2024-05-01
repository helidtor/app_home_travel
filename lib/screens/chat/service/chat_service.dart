import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_home_travel/models/chat/message_firebase.dart';
import 'package:mobile_home_travel/utils/shared_preferences_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatService {
  static final fireStore = FirebaseFirestore.instance;

  Future<void> addMessage({required message}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString('idUserCurrent');

    MessageFirebase messageFirebase = MessageFirebase(
      userIdSent: userId,
      content: message,
      createdAt: Timestamp.now(),
      email: null,
      phone: SharedPreferencesUtil.getPhoneNumber(),
      username: SharedPreferencesUtil.getPhoneNumber(),
    );

    await fireStore
        .collection('messages')
        .doc(userId)
        .collection('with-user')
        .doc('1')
        .collection('messages')
        .add(messageFirebase.toJson());

    await fireStore
        .collection('messages')
        .doc('1')
        .collection('with-user')
        .doc(userId)
        .collection('messages')
        .add(messageFirebase.toJson());

    MessageNotificationFirebase messageNotificationFirebase =
        MessageNotificationFirebase(
            userIdSent: userId,
            content: message,
            createdAt: Timestamp.now(),
            email: null,
            phone: SharedPreferencesUtil.getPhoneNumber(),
            username: SharedPreferencesUtil.getPhoneNumber(),
            seen: false);

    await fireStore
        .collection('messages-notification')
        .doc('1')
        .collection('newest-message')
        .doc(userId)
        .set(messageNotificationFirebase.toJson());
  }
}
