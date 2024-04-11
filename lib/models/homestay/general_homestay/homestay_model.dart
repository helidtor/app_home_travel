// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mobile_home_travel/models/homestay/general_homestay/image_home_model.dart';

class HomestayModel {
  List<ImageHomeModel>? images;
  String? id;
  String? name;
  num? acreage;
  String? description;
  String? city;
  String? district;
  String? commune;
  String? house;
  String? hamlet;
  String? street;
  String? address;
  String? checkInTime;
  String? checkOutTime;
  int? totalCapacity;
  String? status;
  String? ownerId;
  num? rating;
  HomestayModel({
    this.images,
    this.id,
    this.name,
    this.acreage,
    this.description,
    this.city,
    this.district,
    this.commune,
    this.house,
    this.hamlet,
    this.street,
    this.address,
    this.checkInTime,
    this.checkOutTime,
    this.totalCapacity,
    this.status,
    this.ownerId,
    this.rating,
  });

  HomestayModel copyWith({
    List<ImageHomeModel>? images,
    String? id,
    String? name,
    num? acreage,
    String? description,
    String? city,
    String? district,
    String? commune,
    String? house,
    String? hamlet,
    String? street,
    String? address,
    String? checkInTime,
    String? checkOutTime,
    int? totalCapacity,
    String? status,
    String? ownerId,
    num? rating,
  }) {
    return HomestayModel(
      images: images ?? this.images,
      id: id ?? this.id,
      name: name ?? this.name,
      acreage: acreage ?? this.acreage,
      description: description ?? this.description,
      city: city ?? this.city,
      district: district ?? this.district,
      commune: commune ?? this.commune,
      house: house ?? this.house,
      hamlet: hamlet ?? this.hamlet,
      street: street ?? this.street,
      address: address ?? this.address,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
      totalCapacity: totalCapacity ?? this.totalCapacity,
      status: status ?? this.status,
      ownerId: ownerId ?? this.ownerId,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'images': images?.map((x) => x.toMap()).toList(),
      'id': id,
      'name': name,
      'acreage': acreage,
      'description': description,
      'city': city,
      'district': district,
      'commune': commune,
      'house': house,
      'hamlet': hamlet,
      'street': street,
      'address': address,
      'checkInTime': checkInTime,
      'checkOutTime': checkOutTime,
      'totalCapacity': totalCapacity,
      'status': status,
      'ownerId': ownerId,
      'rating': rating,
    };
  }

  factory HomestayModel.fromMap(Map<String, dynamic> map) {
    return HomestayModel(
      images: map['images'] != null
          ? List<ImageHomeModel>.from(
              (map['images']).map<ImageHomeModel?>(
                (x) => ImageHomeModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      acreage: map['acreage'] != null ? map['acreage'] as num : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      district: map['district'] != null ? map['district'] as String : null,
      commune: map['commune'] != null ? map['commune'] as String : null,
      house: map['house'] != null ? map['house'] as String : null,
      hamlet: map['hamlet'] != null ? map['hamlet'] as String : null,
      street: map['street'] != null ? map['street'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      checkInTime:
          map['checkInTime'] != null ? map['checkInTime'] as String : null,
      checkOutTime:
          map['checkOutTime'] != null ? map['checkOutTime'] as String : null,
      totalCapacity:
          map['totalCapacity'] != null ? map['totalCapacity'] as int : null,
      status: map['status'] != null ? map['status'] as String : null,
      ownerId: map['ownerId'] != null ? map['ownerId'] as String : null,
      rating: map['rating'] != null ? map['rating'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomestayModel.fromJson(String source) =>
      HomestayModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HomestayModel(images: $images, id: $id, name: $name, acreage: $acreage, description: $description, city: $city, district: $district, commune: $commune, house: $house, hamlet: $hamlet, street: $street, address: $address, checkInTime: $checkInTime, checkOutTime: $checkOutTime, totalCapacity: $totalCapacity, status: $status, ownerId: $ownerId, rating: $rating)';
  }

  @override
  bool operator ==(covariant HomestayModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.images, images) &&
        other.id == id &&
        other.name == name &&
        other.acreage == acreage &&
        other.description == description &&
        other.city == city &&
        other.district == district &&
        other.commune == commune &&
        other.house == house &&
        other.hamlet == hamlet &&
        other.street == street &&
        other.address == address &&
        other.checkInTime == checkInTime &&
        other.checkOutTime == checkOutTime &&
        other.totalCapacity == totalCapacity &&
        other.status == status &&
        other.ownerId == ownerId &&
        other.rating == rating;
  }

  @override
  int get hashCode {
    return images.hashCode ^
        id.hashCode ^
        name.hashCode ^
        acreage.hashCode ^
        description.hashCode ^
        city.hashCode ^
        district.hashCode ^
        commune.hashCode ^
        house.hashCode ^
        hamlet.hashCode ^
        street.hashCode ^
        address.hashCode ^
        checkInTime.hashCode ^
        checkOutTime.hashCode ^
        totalCapacity.hashCode ^
        status.hashCode ^
        ownerId.hashCode ^
        rating.hashCode;
  }
}
