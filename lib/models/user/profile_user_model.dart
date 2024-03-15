// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserProfileModel {
  String? id;
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? phoneNumber;
  bool? gender;
  String? dateOfBirth;
  UserProfileModel({
    this.id,
    this.firstName,
    this.lastName,
    this.userName,
    this.email,
    this.phoneNumber,
    this.gender,
    this.dateOfBirth,
  });
  

  UserProfileModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? userName,
    String? email,
    String? phoneNumber,
    bool? gender,
    String? dateOfBirth,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
    };
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      id: map['id'] != null ? map['id'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      userName: map['userName'] != null ? map['userName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      gender: map['gender'] != null ? map['gender'] as bool : null,
      dateOfBirth: map['dateOfBirth'] != null ? map['dateOfBirth'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfileModel.fromJson(String source) => UserProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserProfileModel(id: $id, firstName: $firstName, lastName: $lastName, userName: $userName, email: $email, phoneNumber: $phoneNumber, gender: $gender, dateOfBirth: $dateOfBirth)';
  }

  @override
  bool operator ==(covariant UserProfileModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.firstName == firstName &&
      other.lastName == lastName &&
      other.userName == userName &&
      other.email == email &&
      other.phoneNumber == phoneNumber &&
      other.gender == gender &&
      other.dateOfBirth == dateOfBirth;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      userName.hashCode ^
      email.hashCode ^
      phoneNumber.hashCode ^
      gender.hashCode ^
      dateOfBirth.hashCode;
  }
}
