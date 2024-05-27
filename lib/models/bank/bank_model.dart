// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BankModel {
  String? name;
  String? code;
  String? shortName;
  String? logo;
  BankModel({
    this.name,
    this.code,
    this.shortName,
    this.logo,
  });

  BankModel copyWith({
    String? name,
    String? code,
    String? shortName,
    String? logo,
  }) {
    return BankModel(
      name: name ?? this.name,
      code: code ?? this.code,
      shortName: shortName ?? this.shortName,
      logo: logo ?? this.logo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'code': code,
      'shortName': shortName,
      'logo': logo,
    };
  }

  factory BankModel.fromMap(Map<String, dynamic> map) {
    return BankModel(
      name: map['name'] != null ? map['name'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
      shortName: map['shortName'] != null ? map['shortName'] as String : null,
      logo: map['logo'] != null ? map['logo'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BankModel.fromJson(String source) =>
      BankModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BankModel(name: $name, code: $code, shortName: $shortName, logo: $logo)';
  }

  @override
  bool operator ==(covariant BankModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.code == code &&
        other.shortName == shortName &&
        other.logo == logo;
  }

  @override
  int get hashCode {
    return name.hashCode ^ code.hashCode ^ shortName.hashCode ^ logo.hashCode;
  }
}
