// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LocationModel {
  int? locationId;
  String? cityName;
  String? districtName;
  String? provinceName;
  String? streetName;
  String? numberHome;
  int? homeStayId;
  LocationModel({
    this.locationId,
    this.cityName,
    this.districtName,
    this.provinceName,
    this.streetName,
    this.numberHome,
    this.homeStayId,
  });


  LocationModel copyWith({
    int? locationId,
    String? cityName,
    String? districtName,
    String? provinceName,
    String? streetName,
    String? numberHome,
    int? homeStayId,
  }) {
    return LocationModel(
      locationId: locationId ?? this.locationId,
      cityName: cityName ?? this.cityName,
      districtName: districtName ?? this.districtName,
      provinceName: provinceName ?? this.provinceName,
      streetName: streetName ?? this.streetName,
      numberHome: numberHome ?? this.numberHome,
      homeStayId: homeStayId ?? this.homeStayId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'locationId': locationId,
      'cityName': cityName,
      'districtName': districtName,
      'provinceName': provinceName,
      'streetName': streetName,
      'numberHome': numberHome,
      'homeStayId': homeStayId,
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      locationId: map['locationId'] != null ? map['locationId'] as int : null,
      cityName: map['cityName'] != null ? map['cityName'] as String : null,
      districtName: map['districtName'] != null ? map['districtName'] as String : null,
      provinceName: map['provinceName'] != null ? map['provinceName'] as String : null,
      streetName: map['streetName'] != null ? map['streetName'] as String : null,
      numberHome: map['numberHome'] != null ? map['numberHome'] as String : null,
      homeStayId: map['homeStayId'] != null ? map['homeStayId'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) => LocationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LocationModel(locationId: $locationId, cityName: $cityName, districtName: $districtName, provinceName: $provinceName, streetName: $streetName, numberHome: $numberHome, homeStayId: $homeStayId)';
  }

  @override
  bool operator ==(covariant LocationModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.locationId == locationId &&
      other.cityName == cityName &&
      other.districtName == districtName &&
      other.provinceName == provinceName &&
      other.streetName == streetName &&
      other.numberHome == numberHome &&
      other.homeStayId == homeStayId;
  }

  @override
  int get hashCode {
    return locationId.hashCode ^
      cityName.hashCode ^
      districtName.hashCode ^
      provinceName.hashCode ^
      streetName.hashCode ^
      numberHome.hashCode ^
      homeStayId.hashCode;
  }
}
