// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ImageHomeModel {
  String? id;
  String? url;
  String? roomId;
  String? homeStayId;
  ImageHomeModel({
    this.id,
    this.url,
    this.roomId,
    this.homeStayId,
  });

  ImageHomeModel copyWith({
    String? id,
    String? url,
    String? roomId,
    String? homeStayId,
  }) {
    return ImageHomeModel(
      id: id ?? this.id,
      url: url ?? this.url,
      roomId: roomId ?? this.roomId,
      homeStayId: homeStayId ?? this.homeStayId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'url': url,
      'roomId': roomId,
      'homeStayId': homeStayId,
    };
  }

  factory ImageHomeModel.fromMap(Map<String, dynamic> map) {
    return ImageHomeModel(
      id: map['id'] != null ? map['id'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
      roomId: map['roomId'] != null ? map['roomId'] as String : null,
      homeStayId: map['homeStayId'] != null ? map['homeStayId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageHomeModel.fromJson(String source) => ImageHomeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ImageHomeModel(id: $id, url: $url, roomId: $roomId, homeStayId: $homeStayId)';
  }

  @override
  bool operator ==(covariant ImageHomeModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.url == url &&
      other.roomId == roomId &&
      other.homeStayId == homeStayId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      url.hashCode ^
      roomId.hashCode ^
      homeStayId.hashCode;
  }
}
