// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserSignUpModel {
  String? dateOfBirth;
  String? password;
  bool? gender;
  String? phoneNumber;
  String? email;
  String? firstName;
  String? lastName;
  String? status;
  UserSignUpModel({
    this.dateOfBirth,
    this.password,
    this.gender,
    this.phoneNumber,
    this.email,
    this.firstName,
    this.lastName,
    this.status,
  });
  

  UserSignUpModel copyWith({
    String? dateOfBirth,
    String? password,
    bool? gender,
    String? phoneNumber,
    String? email,
    String? firstName,
    String? lastName,
    String? status,
  }) {
    return UserSignUpModel(
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      password: password ?? this.password,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dateOfBirth': dateOfBirth,
      'password': password,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'status': status,
    };
  }

  factory UserSignUpModel.fromMap(Map<String, dynamic> map) {
    return UserSignUpModel(
      dateOfBirth: map['dateOfBirth'] != null ? map['dateOfBirth'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      gender: map['gender'] != null ? map['gender'] as bool : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserSignUpModel.fromJson(String source) => UserSignUpModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserSignUpModel(dateOfBirth: $dateOfBirth, password: $password, gender: $gender, phoneNumber: $phoneNumber, email: $email, firstName: $firstName, lastName: $lastName, status: $status)';
  }

  @override
  bool operator ==(covariant UserSignUpModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.dateOfBirth == dateOfBirth &&
      other.password == password &&
      other.gender == gender &&
      other.phoneNumber == phoneNumber &&
      other.email == email &&
      other.firstName == firstName &&
      other.lastName == lastName &&
      other.status == status;
  }

  @override
  int get hashCode {
    return dateOfBirth.hashCode ^
      password.hashCode ^
      gender.hashCode ^
      phoneNumber.hashCode ^
      email.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      status.hashCode;
  }
}
