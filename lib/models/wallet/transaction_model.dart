// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TransactionModel {
  String? id;
  num? price;
  String? status;
  String? type;
  String? createdDate;
  String? bookingId;
  String? walletId;
  TransactionModel({
    this.id,
    this.price,
    this.status,
    this.type,
    this.createdDate,
    this.bookingId,
    this.walletId,
  });

  TransactionModel copyWith({
    String? id,
    num? price,
    String? status,
    String? type,
    String? createdDate,
    String? bookingId,
    String? walletId,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      price: price ?? this.price,
      status: status ?? this.status,
      type: type ?? this.type,
      createdDate: createdDate ?? this.createdDate,
      bookingId: bookingId ?? this.bookingId,
      walletId: walletId ?? this.walletId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'price': price,
      'status': status,
      'type': type,
      'createdDate': createdDate,
      'bookingId': bookingId,
      'walletId': walletId,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] != null ? map['id'] as String : null,
      price: map['price'] != null ? map['price'] as num : null,
      status: map['status'] != null ? map['status'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      createdDate: map['createdDate'] != null ? map['createdDate'] as String : null,
      bookingId: map['bookingId'] != null ? map['bookingId'] as String : null,
      walletId: map['walletId'] != null ? map['walletId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) => TransactionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TransactionModel(id: $id, price: $price, status: $status, type: $type, createdDate: $createdDate, bookingId: $bookingId, walletId: $walletId)';
  }

  @override
  bool operator ==(covariant TransactionModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.price == price &&
      other.status == status &&
      other.type == type &&
      other.createdDate == createdDate &&
      other.bookingId == bookingId &&
      other.walletId == walletId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      price.hashCode ^
      status.hashCode ^
      type.hashCode ^
      createdDate.hashCode ^
      bookingId.hashCode ^
      walletId.hashCode;
  }
}
