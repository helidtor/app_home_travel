// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:mobile_home_travel/models/homestay/room/amenitie_model.dart';

class RoomAmenitieSelectedsModel {
  String? id;
  String? amenitieId;
  String? roomAmenitieTitleId;
  AmenitieModel? amenitie;
  RoomAmenitieSelectedsModel({
    this.id,
    this.amenitieId,
    this.roomAmenitieTitleId,
    this.amenitie,
  });

  RoomAmenitieSelectedsModel copyWith({
    String? id,
    String? amenitieId,
    String? roomAmenitieTitleId,
    AmenitieModel? amenitie,
  }) {
    return RoomAmenitieSelectedsModel(
      id: id ?? this.id,
      amenitieId: amenitieId ?? this.amenitieId,
      roomAmenitieTitleId: roomAmenitieTitleId ?? this.roomAmenitieTitleId,
      amenitie: amenitie ?? this.amenitie,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amenitieId': amenitieId,
      'roomAmenitieTitleId': roomAmenitieTitleId,
      'amenitie': amenitie?.toMap(),
    };
  }

  factory RoomAmenitieSelectedsModel.fromMap(Map<String, dynamic> map) {
    return RoomAmenitieSelectedsModel(
      id: map['id'] != null ? map['id'] as String : null,
      amenitieId: map['amenitieId'] != null ? map['amenitieId'] as String : null,
      roomAmenitieTitleId: map['roomAmenitieTitleId'] != null ? map['roomAmenitieTitleId'] as String : null,
      amenitie: map['amenitie'] != null ? AmenitieModel.fromMap(map['amenitie'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomAmenitieSelectedsModel.fromJson(String source) => RoomAmenitieSelectedsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RoomAmenitieSelectedsModel(id: $id, amenitieId: $amenitieId, roomAmenitieTitleId: $roomAmenitieTitleId, amenitie: $amenitie)';
  }

  @override
  bool operator ==(covariant RoomAmenitieSelectedsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.amenitieId == amenitieId &&
      other.roomAmenitieTitleId == roomAmenitieTitleId &&
      other.amenitie == amenitie;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      amenitieId.hashCode ^
      roomAmenitieTitleId.hashCode ^
      amenitie.hashCode;
  }
}
