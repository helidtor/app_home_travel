// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserSignUpModel {
  String? userName;
  String? password;
  String? confirmPassword;
  String? gender;
  String? phoneNumber;
  String? email;
  String? firstName;
  String? lastName;
  UserSignUpModel({
    this.userName,
    this.password,
    this.confirmPassword,
    this.gender,
    this.phoneNumber,
    this.email,
    this.firstName,
    this.lastName,
  });

  UserSignUpModel copyWith({
    String? userName,
    String? password,
    String? confirmPassword,
    String? gender,
    String? phoneNumber,
    String? email,
    String? firstName,
    String? lastName,
  }) {
    return UserSignUpModel(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'password': password,
      'confirmPassword': confirmPassword,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  factory UserSignUpModel.fromMap(Map<String, dynamic> map) {
    return UserSignUpModel(
      userName: map['userName'] != null ? map['userName'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      confirmPassword: map['confirmPassword'] != null ? map['confirmPassword'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserSignUpModel.fromJson(String source) => UserSignUpModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserSignUpModel(userName: $userName, password: $password, confirmPassword: $confirmPassword, gender: $gender, phoneNumber: $phoneNumber, email: $email, firstName: $firstName, lastName: $lastName)';
  }

  @override
  bool operator ==(covariant UserSignUpModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.userName == userName &&
      other.password == password &&
      other.confirmPassword == confirmPassword &&
      other.gender == gender &&
      other.phoneNumber == phoneNumber &&
      other.email == email &&
      other.firstName == firstName &&
      other.lastName == lastName;
  }

  @override
  int get hashCode {
    return userName.hashCode ^
      password.hashCode ^
      confirmPassword.hashCode ^
      gender.hashCode ^
      phoneNumber.hashCode ^
      email.hashCode ^
      firstName.hashCode ^
      lastName.hashCode;
  }
}
