// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GeneralAmenitieTitleModel {
  String? id;
  String? name;
  GeneralAmenitieTitleModel({
    this.id,
    this.name,
  });

  GeneralAmenitieTitleModel copyWith({
    String? id,
    String? name,
  }) {
    return GeneralAmenitieTitleModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory GeneralAmenitieTitleModel.fromMap(Map<String, dynamic> map) {
    return GeneralAmenitieTitleModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GeneralAmenitieTitleModel.fromJson(String source) => GeneralAmenitieTitleModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GeneralAmenitieTitleModel(id: $id, name: $name)';

  @override
  bool operator ==(covariant GeneralAmenitieTitleModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
