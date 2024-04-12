// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/models/homestay/room/room_model.dart';

class BookingDetailModel {
  String? id;
  num? price;
  String? roomId;
  String? bookingId;
  RoomModel? room;
  BookingHomestayModel? booking;
  BookingDetailModel({
    this.id,
    this.price,
    this.roomId,
    this.bookingId,
    this.room,
    this.booking,
  });

  BookingDetailModel copyWith({
    String? id,
    num? price,
    String? roomId,
    String? bookingId,
    RoomModel? room,
    BookingHomestayModel? booking,
  }) {
    return BookingDetailModel(
      id: id ?? this.id,
      price: price ?? this.price,
      roomId: roomId ?? this.roomId,
      bookingId: bookingId ?? this.bookingId,
      room: room ?? this.room,
      booking: booking ?? this.booking,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'price': price,
      'roomId': roomId,
      'bookingId': bookingId,
      'room': room?.toMap(),
      'booking': booking?.toMap(),
    };
  }

  factory BookingDetailModel.fromMap(Map<String, dynamic> map) {
    return BookingDetailModel(
      id: map['id'] != null ? map['id'] as String : null,
      price: map['price'] != null ? map['price'] as num : null,
      roomId: map['roomId'] != null ? map['roomId'] as String : null,
      bookingId: map['bookingId'] != null ? map['bookingId'] as String : null,
      room: map['room'] != null ? RoomModel.fromMap(map['room']) : null,
      booking: map['booking'] != null
          ? BookingHomestayModel.fromMap(map['booking'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingDetailModel.fromJson(String source) =>
      BookingDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BookingDetailModel(id: $id, price: $price, roomId: $roomId, bookingId: $bookingId, room: $room, booking: $booking)';
  }

  @override
  bool operator ==(covariant BookingDetailModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.price == price &&
        other.roomId == roomId &&
        other.bookingId == bookingId &&
        other.room == room &&
        other.booking == booking;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        price.hashCode ^
        roomId.hashCode ^
        bookingId.hashCode ^
        room.hashCode ^
        booking.hashCode;
  }
}
