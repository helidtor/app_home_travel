// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mobile_home_travel/models/homestay/general_amenitie_homestay/homestay_general_amenitie_titles_model.dart';
import 'package:mobile_home_travel/models/homestay/general_amenitie_homestay/image_home_model.dart';
import 'package:mobile_home_travel/models/homestay/room/room_model.dart';

class HomestayDetailModel {
  String? id;
  String? name;
  num? acreage;
  String? city;
  String? district;
  String? commune;
  String? street;
  String? house;
  String? hamlet;
  String? address;
  String? checkInTime;
  String? checkOutTime;
  String? description;
  int? totalCapacity;
  String? status;
  String? ownerId;
  List<HomeStayGeneralAmenitieTitlesModel>? homeStayGeneralAmenitieTitles;
  List<RoomModel>? rooms;
  List<ImageHomeModel>? images;
  HomestayDetailModel({
    this.id,
    this.name,
    this.acreage,
    this.city,
    this.district,
    this.commune,
    this.street,
    this.house,
    this.hamlet,
    this.address,
    this.checkInTime,
    this.checkOutTime,
    this.description,
    this.totalCapacity,
    this.status,
    this.ownerId,
    this.homeStayGeneralAmenitieTitles,
    this.rooms,
    this.images,
  });

  HomestayDetailModel copyWith({
    String? id,
    String? name,
    num? acreage,
    String? city,
    String? district,
    String? commune,
    String? street,
    String? house,
    String? hamlet,
    String? address,
    String? checkInTime,
    String? checkOutTime,
    String? description,
    int? totalCapacity,
    String? status,
    String? ownerId,
    List<HomeStayGeneralAmenitieTitlesModel>? homeStayGeneralAmenitieTitles,
    List<RoomModel>? rooms,
    List<ImageHomeModel>? images,
  }) {
    return HomestayDetailModel(
      id: id ?? this.id,
      name: name ?? this.name,
      acreage: acreage ?? this.acreage,
      city: city ?? this.city,
      district: district ?? this.district,
      commune: commune ?? this.commune,
      street: street ?? this.street,
      house: house ?? this.house,
      hamlet: hamlet ?? this.hamlet,
      address: address ?? this.address,
      checkInTime: checkInTime ?? this.checkInTime,
      checkOutTime: checkOutTime ?? this.checkOutTime,
      description: description ?? this.description,
      totalCapacity: totalCapacity ?? this.totalCapacity,
      status: status ?? this.status,
      ownerId: ownerId ?? this.ownerId,
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
      'acreage': acreage,
      'city': city,
      'district': district,
      'commune': commune,
      'street': street,
      'house': house,
      'hamlet': hamlet,
      'address': address,
      'checkInTime': checkInTime,
      'checkOutTime': checkOutTime,
      'description': description,
      'totalCapacity': totalCapacity,
      'status': status,
      'ownerId': ownerId,
      'homeStayGeneralAmenitieTitles':
          homeStayGeneralAmenitieTitles?.map((x) => x.toMap()).toList(),
      'rooms': rooms?.map((x) => x.toMap()).toList(),
      'images': images?.map((x) => x.toMap()).toList(),
    };
  }

