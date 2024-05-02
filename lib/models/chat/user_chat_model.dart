import 'package:cloud_firestore/cloud_firestore.dart';

class UserChatModel {
  String? id;
  String? avatar;
  String? email;
  String? firstName;
  String? lastName;
  Timestamp? lastTimeChat;
  String? phoneNumber;

  UserChatModel({
    this.id,
    this.avatar,
    this.email,
    this.firstName,
    this.lastName,
    this.lastTimeChat,
    this.phoneNumber,
  });

  UserChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    lastTimeChat = json['lastTimeChat'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['avatar'] = avatar;
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['lastTimeChat'] = lastTimeChat;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}
