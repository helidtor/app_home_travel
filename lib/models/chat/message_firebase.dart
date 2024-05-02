import 'package:cloud_firestore/cloud_firestore.dart';

class MessageFirebase {
  String? content;
  Timestamp? createdAt;
  String? phoneNumber;
  String? userSentId;

  MessageFirebase({
    this.content,
    this.createdAt,
    this.phoneNumber,
    this.userSentId,
  });

  MessageFirebase.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    createdAt = json['createdAt'];
    phoneNumber = json['phoneNumber'];
    userSentId = json['userSentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = content;
    data['createdAt'] = createdAt;
    data['phoneNumber'] = phoneNumber;
    data['userSentId'] = userSentId;
    return data;
  }
}
