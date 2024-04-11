// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mobile_home_travel/models/homestay/room/amenitie_title_model.dart';
import 'package:mobile_home_travel/models/homestay/room/room_amenitie_selecteds_model.dart';

class RoomAmenitieTitlesModel {
  String? id;
  String? roomId;
  String? amenitieTitleId;
  AmenitieTitleModel? amenitieTitle;
  List<RoomAmenitieSelectedsModel>? roomAmenitieSelecteds;
  RoomAmenitieTitlesModel({
    this.id,
    this.roomId,
    this.amenitieTitleId,
    this.amenitieTitle,
    this.roomAmenitieSelecteds,
  });

  RoomAmenitieTitlesModel copyWith({
    String? id,
    String? roomId,
    String? amenitieTitleId,
    AmenitieTitleModel? amenitieTitle,
    List<RoomAmenitieSelectedsModel>? roomAmenitieSelecteds,
  }) {
    return RoomAmenitieTitlesModel(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      amenitieTitleId: amenitieTitleId ?? this.amenitieTitleId,
      amenitieTitle: amenitieTitle ?? this.amenitieTitle,
      roomAmenitieSelecteds:
          roomAmenitieSelecteds ?? this.roomAmenitieSelecteds,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'roomId': roomId,
      'amenitieTitleId': amenitieTitleId,
      'amenitieTitle': amenitieTitle?.toMap(),
      'roomAmenitieSelecteds':
          roomAmenitieSelecteds?.map((x) => x.toMap()).toList(),
    };
  }

  factory RoomAmenitieTitlesModel.fromMap(Map<String, dynamic> map) {
    return RoomAmenitieTitlesModel(
      id: map['id'] != null ? map['id'] as String : null,
      roomId: map['roomId'] != null ? map['roomId'] as String : null,
      amenitieTitleId: map['amenitieTitleId'] != null
          ? map['amenitieTitleId'] as String
          : null,
      amenitieTitle: map['amenitieTitle'] != null
          ? AmenitieTitleModel.fromMap(
              map['amenitieTitle'] as Map<String, dynamic>)
          : null,
      roomAmenitieSelecteds: map['roomAmenitieSelecteds'] != null
          ? List<RoomAmenitieSelectedsModel>.from(
              (map['roomAmenitieSelecteds']).map<RoomAmenitieSelectedsModel?>(
                (x) => RoomAmenitieSelectedsModel.fromMap(
                    x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomAmenitieTitlesModel.fromJson(String source) =>
      RoomAmenitieTitlesModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RoomAmenitieTitlesModel(id: $id, roomId: $roomId, amenitieTitleId: $amenitieTitleId, amenitieTitle: $amenitieTitle, roomAmenitieSelecteds: $roomAmenitieSelecteds)';
  }

  @override
  bool operator ==(covariant RoomAmenitieTitlesModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.roomId == roomId &&
        other.amenitieTitleId == amenitieTitleId &&
        other.amenitieTitle == amenitieTitle &&
        listEquals(other.roomAmenitieSelecteds, roomAmenitieSelecteds);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        roomId.hashCode ^
        amenitieTitleId.hashCode ^
        amenitieTitle.hashCode ^
        roomAmenitieSelecteds.hashCode;
  }
}
