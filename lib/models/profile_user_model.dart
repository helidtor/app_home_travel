// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserProfileModel {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? passwordHash;
  String? email;
  String? phoneNumber;
  String? avatar;
  String? status;
  UserProfileModel({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.passwordHash,
    this.email,
    this.phoneNumber,
    this.avatar,
    this.status,
  });

  UserProfileModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? username,
    String? passwordHash,
    String? email,
    String? phoneNumber,
    String? avatar,
    String? status,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      passwordHash: passwordHash ?? this.passwordHash,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatar: avatar ?? this.avatar,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'passwordHash': passwordHash,
      'email': email,
      'phoneNumber': phoneNumber,
      'avatar': avatar,
      'status': status,
    };
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      id: map['id'] != null ? map['id'] as int : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      passwordHash:
          map['passwordHash'] != null ? map['passwordHash'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileModel.fromJson(String source) =>
      UserProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserProfileModel(id: $id, firstName: $firstName, lastName: $lastName, username: $username, passwordHash: $passwordHash, email: $email, phoneNumber: $phoneNumber, avatar: $avatar, status: $status)';
  }

  @override
  bool operator ==(covariant UserProfileModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.username == username &&
        other.passwordHash == passwordHash &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.avatar == avatar &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        username.hashCode ^
        passwordHash.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        avatar.hashCode ^
        status.hashCode;
  }
}
