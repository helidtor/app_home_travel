// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:mobile_home_travel/models/homestay/policy/policy_model.dart';
import 'package:mobile_home_travel/models/homestay/policy/policy_title_model.dart';

class HomestayPolicySelectedModel {
  String? id;
  String? policyTitleId;
  String? policyId;
  String? homeStayId;
  PolicyTitleModel? policyTitle;
  PolicyModel? policy;
  HomestayPolicySelectedModel({
    this.id,
    this.policyTitleId,
    this.policyId,
    this.homeStayId,
    this.policyTitle,
    this.policy,
  });

  HomestayPolicySelectedModel copyWith({
    String? id,
    String? policyTitleId,
    String? policyId,
    String? homeStayId,
    PolicyTitleModel? policyTitle,
    PolicyModel? policy,
  }) {
    return HomestayPolicySelectedModel(
      id: id ?? this.id,
      policyTitleId: policyTitleId ?? this.policyTitleId,
      policyId: policyId ?? this.policyId,
      homeStayId: homeStayId ?? this.homeStayId,
      policyTitle: policyTitle ?? this.policyTitle,
      policy: policy ?? this.policy,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'policyTitleId': policyTitleId,
      'policyId': policyId,
      'homeStayId': homeStayId,
      'policyTitle': policyTitle?.toMap(),
      'policy': policy?.toMap(),
    };
  }

  factory HomestayPolicySelectedModel.fromMap(Map<String, dynamic> map) {
    return HomestayPolicySelectedModel(
      id: map['id'] != null ? map['id'] as String : null,
      policyTitleId:
          map['policyTitleId'] != null ? map['policyTitleId'] as String : null,
      policyId: map['policyId'] != null ? map['policyId'] as String : null,
      homeStayId:
          map['homeStayId'] != null ? map['homeStayId'] as String : null,
      policyTitle: map['policyTitle'] != null
          ? PolicyTitleModel.fromMap(map['policyTitle'] as Map<String, dynamic>)
          : null,
      policy: map['policy'] != null
          ? PolicyModel.fromMap(map['policy'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomestayPolicySelectedModel.fromJson(String source) =>
      HomestayPolicySelectedModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HomestayPolicySelectedModel(id: $id, policyTitleId: $policyTitleId, policyId: $policyId, homeStayId: $homeStayId, policyTitle: $policyTitle, policy: $policy)';
  }

  @override
  bool operator ==(covariant HomestayPolicySelectedModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.policyTitleId == policyTitleId &&
        other.policyId == policyId &&
        other.homeStayId == homeStayId &&
        other.policyTitle == policyTitle &&
        other.policy == policy;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        policyTitleId.hashCode ^
        policyId.hashCode ^
        homeStayId.hashCode ^
        policyTitle.hashCode ^
        policy.hashCode;
  }
}
