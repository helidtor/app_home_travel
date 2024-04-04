// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:mobile_home_travel/models/homestay/homestay_model.dart';

class WishlistModel {
  String? id;
  String? touristId;
  String? homeStayId;
  String? createdDate;
  HomestayModel? homeStay;
  WishlistModel({
    this.id,
    this.touristId,
    this.homeStayId,
    this.createdDate,
    this.homeStay,
  });

  WishlistModel copyWith({
    String? id,
    String? touristId,
    String? homeStayId,
    String? createdDate,
    HomestayModel? homeStay,
  }) {
    return WishlistModel(
      id: id ?? this.id,
      touristId: touristId ?? this.touristId,
      homeStayId: homeStayId ?? this.homeStayId,
      createdDate: createdDate ?? this.createdDate,
      homeStay: homeStay ?? this.homeStay,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'touristId': touristId,
      'homeStayId': homeStayId,
      'createdDate': createdDate,
      'homeStay': homeStay?.toMap(),
    };
  }

  factory WishlistModel.fromMap(Map<String, dynamic> map) {
    return WishlistModel(
      id: map['id'] != null ? map['id'] as String : null,
      touristId: map['touristId'] != null ? map['touristId'] as String : null,
      homeStayId:
          map['homeStayId'] != null ? map['homeStayId'] as String : null,
      createdDate:
          map['createdDate'] != null ? map['createdDate'] as String : null,
      homeStay: map['homeStay'] != null
          ? HomestayModel.fromMap(map['homeStay'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WishlistModel.fromJson(String source) =>
      WishlistModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WishlistModel(id: $id, touristId: $touristId, homeStayId: $homeStayId, createdDate: $createdDate, homeStay: $homeStay)';
  }

  @override
  bool operator ==(covariant WishlistModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.touristId == touristId &&
        other.homeStayId == homeStayId &&
        other.createdDate == createdDate &&
        other.homeStay == homeStay;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        touristId.hashCode ^
        homeStayId.hashCode ^
        createdDate.hashCode ^
        homeStay.hashCode;
  }
}
