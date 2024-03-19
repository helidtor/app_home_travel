// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mobile_home_travel/models/homestay/general_amenitie_homestay/general_amenitie_selecteds_model.dart';
import 'package:mobile_home_travel/models/homestay/general_amenitie_homestay/general_amenitie_title_model.dart';

class HomeStayGeneralAmenitieTitlesModel {
  String? id;
  String? name;
  String? generalAmenitieTitleId;
  GeneralAmenitieTitleModel? generalAmenitieTitle;
  List<GeneralAmenitieSelectedsModel>? generalAmenitieSelecteds;
  HomeStayGeneralAmenitieTitlesModel({
    this.id,
    this.name,
    this.generalAmenitieTitleId,
    this.generalAmenitieTitle,
    this.generalAmenitieSelecteds,
  });

  HomeStayGeneralAmenitieTitlesModel copyWith({
    String? id,
    String? name,
    String? generalAmenitieTitleId,
    GeneralAmenitieTitleModel? generalAmenitieTitle,
    List<GeneralAmenitieSelectedsModel>? generalAmenitieSelecteds,
  }) {
    return HomeStayGeneralAmenitieTitlesModel(
      id: id ?? this.id,
      name: name ?? this.name,
      generalAmenitieTitleId:
          generalAmenitieTitleId ?? this.generalAmenitieTitleId,
      generalAmenitieTitle: generalAmenitieTitle ?? this.generalAmenitieTitle,
      generalAmenitieSelecteds:
          generalAmenitieSelecteds ?? this.generalAmenitieSelecteds,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'generalAmenitieTitleId': generalAmenitieTitleId,
      'generalAmenitieTitle': generalAmenitieTitle?.toMap(),
      'generalAmenitieSelecteds':
          generalAmenitieSelecteds?.map((x) => x.toMap()).toList(),
    };
  }

  factory HomeStayGeneralAmenitieTitlesModel.fromMap(Map<String, dynamic> map) {
    return HomeStayGeneralAmenitieTitlesModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      generalAmenitieTitleId: map['generalAmenitieTitleId'] != null
          ? map['generalAmenitieTitleId'] as String
          : null,
      generalAmenitieTitle: map['generalAmenitieTitle'] != null
          ? GeneralAmenitieTitleModel.fromMap(
              map['generalAmenitieTitle'] as Map<String, dynamic>)
          : null,
      generalAmenitieSelecteds: map['generalAmenitieSelecteds'] != null
          ? List<GeneralAmenitieSelectedsModel>.from(
              (map['generalAmenitieSelecteds'])
                  .map<GeneralAmenitieSelectedsModel?>(
                (x) => GeneralAmenitieSelectedsModel.fromMap(
                    x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeStayGeneralAmenitieTitlesModel.fromJson(String source) =>
      HomeStayGeneralAmenitieTitlesModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HomeStayGeneralAmenitieTitlesModel(id: $id, name: $name, generalAmenitieTitleId: $generalAmenitieTitleId, generalAmenitieTitle: $generalAmenitieTitle, generalAmenitieSelecteds: $generalAmenitieSelecteds)';
  }

  @override
  bool operator ==(covariant HomeStayGeneralAmenitieTitlesModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.generalAmenitieTitleId == generalAmenitieTitleId &&
        other.generalAmenitieTitle == generalAmenitieTitle &&
        listEquals(other.generalAmenitieSelecteds, generalAmenitieSelecteds);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        generalAmenitieTitleId.hashCode ^
        generalAmenitieTitle.hashCode ^
        generalAmenitieSelecteds.hashCode;
  }
}
