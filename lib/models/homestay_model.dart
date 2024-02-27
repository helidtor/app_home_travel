// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mobile_home_travel/models/location_model.dart';
import 'package:mobile_home_travel/models/service_model.dart';

class HomestayModel {
  int? homeStayId;
  String? homeStayName;
  String? acreage;
  LocationModel? location;
  List<ServiceModel>? services;
  HomestayModel({
    this.homeStayId,
    this.homeStayName,
    this.acreage,
    this.location,
    this.services,
  });

  HomestayModel copyWith({
    int? homeStayId,
    String? homeStayName,
    String? acreage,
    LocationModel? location,
    List<ServiceModel>? services,
  }) {
    return HomestayModel(
      homeStayId: homeStayId ?? this.homeStayId,
      homeStayName: homeStayName ?? this.homeStayName,
      acreage: acreage ?? this.acreage,
      location: location ?? this.location,
      services: services ?? this.services,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'homeStayId': homeStayId,
      'homeStayName': homeStayName,
      'acreage': acreage,
      'location': location?.toMap(),
      'services': services?.map((x) => x.toMap()).toList(),
    };
  }

  factory HomestayModel.fromMap(Map<String, dynamic> map) {
    return HomestayModel(
      homeStayId: map['homeStayId'] != null ? map['homeStayId'] as int : null,
      homeStayName:
          map['homeStayName'] != null ? map['homeStayName'] as String : null,
      acreage: map['acreage'] != null ? map['acreage'] as String : null,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory HomestayModel.fromJson(String source) =>
      HomestayModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HomestayModel(homeStayId: $homeStayId, homeStayName: $homeStayName, acreage: $acreage, location: $location, services: $services)';
  }

  @override
  bool operator ==(covariant HomestayModel other) {
    if (identical(this, other)) return true;

    return other.homeStayId == homeStayId &&
        other.homeStayName == homeStayName &&
        other.acreage == acreage &&
        other.location == location &&
        listEquals(other.services, services);
  }

  @override
  int get hashCode {
    return homeStayId.hashCode ^
        homeStayName.hashCode ^
        acreage.hashCode ^
        location.hashCode ^
        services.hashCode;
  }
}