  factory HomestayDetailModel.fromMap(Map<String, dynamic> map) {
    return HomestayDetailModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      acreage: map['acreage'] != null ? map['acreage'] as num : null,
      city: map['city'] != null ? map['city'] as String : null,
      district: map['district'] != null ? map['district'] as String : null,
      commune: map['commune'] != null ? map['commune'] as String : null,
      street: map['street'] != null ? map['street'] as String : null,
      house: map['house'] != null ? map['house'] as String : null,
      hamlet: map['hamlet'] != null ? map['hamlet'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      checkInTime:
          map['checkInTime'] != null ? map['checkInTime'] as String : null,
      checkOutTime:
          map['checkOutTime'] != null ? map['checkOutTime'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      totalCapacity:
          map['totalCapacity'] != null ? map['totalCapacity'] as int : null,
      status: map['status'] != null ? map['status'] as String : null,
      ownerId: map['ownerId'] != null ? map['ownerId'] as String : null,
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
// factory HomestayDetailModel.fromMap(Map<String, dynamic> map) {
//     return HomestayDetailModel(
//       id: map['id'] != null ? map['id'] as String : null,
//       name: map['name'] != null ? map['name'] as String : null,
//       acreage: map['acreage'] != null ? map['acreage'] as num : null,
//       city: map['city'] != null ? map['city'] as String : null,
//       district: map['district'] != null ? map['district'] as String : null,
//       commune: map['commune'] != null ? map['commune'] as String : null,
//       street: map['street'] != null ? map['street'] as String : null,
//       house: map['house'] != null ? map['house'] as String : null,
//       hamlet: map['hamlet'] != null ? map['hamlet'] as String : null,
//       address: map['address'] != null ? map['address'] as String : null,
//       checkInTime:
//           map['checkInTime'] != null ? map['checkInTime'] as String : null,
//       checkOutTime:
//           map['checkOutTime'] != null ? map['checkOutTime'] as String : null,
//       description:
//           map['description'] != null ? map['description'] as String : null,
//       totalCapacity:
//           map['totalCapacity'] != null ? map['totalCapacity'] as int : null,
//       status: map['status'] != null ? map['status'] as String : null,
//       ownerId: map['ownerId'] != null ? map['ownerId'] as String : null,
//       homeStayGeneralAmenitieTitles:
//           map['homeStayGeneralAmenitieTitles'] != null
//               ? List<HomeStayGeneralAmenitieTitlesModel>.from(
//                   (map['homeStayGeneralAmenitieTitles'])
//                       .map<HomeStayGeneralAmenitieTitlesModel?>(
//                     (x) => HomeStayGeneralAmenitieTitlesModel.fromMap(
//                         x as Map<String, dynamic>),
//                   ),
//                 )
//               : null,
//       rooms: map['rooms'] != null
//           ? List<RoomModel>.from(
//               (map['rooms']).map<RoomModel?>(
//                 (x) => RoomModel.fromMap(x as Map<String, dynamic>),
//               ),
//             )
//           : null,
//       images: map['images'] != null
//           ? List<ImageHomeModel>.from(
//               (map['images']).map<ImageHomeModel?>(
//                 (x) => ImageHomeModel.fromMap(x as Map<String, dynamic>),
//               ),
//             )
//           : null,
//     );
//   }
  String toJson() => json.encode(toMap());

  factory HomestayDetailModel.fromJson(String source) =>
      HomestayDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HomestayDetailModel(id: $id, name: $name, acreage: $acreage, city: $city, district: $district, commune: $commune, street: $street, house: $house, hamlet: $hamlet, address: $address, checkInTime: $checkInTime, checkOutTime: $checkOutTime, description: $description, totalCapacity: $totalCapacity, status: $status, ownerId: $ownerId, homeStayGeneralAmenitieTitles: $homeStayGeneralAmenitieTitles, rooms: $rooms, images: $images)';
  }

  @override
  bool operator ==(covariant HomestayDetailModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.acreage == acreage &&
        other.city == city &&
        other.district == district &&
        other.commune == commune &&
        other.street == street &&
        other.house == house &&
        other.hamlet == hamlet &&
        other.address == address &&
        other.checkInTime == checkInTime &&
        other.checkOutTime == checkOutTime &&
        other.description == description &&
        other.totalCapacity == totalCapacity &&
        other.status == status &&
        other.ownerId == ownerId &&
        listEquals(other.homeStayGeneralAmenitieTitles,
            homeStayGeneralAmenitieTitles) &&
        listEquals(other.rooms, rooms) &&
        listEquals(other.images, images);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        acreage.hashCode ^
        city.hashCode ^
        district.hashCode ^
        commune.hashCode ^
        street.hashCode ^
        house.hashCode ^
        hamlet.hashCode ^
        address.hashCode ^
        checkInTime.hashCode ^
        checkOutTime.hashCode ^
        description.hashCode ^
        totalCapacity.hashCode ^
        status.hashCode ^
        ownerId.hashCode ^
        homeStayGeneralAmenitieTitles.hashCode ^
        rooms.hashCode ^
        images.hashCode;
  }
}
