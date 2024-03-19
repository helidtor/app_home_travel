// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GeneralAmenitieModel {
  String? id;
  String? name;
  String? generalAmenitieTitleId;
  GeneralAmenitieModel({
    this.id,
    this.name,
    this.generalAmenitieTitleId,
  });

  GeneralAmenitieModel copyWith({
    String? id,
    String? name,
    String? generalAmenitieTitleId,
  }) {
    return GeneralAmenitieModel(
      id: id ?? this.id,
      name: name ?? this.name,
      generalAmenitieTitleId: generalAmenitieTitleId ?? this.generalAmenitieTitleId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'generalAmenitieTitleId': generalAmenitieTitleId,
    };
  }

  factory GeneralAmenitieModel.fromMap(Map<String, dynamic> map) {
    return GeneralAmenitieModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      generalAmenitieTitleId: map['generalAmenitieTitleId'] != null ? map['generalAmenitieTitleId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GeneralAmenitieModel.fromJson(String source) => GeneralAmenitieModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GeneralAmenitieModel(id: $id, name: $name, generalAmenitieTitleId: $generalAmenitieTitleId)';

  @override
  bool operator ==(covariant GeneralAmenitieModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.generalAmenitieTitleId == generalAmenitieTitleId;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ generalAmenitieTitleId.hashCode;
}
