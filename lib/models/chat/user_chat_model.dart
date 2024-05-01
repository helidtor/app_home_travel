// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserChatModel {
  String? uid;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? lastChatTime;
  bool? isOnline;
  UserChatModel({
    this.uid,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.lastChatTime,
    this.isOnline,
  });

  UserChatModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? phone,
    String? image,
    String? lastChatTime,
    bool? isOnline,
  }) {
    return UserChatModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      lastChatTime: lastChatTime ?? this.lastChatTime,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'lastChatTime': lastChatTime,
      'isOnline': isOnline,
    };
  }

  factory UserChatModel.fromMap(Map<String, dynamic> map) {
    return UserChatModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      lastChatTime:
          map['lastChatTime'] != null ? map['lastChatTime'] as String : null,
      isOnline: map['isOnline'] != null ? map['isOnline'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserChatModel.fromJson(String source) =>
      UserChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserChatModel(uid: $uid, name: $name, email: $email, phone: $phone, image: $image, lastChatTime: $lastChatTime, isOnline: $isOnline)';
  }

  @override
  bool operator ==(covariant UserChatModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.image == image &&
        other.lastChatTime == lastChatTime &&
        other.isOnline == isOnline;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        image.hashCode ^
        lastChatTime.hashCode ^
        isOnline.hashCode;
  }
}
