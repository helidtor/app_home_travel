// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BookingHomestayDetail {
  double? price;
  String? roomId;
  String? bookingId;
  BookingHomestayDetail({
    this.price,
    this.roomId,
    this.bookingId,
  });

  BookingHomestayDetail copyWith({
    double? price,
    String? roomId,
    String? bookingId,
  }) {
    return BookingHomestayDetail(
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

  factory BookingHomestayDetail.fromMap(Map<String, dynamic> map) {
    return BookingHomestayDetail(
      price: map['price'] != null ? map['price'] as double : null,
      roomId: map['roomId'] != null ? map['roomId'] as String : null,
      bookingId: map['bookingId'] != null ? map['bookingId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingHomestayDetail.fromJson(String source) => BookingHomestayDetail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'BookingHomestayDetail(price: $price, roomId: $roomId, bookingId: $bookingId)';

  @override
  bool operator ==(covariant BookingHomestayDetail other) {
    if (identical(this, other)) return true;
  
    return 
      other.price == price &&
      other.roomId == roomId &&
      other.bookingId == bookingId;
  }

  @override
  int get hashCode => price.hashCode ^ roomId.hashCode ^ bookingId.hashCode;
}
