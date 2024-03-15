// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ImageHomeModel {
  int? imageHomeId;
  String? imageURL;
  int? homeStayId;
  ImageHomeModel({
    this.imageHomeId,
    this.imageURL,
    this.homeStayId,
  });

  ImageHomeModel copyWith({
    int? imageHomeId,
    String? imageURL,
    int? homeStayId,
  }) {
    return ImageHomeModel(
      imageHomeId: imageHomeId ?? this.imageHomeId,
      imageURL: imageURL ?? this.imageURL,
      homeStayId: homeStayId ?? this.homeStayId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageHomeId': imageHomeId,
      'imageURL': imageURL,
      'homeStayId': homeStayId,
    };
  }

  factory ImageHomeModel.fromMap(Map<String, dynamic> map) {
    return ImageHomeModel(
      imageHomeId:
          map['imageHomeId'] != null ? map['imageHomeId'] as int : null,
      imageURL: map['imageURL'] != null ? map['imageURL'] as String : null,
      homeStayId: map['homeStayId'] != null ? map['homeStayId'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageHomeModel.fromJson(String source) =>
      ImageHomeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ImageHomeModel(imageHomeId: $imageHomeId, imageURL: $imageURL, homeStayId: $homeStayId)';

  @override
  bool operator ==(covariant ImageHomeModel other) {
    if (identical(this, other)) return true;

    return other.imageHomeId == imageHomeId &&
        other.imageURL == imageURL &&
        other.homeStayId == homeStayId;
  }

  @override
  int get hashCode =>
      imageHomeId.hashCode ^ imageURL.hashCode ^ homeStayId.hashCode;
}
