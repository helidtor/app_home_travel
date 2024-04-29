// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NotificationModel {
  String? id;
  String? image;
  String? content;
  String? url;
  String? createdDate;
  String? receiverId;
  String? status;
  NotificationModel({
    this.id,
    this.image,
    this.content,
    this.url,
    this.createdDate,
    this.receiverId,
    this.status,
  });

  NotificationModel copyWith({
    String? id,
    String? image,
    String? content,
    String? url,
    String? createdDate,
    String? receiverId,
    String? status,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      image: image ?? this.image,
      content: content ?? this.content,
      url: url ?? this.url,
      createdDate: createdDate ?? this.createdDate,
      receiverId: receiverId ?? this.receiverId,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image': image,
      'content': content,
      'url': url,
      'createdDate': createdDate,
      'receiverId': receiverId,
      'status': status,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] != null ? map['id'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
      createdDate: map['createdDate'] != null ? map['createdDate'] as String : null,
      receiverId: map['receiverId'] != null ? map['receiverId'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) => NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotificationModel(id: $id, image: $image, content: $content, url: $url, createdDate: $createdDate, receiverId: $receiverId, status: $status)';
  }

  @override
  bool operator ==(covariant NotificationModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.image == image &&
      other.content == content &&
      other.url == url &&
      other.createdDate == createdDate &&
      other.receiverId == receiverId &&
      other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      image.hashCode ^
      content.hashCode ^
      url.hashCode ^
      createdDate.hashCode ^
      receiverId.hashCode ^
      status.hashCode;
  }
}
