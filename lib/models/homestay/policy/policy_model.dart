// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PolicyModel {
  String? id;
  String? description;
  String? subDescription;
  String? policyTitleId;
  PolicyModel({
    this.id,
    this.description,
    this.subDescription,
    this.policyTitleId,
  });

  PolicyModel copyWith({
    String? id,
    String? description,
    String? subDescription,
    String? policyTitleId,
  }) {
    return PolicyModel(
      id: id ?? this.id,
      description: description ?? this.description,
      subDescription: subDescription ?? this.subDescription,
      policyTitleId: policyTitleId ?? this.policyTitleId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'subDescription': subDescription,
      'policyTitleId': policyTitleId,
    };
  }

  factory PolicyModel.fromMap(Map<String, dynamic> map) {
    return PolicyModel(
      id: map['id'] != null ? map['id'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      subDescription: map['subDescription'] != null ? map['subDescription'] as String : null,
      policyTitleId: map['policyTitleId'] != null ? map['policyTitleId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PolicyModel.fromJson(String source) => PolicyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PolicyModel(id: $id, description: $description, subDescription: $subDescription, policyTitleId: $policyTitleId)';
  }

  @override
  bool operator ==(covariant PolicyModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.description == description &&
      other.subDescription == subDescription &&
      other.policyTitleId == policyTitleId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      description.hashCode ^
      subDescription.hashCode ^
      policyTitleId.hashCode;
  }
}
