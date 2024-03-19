// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AmenitieModel {
  String? id;
  String? name;
  String? amenitieTitleId;
  AmenitieModel({
    this.id,
    this.name,
    this.amenitieTitleId,
  });

  AmenitieModel copyWith({
    String? id,
    String? name,
    String? amenitieTitleId,
  }) {
    return AmenitieModel(
      id: id ?? this.id,
      name: name ?? this.name,
      amenitieTitleId: amenitieTitleId ?? this.amenitieTitleId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'amenitieTitleId': amenitieTitleId,
    };
  }

  factory AmenitieModel.fromMap(Map<String, dynamic> map) {
    return AmenitieModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      amenitieTitleId: map['amenitieTitleId'] != null ? map['amenitieTitleId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AmenitieModel.fromJson(String source) => AmenitieModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AmenitieModel(id: $id, name: $name, amenitieTitleId: $amenitieTitleId)';

  @override
  bool operator ==(covariant AmenitieModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.amenitieTitleId == amenitieTitleId;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ amenitieTitleId.hashCode;
}
