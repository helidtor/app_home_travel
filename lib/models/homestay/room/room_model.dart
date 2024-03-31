// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mobile_home_travel/models/homestay/general_amenitie_homestay/homestay_general_amenitie_titles_model.dart';
import 'package:mobile_home_travel/models/homestay/general_amenitie_homestay/image_home_model.dart';
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
  List<HomeStayGeneralAmenitieTitlesModel>? homeStayGeneralAmenitieTitles;
  List<RoomModel>? rooms;
  List<ImageHomeModel>? images;
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
    this.homeStayGeneralAmenitieTitles,
    this.rooms,
    this.images,
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
    List<HomeStayGeneralAmenitieTitlesModel>? homeStayGeneralAmenitieTitles,
    List<RoomModel>? rooms,
    List<ImageHomeModel>? images,
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
      homeStayGeneralAmenitieTitles:
          homeStayGeneralAmenitieTitles ?? this.homeStayGeneralAmenitieTitles,
      rooms: rooms ?? this.rooms,
      images: images ?? this.images,
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
      'homeStayGeneralAmenitieTitles':
          homeStayGeneralAmenitieTitles?.map((x) => x.toMap()).toList(),
      'rooms': rooms?.map((x) => x.toMap()).toList(),
      'images': images?.map((x) => x.toMap()).toList(),
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
      homeStayGeneralAmenitieTitles:
          map['homeStayGeneralAmenitieTitles'] != null
              ? List<HomeStayGeneralAmenitieTitlesModel>.from(
                  (map['homeStayGeneralAmenitieTitles'])
                      .map<HomeStayGeneralAmenitieTitlesModel?>(
                    (x) => HomeStayGeneralAmenitieTitlesModel.fromMap(
                        x as Map<String, dynamic>),
                  ),
                )
              : null,
      rooms: map['rooms'] != null
          ? List<RoomModel>.from(
              (map['rooms']).map<RoomModel?>(
                (x) => RoomModel.fromMap(x as Map<String, dynamic>),
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
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RoomModel(id: $id, name: $name, numberOfBeds: $numberOfBeds, acreage: $acreage, capacity: $capacity, price: $price, status: $status, weekendPrice: $weekendPrice, homeStayId: $homeStayId, homeStayGeneralAmenitieTitles: $homeStayGeneralAmenitieTitles, rooms: $rooms, images: $images)';
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
        listEquals(other.homeStayGeneralAmenitieTitles,
            homeStayGeneralAmenitieTitles) &&
        listEquals(other.rooms, rooms) &&
        listEquals(other.images, images);
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
        homeStayGeneralAmenitieTitles.hashCode ^
        rooms.hashCode ^
        images.hashCode;
  }
}
