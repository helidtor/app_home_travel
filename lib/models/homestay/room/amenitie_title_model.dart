// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AmenitieTitleModel {
  String? id;
  String? name;
  AmenitieTitleModel({
    this.id,
    this.name,
  });

  AmenitieTitleModel copyWith({
    String? id,
    String? name,
  }) {
    return AmenitieTitleModel(
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

  factory AmenitieTitleModel.fromMap(Map<String, dynamic> map) {
    return AmenitieTitleModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AmenitieTitleModel.fromJson(String source) => AmenitieTitleModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AmenitieTitleModel(id: $id, name: $name)';

  @override
  bool operator ==(covariant AmenitieTitleModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
