// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CreateBookingDetailModel {
  num? price;
  String? roomId;
  String? bookingId;
  CreateBookingDetailModel({
    this.price,
    this.roomId,
    this.bookingId,
  });

  CreateBookingDetailModel copyWith({
    num? price,
    String? roomId,
    String? bookingId,
  }) {
    return CreateBookingDetailModel(
      price: price ?? this.price,
      roomId: roomId ?? this.roomId,
      bookingId: bookingId ?? this.bookingId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'price': price,
      'roomId': roomId,
      'bookingId': bookingId,
    };
  }

  factory CreateBookingDetailModel.fromMap(Map<String, dynamic> map) {
    return CreateBookingDetailModel(
      price: map['price'] != null ? map['price'] as num : null,
      roomId: map['roomId'] != null ? map['roomId'] as String : null,
      bookingId: map['bookingId'] != null ? map['bookingId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateBookingDetailModel.fromJson(String source) =>
      CreateBookingDetailModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CreateBookingDetailModel(price: $price, roomId: $roomId, bookingId: $bookingId)';

  @override
  bool operator ==(covariant CreateBookingDetailModel other) {
    if (identical(this, other)) return true;

    return other.price == price &&
        other.roomId == roomId &&
        other.bookingId == bookingId;
  }

  @override
  int get hashCode => price.hashCode ^ roomId.hashCode ^ bookingId.hashCode;
}
