// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:mobile_home_travel/models/homestay/general_homestay/general_amenitie_model.dart';

class GeneralAmenitieSelectedsModel {
  String? id;
  String? generalAmenitieId;
  String? homeStayGeneralAmenitieTitleId;
  GeneralAmenitieModel? generalAmenitie;
  GeneralAmenitieSelectedsModel({
    this.id,
    this.generalAmenitieId,
    this.homeStayGeneralAmenitieTitleId,
    this.generalAmenitie,
  });

  GeneralAmenitieSelectedsModel copyWith({
    String? id,
    String? generalAmenitieId,
    String? homeStayGeneralAmenitieTitleId,
    GeneralAmenitieModel? generalAmenitie,
  }) {
    return GeneralAmenitieSelectedsModel(
      id: id ?? this.id,
      generalAmenitieId: generalAmenitieId ?? this.generalAmenitieId,
      homeStayGeneralAmenitieTitleId: homeStayGeneralAmenitieTitleId ?? this.homeStayGeneralAmenitieTitleId,
      generalAmenitie: generalAmenitie ?? this.generalAmenitie,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'generalAmenitieId': generalAmenitieId,
      'homeStayGeneralAmenitieTitleId': homeStayGeneralAmenitieTitleId,
      'generalAmenitie': generalAmenitie?.toMap(),
    };
  }

  factory GeneralAmenitieSelectedsModel.fromMap(Map<String, dynamic> map) {
    return GeneralAmenitieSelectedsModel(
      id: map['id'] != null ? map['id'] as String : null,
      generalAmenitieId: map['generalAmenitieId'] != null ? map['generalAmenitieId'] as String : null,
      homeStayGeneralAmenitieTitleId: map['homeStayGeneralAmenitieTitleId'] != null ? map['homeStayGeneralAmenitieTitleId'] as String : null,
      generalAmenitie: map['generalAmenitie'] != null ? GeneralAmenitieModel.fromMap(map['generalAmenitie'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GeneralAmenitieSelectedsModel.fromJson(String source) => GeneralAmenitieSelectedsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GeneralAmenitieSelectedsModel(id: $id, generalAmenitieId: $generalAmenitieId, homeStayGeneralAmenitieTitleId: $homeStayGeneralAmenitieTitleId, generalAmenitie: $generalAmenitie)';
  }

  @override
  bool operator ==(covariant GeneralAmenitieSelectedsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.generalAmenitieId == generalAmenitieId &&
      other.homeStayGeneralAmenitieTitleId == homeStayGeneralAmenitieTitleId &&
      other.generalAmenitie == generalAmenitie;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      generalAmenitieId.hashCode ^
      homeStayGeneralAmenitieTitleId.hashCode ^
      generalAmenitie.hashCode;
  }
}
