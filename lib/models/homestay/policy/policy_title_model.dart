// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:mobile_home_travel/models/homestay/policy/policy_model.dart';

class PolicyTitleModel {
  String? id;
  String? name;
  List<PolicyModel>? policies;
  PolicyTitleModel({
    this.id,
    this.name,
    this.policies,
  });

  PolicyTitleModel copyWith({
    String? id,
    String? name,
    List<PolicyModel>? policies,
  }) {
    return PolicyTitleModel(
      id: id ?? this.id,
      name: name ?? this.name,
      policies: policies ?? this.policies,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'policies': policies?.map((x) => x.toMap()).toList(),
    };
  }

  factory PolicyTitleModel.fromMap(Map<String, dynamic> map) {
    return PolicyTitleModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      policies: map['policies'] != null
          ? List<PolicyModel>.from(
              (map['policies']).map<PolicyModel?>(
                (x) => PolicyModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PolicyTitleModel.fromJson(String source) =>
      PolicyTitleModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PolicyTitleModel(id: $id, name: $name, policies: $policies)';

  @override
  bool operator ==(covariant PolicyTitleModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        listEquals(other.policies, policies);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ policies.hashCode;
}
