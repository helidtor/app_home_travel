// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mobile_home_travel/models/homestay/general_homestay/homestay_general_amenitie_titles_model.dart';
import 'package:mobile_home_travel/models/homestay/general_homestay/homestay_model.dart';
import 'package:mobile_home_travel/models/homestay/general_homestay/image_home_model.dart';
import 'package:mobile_home_travel/models/homestay/room/image_room_model.dart';
import 'package:mobile_home_travel/models/homestay/room/room_amenitie_titles_model.dart';

class RoomModel {
  String? id;
  String? name;
  int? numberOfBeds;
  num? acreage;
  int? capacity;
  num? price;
  String? status;
  num? weekendPrice;
  String? homeStayId;
  List<RoomAmenitieTitlesModel>? roomAmenitieTitles;
  List<ImageHomeModel>? images;
  HomestayModel? homeStay;
  RoomModel({
    this.id,
    this.name,
    this.numberOfBeds,
    this.acreage,
    this.capacity,
    this.price,
    this.status,
    this.weekendPrice,
    this.homeStayId,
    this.roomAmenitieTitles,
    this.images,
    this.homeStay,
  });

  RoomModel copyWith({
    String? id,
    String? name,
    int? numberOfBeds,
    num? acreage,
    int? capacity,
    num? price,
    String? status,
    num? weekendPrice,
    String? homeStayId,
    List<RoomAmenitieTitlesModel>? roomAmenitieTitles,
    List<ImageHomeModel>? images,
    HomestayModel? homeStay,
  }) {
    return RoomModel(
      id: id ?? this.id,
      name: name ?? this.name,
      numberOfBeds: numberOfBeds ?? this.numberOfBeds,
      acreage: acreage ?? this.acreage,
      capacity: capacity ?? this.capacity,
      price: price ?? this.price,
      status: status ?? this.status,
      weekendPrice: weekendPrice ?? this.weekendPrice,
      homeStayId: homeStayId ?? this.homeStayId,
      roomAmenitieTitles: roomAmenitieTitles ?? this.roomAmenitieTitles,
      images: images ?? this.images,
      homeStay: homeStay ?? this.homeStay,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'numberOfBeds': numberOfBeds,
      'acreage': acreage,
      'capacity': capacity,
      'price': price,
      'status': status,
      'weekendPrice': weekendPrice,
      'homeStayId': homeStayId,
      'roomAmenitieTitles': roomAmenitieTitles?.map((x) => x.toMap()).toList(),
      'images': images?.map((x) => x.toMap()).toList(),
      'homeStay': homeStay?.toMap(),
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      numberOfBeds:
          map['numberOfBeds'] != null ? map['numberOfBeds'] as int : null,
      acreage: map['acreage'] != null ? map['acreage'] as num : null,
      capacity: map['capacity'] != null ? map['capacity'] as int : null,
      price: map['price'] != null ? map['price'] as num : null,
      status: map['status'] != null ? map['status'] as String : null,
      weekendPrice:
          map['weekendPrice'] != null ? map['weekendPrice'] as num : null,
      homeStayId:
          map['homeStayId'] != null ? map['homeStayId'] as String : null,
      roomAmenitieTitles: map['roomAmenitieTitles'] != null
          ? List<RoomAmenitieTitlesModel>.from(
              (map['roomAmenitieTitles']).map<RoomAmenitieTitlesModel?>(
                (x) =>
                    RoomAmenitieTitlesModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      images: map['images'] != null
          ? List<ImageHomeModel>.from(
              (map['images']).map<ImageHomeModel?>(
                (x) => ImageHomeModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      homeStay: map['homeStay'] != null
          ? HomestayModel.fromMap(map['homeStay'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RoomModel(id: $id, name: $name, numberOfBeds: $numberOfBeds, acreage: $acreage, capacity: $capacity, price: $price, status: $status, weekendPrice: $weekendPrice, homeStayId: $homeStayId, roomAmenitieTitles: $roomAmenitieTitles, images: $images, homeStay: $homeStay)';
  }

  @override
  bool operator ==(covariant RoomModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.numberOfBeds == numberOfBeds &&
        other.acreage == acreage &&
        other.capacity == capacity &&
        other.price == price &&
        other.status == status &&
        other.weekendPrice == weekendPrice &&
        other.homeStayId == homeStayId &&
        listEquals(other.roomAmenitieTitles, roomAmenitieTitles) &&
        listEquals(other.images, images) &&
        other.homeStay == homeStay;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        numberOfBeds.hashCode ^
        acreage.hashCode ^
        capacity.hashCode ^
        price.hashCode ^
        status.hashCode ^
        weekendPrice.hashCode ^
        homeStayId.hashCode ^
        roomAmenitieTitles.hashCode ^
        images.hashCode ^
        homeStay.hashCode;
  }
}
