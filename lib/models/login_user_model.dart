// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserLoginModel {
  String? firstName;
  String? lastName;
  String? username;
  String? password;
  String? email;
  String? phone;
  String? token;
  String? status;
  UserLoginModel({
    this.firstName,
    this.lastName,
    this.username,
    this.password,
    this.email,
    this.phone,
    this.token,
    this.status,
  });

  UserLoginModel copyWith({
    String? firstName,
    String? lastName,
    String? username,
    String? password,
    String? email,
    String? phone,
    String? token,
    String? status,
  }) {
    return UserLoginModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      token: token ?? this.token,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'password': password,
      'email': email,
      'phone': phone,
      'token': token,
      'status': status,
    };
  }

  factory UserLoginModel.fromMap(Map<String, dynamic> map) {
    return UserLoginModel(
      firstName: map['firstName'] != null ? map['firstName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserLoginModel.fromJson(String source) => UserLoginModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserLoginModel(firstName: $firstName, lastName: $lastName, username: $username, password: $password, email: $email, phone: $phone, token: $token, status: $status)';
  }

  @override
  bool operator ==(covariant UserLoginModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.firstName == firstName &&
      other.lastName == lastName &&
      other.username == username &&
      other.password == password &&
      other.email == email &&
      other.phone == phone &&
      other.token == token &&
      other.status == status;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
      lastName.hashCode ^
      username.hashCode ^
      password.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      token.hashCode ^
      status.hashCode;
  }
}
