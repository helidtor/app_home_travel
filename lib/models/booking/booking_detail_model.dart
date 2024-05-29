// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:mobile_home_travel/models/booking/booking_homestay_model.dart';
import 'package:mobile_home_travel/models/homestay/room/room_model.dart';

class BookingDetailModel {
  String? id;
  num? price;
  String? roomId;
  String? bookingId;
  String? startDate;
  String? endDate;
  num? totalPrice;
  RoomModel? room;
  BookingHomestayModel? booking;
  BookingDetailModel({
    this.id,
    this.price,
    this.roomId,
    this.bookingId,
    this.startDate,
    this.endDate,
    this.totalPrice,
    this.room,
    this.booking,
  });

  BookingDetailModel copyWith({
    String? id,
    num? price,
    String? roomId,
    String? bookingId,
    String? startDate,
    String? endDate,
    num? totalPrice,
    RoomModel? room,
    BookingHomestayModel? booking,
  }) {
    return BookingDetailModel(
      id: id ?? this.id,
      price: price ?? this.price,
      roomId: roomId ?? this.roomId,
      bookingId: bookingId ?? this.bookingId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      totalPrice: totalPrice ?? this.totalPrice,
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
      'startDate': startDate,
      'endDate': endDate,
      'totalPrice': totalPrice,
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
      startDate: map['startDate'] != null ? map['startDate'] as String : null,
      endDate: map['endDate'] != null ? map['endDate'] as String : null,
      totalPrice: map['totalPrice'] != null ? map['totalPrice'] as num : null,
      room: map['room'] != null ? RoomModel.fromMap(map['room'] as Map<String,dynamic>) : null,
      booking: map['booking'] != null ? BookingHomestayModel.fromMap(map['booking'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingDetailModel.fromJson(String source) =>
      BookingDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BookingDetailModel(id: $id, price: $price, roomId: $roomId, bookingId: $bookingId, startDate: $startDate, endDate: $endDate, totalPrice: $totalPrice, room: $room, booking: $booking)';
  }

  @override
  bool operator ==(covariant BookingDetailModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.price == price &&
      other.roomId == roomId &&
      other.bookingId == bookingId &&
      other.startDate == startDate &&
      other.endDate == endDate &&
      other.totalPrice == totalPrice &&
      other.room == room &&
      other.booking == booking;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      price.hashCode ^
      roomId.hashCode ^
      bookingId.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      totalPrice.hashCode ^
      room.hashCode ^
      booking.hashCode;
  }
}
