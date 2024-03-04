// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mobile_home_travel/models/image_home_model.dart';
import 'package:mobile_home_travel/models/location_model.dart';
import 'package:mobile_home_travel/models/service_model.dart';

class HomestayModel {
  int? homeStayId;
  String? homeStayName;
  String? acreage;
  String? description;
  LocationModel? location;
  List<ServiceModel>? services;
  List<ImageHomeModel>? imageHomes;
  HomestayModel({
    this.homeStayId,
    this.homeStayName,
    this.acreage,
    this.description,
    this.location,
    this.services,
    this.imageHomes,
  });

  HomestayModel copyWith({
    int? homeStayId,
    String? homeStayName,
    String? acreage,
    String? description,
    LocationModel? location,
    List<ServiceModel>? services,
    List<ImageHomeModel>? imageHomes,
  }) {
    return HomestayModel(
      homeStayId: homeStayId ?? this.homeStayId,
      homeStayName: homeStayName ?? this.homeStayName,
      acreage: acreage ?? this.acreage,
      description: description ?? this.description,
      location: location ?? this.location,
      services: services ?? this.services,
      imageHomes: imageHomes ?? this.imageHomes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'homeStayId': homeStayId,
      'homeStayName': homeStayName,
      'acreage': acreage,
      'description': description,
      'location': location?.toMap(),
      'services': services?.map((x) => x.toMap()).toList(),
      'imageHomes': imageHomes?.map((x) => x.toMap()).toList(),
    };
  }

  factory HomestayModel.fromMap(Map<String, dynamic> map) {
    return HomestayModel(
      homeStayId: map['homeStayId'] != null ? map['homeStayId'] as int : null,
      homeStayName:
          map['homeStayName'] != null ? map['homeStayName'] as String : null,
      acreage: map['acreage'] != null ? map['acreage'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      location: map['location'] != null
          ? LocationModel.fromMap(map['location'] as Map<String, dynamic>)
          : null,
      services: map['services'] != null
          ? List<ServiceModel>.from(
              (map['services'] as List<dynamic>).map<ServiceModel?>(
                (x) => ServiceModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      imageHomes: map['imageHomes'] != null
          ? List<ImageHomeModel>.from(
              (map['imageHomes'] as List<dynamic>).map<ImageHomeModel?>(
                (x) => ImageHomeModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomestayModel.fromJson(String source) =>
      HomestayModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HomestayModel(homeStayId: $homeStayId, homeStayName: $homeStayName, acreage: $acreage, description: $description, location: $location, services: $services, imageHomes: $imageHomes)';
  }

  @override
  bool operator ==(covariant HomestayModel other) {
    if (identical(this, other)) return true;

    return other.homeStayId == homeStayId &&
        other.homeStayName == homeStayName &&
        other.acreage == acreage &&
        other.description == description &&
        other.location == location &&
        listEquals(other.services, services) &&
        listEquals(other.imageHomes, imageHomes);
  }

  @override
  int get hashCode {
    return homeStayId.hashCode ^
        homeStayName.hashCode ^
        acreage.hashCode ^
        description.hashCode ^
        location.hashCode ^
        services.hashCode ^
        imageHomes.hashCode;
  }
}
