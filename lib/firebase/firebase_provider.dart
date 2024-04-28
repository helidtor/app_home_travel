import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mobile_home_travel/main.dart';
import 'package:mobile_home_travel/models/chat/user_chat_model.dart';
import 'package:mobile_home_travel/routers/router.dart';
import 'package:mobile_home_travel/screens/notifications/notification_screen.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class FirebaseProvider extends ChangeNotifier {
  List<UserChatModel> users = [];
  final _firebaseMessaging = FirebaseMessaging.instance;

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

  Future<void> initNotifications() async {
    //request permission from user
    await _firebaseMessaging.requestPermission();

    //fetch token for this device
    final fToken = await _firebaseMessaging.getToken();
    print('fToken: $fToken');
    // Xử lý thông báo khi ứng dụng đang mở
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print('Titles: ${message.notification?.title}');
    //   print('Body: ${message.notification?.body}');
    //   print('Payload: ${message.data}');
    //   // Hiển thị thông báo khi ứng dụng đang mở
    //   // Ví dụ: sử dụng showDialog hoặc tương tự
    // });
    // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    initPushNotification();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    //navigate to notification screen when message is received and user tap
    navigatorKey.currentState?.pushNamed('/notification', arguments: message);
    // router.go(RouteName.notification, extra: message.data);
  }

  Future initPushNotification() async {
    //handle noti if the app was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    //attach event listeners for when a noti open the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
