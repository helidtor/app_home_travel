// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ServiceModel {
  int? serviceId;
  String? serviceName;
  String? description;
  double? price;
  bool? status;
  ServiceModel({
    this.serviceId,
    this.serviceName,
    this.description,
    this.price,
    this.status,
  });

  ServiceModel copyWith({
    int? serviceId,
    String? serviceName,
    String? description,
    double? price,
    bool? status,
  }) {
    return ServiceModel(
      serviceId: serviceId ?? this.serviceId,
      serviceName: serviceName ?? this.serviceName,
      description: description ?? this.description,
      price: price ?? this.price,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'serviceId': serviceId,
      'serviceName': serviceName,
      'description': description,
      'price': price,
      'status': status,
    };
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      serviceId: map['serviceId'] != null ? map['serviceId'] as int : null,
      serviceName:
          map['serviceName'] != null ? map['serviceName'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      price: map['price'] != null ? map['price'] as double : null,
      status: map['status'] != null ? map['status'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceModel.fromJson(String source) =>
      ServiceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ServiceModel(serviceId: $serviceId, serviceName: $serviceName, description: $description, price: $price, status: $status)';
  }

  @override
  bool operator ==(covariant ServiceModel other) {
    if (identical(this, other)) return true;

    return other.serviceId == serviceId &&
        other.serviceName == serviceName &&
        other.description == description &&
        other.price == price &&
        other.status == status;
  }

  @override
  int get hashCode {
    return serviceId.hashCode ^
        serviceName.hashCode ^
        description.hashCode ^
        price.hashCode ^
        status.hashCode;
  }
}
