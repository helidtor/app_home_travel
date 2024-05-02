import 'package:cloud_firestore/cloud_firestore.dart';

class MessageFirebase {
  String? content;
  Timestamp? createdAt;
  String? phoneNumber;
  String? userSentId;
  String? typeMessage;

  MessageFirebase({
    this.content,
    this.createdAt,
    this.phoneNumber,
    this.userSentId,
    this.typeMessage,
  });

  MessageFirebase.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    createdAt = json['createdAt'];
    phoneNumber = json['phoneNumber'];
    userSentId = json['userSentId'];
    typeMessage = json['typeMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = content;
    data['createdAt'] = createdAt;
    data['phoneNumber'] = phoneNumber;
    data['userSentId'] = userSentId;
    data['typeMessage'] = typeMessage;
    return data;
  }
}
