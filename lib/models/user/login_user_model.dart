// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserLoginModel {
  String? id;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? password;
  String? role;
  String? token;
  UserLoginModel({
    this.id,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.password,
    this.role,
    this.token,
  });
 

  UserLoginModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? password,
    String? role,
    String? token,
  }) {
    return UserLoginModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      role: role ?? this.role,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'password': password,
      'role': role,
      'token': token,
    };
  }

  factory UserLoginModel.fromMap(Map<String, dynamic> map) {
    return UserLoginModel(
      id: map['id'] != null ? map['id'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      role: map['role'] != null ? map['role'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLoginModel.fromJson(String source) => UserLoginModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserLoginModel(id: $id, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, password: $password, role: $role, token: $token)';
  }

  @override
  bool operator ==(covariant UserLoginModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.firstName == firstName &&
      other.lastName == lastName &&
      other.phoneNumber == phoneNumber &&
      other.password == password &&
      other.role == role &&
      other.token == token;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      phoneNumber.hashCode ^
      password.hashCode ^
      role.hashCode ^
      token.hashCode;
  }
}
